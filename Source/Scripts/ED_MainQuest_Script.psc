Scriptname ED_MainQuest_Script extends Quest  

import CustomSkills

; should be true when player is vampire, false when not/cured.
; set to true on first call of GainAgeExpirience()
bool isAging
bool HasShownAgeMessage
int NextMessageIndex = 0
int property MaxAge auto





int property BaseSkillLevel = 10 auto

perk[] property Age_Scaling_Perk_List auto

message property ED_Mechanics_Message_AgeLvlUpNotification auto
message[] property Age_Message_List auto

float __currentExpBuffer
event OnUpdate()
	__currentExpBuffer =  playerRef.GetActorValue("ED_VampireSkillExpBuffer")
	
	if __currentExpBuffer > 0
		CustomSkills.AdvanceSkill("EverdamnedMain", __currentExpBuffer)
		playerRef.DamageAV("ED_VampireSkillExpBuffer", __currentExpBuffer)
		debug.Trace("Everdamned DEBUG: Player had this much XP to absorb: " + __currentExpBuffer)
	endif
	
	if isAging
		RegisterForUpdate(2.0)
	endif
endevent

function PlayerBecameVampire()
	GainAgeExpirience(0.0)
	RewardBlueBloodRewardsIfNeeded()
	
	; initial skill level
	__lastUpdateSkillLevel = BaseSkillLevel
	ED_Mechanics_SkillTree_Level_Global.SetValue(BaseSkillLevel)
	
	; absorbing exp
	playerRef.SetActorValue("ED_VampireSkillExpBuffer", 3000.0)
	playerRef.DamageActorValue("ED_VampireSkillExpBuffer", 3000.0)
	
	CustomSkills_FormExt.RegisterForCustomSkillIncrease(self)
	
	; giving 2 starting perk points
	ED_Mechanics_SkillTree_PerkPointsGrantedTotal_Global.SetValue(2)
	ED_Mechanics_SkillTree_PerkPoints_Global.SetValue(2)
	DLC1VampirePerkPoints.SetValue(0)
	
	;Wine and Revelry
	if playerRef.GetActorValue("Alchemy") < 50.0
		debug.Trace("Everdamned DEBUG: Player vampire Alchemy skill is less than 50, registring OnSkillUpdate")
		PO3_Events_Form.RegisterForSkillIncrease(self)
	endif
	
	RegisterForUpdate(2.0)
endfunction

function OnUpdateGameTime()
	self.GainAgeExpirience(1.00000)
	; default is once every game hour
	self.RegisterforSingleUpdateGameTime(ED_Mechanics_VampireAgeRate.value)
endFunction

; in hours
float function CalculateNextLvlThreshold(int currentAge)
	float _increment = ED_Mechanics_VampireAgeLvlUpExpIncrement.value
	; previous age threshold + current age*increment
	return (2.0*(currentAge as float)*_increment) - _increment
endfunction

function GainAgeExpirience(float amountToAge = 0.0)
	
	if !isAging
		; called for first time since becoming vamp (again)
		; giving Fledgling stuff
		debug.Trace("Everdamned INFO: Player vampire starts aging, current age is " + ED_Mechanics_VampireAge.value + ", max age is " + MaxAge)
		SetUpAgeAppropriateRewards()
		isAging = true
		; give
		RegisterForSleep()
		RegisterforSingleUpdateGameTime(ED_Mechanics_VampireAgeRate.value)
	endif
	if amountToAge > 0.0
		ED_Mechanics_VampireAgeCurrentExp.Mod(amountToAge*ED_Mechanics_VampireAgeExpMult.GetValue())
		if ED_Mechanics_VampireAgeCurrentExp.value >= ED_Mechanics_VampireAgeCurrentLvlUpThreshold.value
			if !HasShownAgeMessage
				debug.Trace("Everdamned INFO: Player vampire just hit aging threshold on current age of " + ED_Mechanics_VampireAge.value + ", waiting for sleep to do lvlup")
				ED_Art_SoundM_AdvanceAge.Play(playerRef)
				ED_Mechanics_Message_AgeLvlUpNotification.Show()
				HasShownAgeMessage = true
			endif
		endif
	endif
endfunction

event OnSleepStop(Bool abInterrupted)
	
	ED_Mechanics_Global_ChainedBeastAllowed.SetValue(1.0)
	
	if abInterrupted || !HasShownAgeMessage
		return
	endif
	
	debug.Trace("Everdamned INFO: Player vampire is aging upon waking up from current age of " + ED_Mechanics_VampireAge.value)
	LvlUpAge()
	Age_Message_List[NextMessageIndex].Show()
	ED_BloodPoolManager_Quest.AtStageOrAgeChange()
	
	if ED_Mechanics_VampireAge.value >= MaxAge
		debug.Trace("Everdamned INFO: Player vampire has reached max age currently set as " + MaxAge + ", stopping aging")
		StopAge()
		return
	endif
	
	NextMessageIndex += 1
	HasShownAgeMessage = false
	debug.Trace("Everdamned INFO: Player vampire has aged to current age of " + ED_Mechanics_VampireAge.value)
endevent


function LvlUpAge()
	ED_Mechanics_VampireAge.Mod(1)
	ED_Mechanics_VampireAgeCurrentExp.value = 0.0
	ED_Mechanics_VampireAgeCurrentLvlUpThreshold.value = CalculateNextLvlThreshold((ED_Mechanics_VampireAge.value) as int)
	
	ED_Mechanics_SkillTree_PerkPoints_Global.Mod(2.0)
	ED_Mechanics_SkillTree_PerkPointsGrantedTotal_Global.Mod(2.0)
	DLC1VampirePerkPoints.Mod(2.0)
	DLC1VampireTotalPerksEarned.Mod(2.0)
	
	SetUpAgeAppropriateRewards()
	
endfunction 

function SetUpAgeAppropriateRewards()
	int _currentAge = (ED_Mechanics_VampireAge.value) as int
	if _currentAge < 1 || _currentAge > MaxAge
		debug.Trace("Everdamned ERROR: in SetUpAgeAppropriateRewards Vampire Age seems to be out of less than 1 or more than MaxAge that is currently " + MaxAge)
	endif
	; indexing from 0
	int _currentAgeIndex = _currentAge - 1
	int _maxIndex = MaxAge - 1
	
	int i = 0
	while i < _maxIndex
	
		;display ability spells are attached to perk
		perk _agePerk = Age_Scaling_Perk_List[i]
		
		if i == _currentAgeIndex
			playerRef.addperk(_agePerk)
		else
			playerRef.removeperk(_agePerk)
		endif
		ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
		
		i += 1
	endWhile
	
	if playerRef.HasPerk(ED_PerkTree_Disciplines_30_DeadlyStrength_Perk)
		playerRef.RemoveSpell(ED_Mechanics_UnlockDisplayAb_Potence)
		playerRef.AddSpell(ED_Mechanics_UnlockDisplayAb_Potence, false)
	endif
	
	
endfunction


function StopAge()

	UnregisterForSleep()
	UnregisterForUpdateGameTime()
	IsAging = false
	HasShownAgeMessage = false
	NextMessageIndex = 0
	
	debug.Trace("Everdamned INFO: Player vampire has stopped aging")
endFunction

function TearDownRewards()
	debug.Trace("Everdamned INFO: Main Quest reward teardown called")
	
	; age stuff
	
	StopAge()
	
	ED_Mechanics_VampireAge.value = 1
	
	ED_Mechanics_VampireAgeCurrentExp.value = 0.0
	ED_Mechanics_VampireAgeCurrentLvlUpThreshold.value = ED_Mechanics_VampireAgeLvlUpExpIncrement.value
	
	int _maxIndex = MaxAge - 1
	int i = 0
	while i < _maxIndex
		perk _agePerk = Age_Scaling_Perk_List[i]	
		playerRef.removeperk(_agePerk)
		i += 1
	endWhile
	
	; all perk rewards are contained in perks
	; all vampire spells are either removed in VampireCure() or are contained in Age perks

	i = 0
	int __listSize
	perk __perkToDelete
	
	__listSize = ED_Mechanics_FormList_MortalPerkTreePerks.GetSize() 
	
	while i < __listSize
		__perkToDelete = ED_Mechanics_FormList_MortalPerkTreePerks.GetAt(i) as perk
		playerRef.RemovePerk(__perkToDelete)
		i += 1
	endwhile
	
	;i = 0
	;__listSize = ED_Mechanics_FormList_VLPerkTreePerks.GetSize() 
	
	;while i < __listSize
	;	__perkToDelete = ED_Mechanics_FormList_VLPerkTreePerks.GetAt(i) as perk
	;	playerRef.RemovePerk(__perkToDelete)
	;	i += 1
	;endwhile
	
	spell __spellToRemove
	i = 0
	__listSize = ED_Mechanics_FormList_HemomancyRewards.GetSize() 
	while i < __listSize
		__spellToRemove = ED_Mechanics_FormList_HemomancyRewards.GetAt(i) as spell
		playerRef.RemoveSpell(__spellToRemove)
		i += 1
	endwhile
	
	i = 0
	__listSize = ED_Mechanics_FormList_SpellCleanup.GetSize() 
	while i < __listSize
		__spellToRemove = ED_Mechanics_FormList_SpellCleanup.GetAt(i) as spell
		playerRef.RemoveSpell(__spellToRemove)
		i += 1
	endwhile
	
	playerRef.removeperk(ED_Mechanics_Ab_ChainedBeast_Perk)
	playerRef.removeperk(ED_Mechanics_Ab_ChainedBeast_EmbraceTheBeast_Perk)
	
	CustomSkills_FormExt.UnregisterForCustomSkillIncrease(self)
	
endfunction

; needed in case of re-embracing, would be dull to make people do Blue Blood from scratch
function RewardBlueBloodRewardsIfNeeded()
	
	if ED_Mechanics_BlueBlood_Global_ChainedBeastAwarded.GetValue() as int == 1
		playerRef.addperk(ED_Mechanics_Ab_ChainedBeast_Perk)
		playerRef.addspell(ED_Mechanics_Ab_ChainedBeast_Spell)
		debug.Trace("Everdamned DEBUG: Main quest rewarded player with Chained Beast because they had it previously")
	endif
	
	if ED_Mechanics_BlueBlood_Global_EmbraceTheBeastAwarded.GetValue() as int == 1
		playerRef.addperk(ED_Mechanics_Ab_ChainedBeast_EmbraceTheBeast_Perk)
		debug.Trace("Everdamned DEBUG: Main quest rewarded player with Embrace The Beast because they had it previously")
	endif
	
endfunction

bool __skillLvlupLock
int __lastUpdateSkillLevel
Event OnCustomSkillIncrease(string asSkillId)
	
	if asSkillId != "EverdamnedMain"
		return
	endif
	
	; is a race condition, but do not know of another way to do this
	; adding XP directly, even here, INSIDE papyrus skill increment event
	; will actually show up on HUD message and properly proc levelup and rest
	int __levelXPMult = ED_Mechanics_SkillTree_DenominatorXP_Global.GetValue() as int
	int __newSkillLevel = ED_Mechanics_SkillTree_Level_Global.GetValue() as int
	debug.Trace("Everdamned DEBUG: Main Quest levep xp mult: " + __levelXPMult + ", __newSkillLevel: " + __newSkillLevel)
	ED_SKSEnativebindings.AddThisMuchXP(__newSkillLevel*__levelXPMult)
	debug.Trace("Everdamned DEBUG: Main Quest adds level XP at skill lvlup: " + __newSkillLevel*__levelXPMult)
	
	
	int cntr
	while __skillLvlupLock && cntr < 50
		cntr += 1
		utility.wait(0.1)
	endwhile
	
	if cntr >= 50
		debug.Trace("Everdamned ERROR: Custom Skill Update event waited more than 5 seconds, wtf!!!!!")
		return
	endif
	
	__skillLvlupLock = true
	
	if __newSkillLevel == __lastUpdateSkillLevel
		debug.Trace("Everdamned INFO: Custom Skill Update event exits because its same skill level of " + __newSkillLevel)
		__skillLvlupLock = false
		return
	endif
	__lastUpdateSkillLevel = __newSkillLevel
	
	debug.Trace("Everdamned INFO: Vampire skill just leveld up! new skill level: " + __newSkillLevel)
	
	int __alreadyGrantedPerkPoints = ED_Mechanics_SkillTree_PerkPointsGrantedTotal_Global.GetValue() as int
	int __perkPointsForThisSkillLevel = __newSkillLevel / 5
	int __perkPointsToGive = __perkPointsForThisSkillLevel - __alreadyGrantedPerkPoints
	debug.Trace("Everdamned DEBUG: Main Quest __alreadyGrantedPerkPoints: " + __alreadyGrantedPerkPoints)
	debug.Trace("Everdamned DEBUG: Main Quest __perkPointsForThisSkillLevel: " + __perkPointsForThisSkillLevel)
	debug.Trace("Everdamned DEBUG: Main Quest __perkPointsToGive: " + __perkPointsToGive)
	
	if __perkPointsToGive > 0
		ED_Art_SoundM_Advance.Play(playerRef)
		ED_Mechanics_SkillTree_PerkPoints_Global.Mod(__perkPointsToGive)
		ED_Mechanics_SkillTree_PerkPointsGrantedTotal_Global.Mod(__perkPointsToGive)
		ED_Mechanics_SkillTree_Message_MortalPerkPointGained.Show()
	endif
	
	if playerRef.HasSpell(ED_VampirePowers_Ab_Presence_Spell)
		playerRef.RemoveSpell(ED_VampirePowers_Ab_Presence_Spell)
		playerRef.AddSpell(ED_VampirePowers_Ab_Presence_Spell, false)
	endif
	
	;UISkillIncreaseSD
	
	; 30 mortal perks in total
	;18 perk points from skill levelling
	;2 perk points from start
	;10 perk points from ageing
	
	; 23 VL perks in total
	;10 per aging
	;rest from biting
	
	__skillLvlupLock = false
	
EndEvent

; For Wine and Revelry displaying message upon achieving 50 alch
event OnSkillIncrease(int aiSkill)
	if aiSkill != 16
		return
	endif
	
	if playerRef.GetActorValue("Alchemy") >= 50.0
		debug.Trace("Everdamned DEBUG: Player vampire achieved 50 alch, displaying message and unregistering")
		ED_Mechanics_Message_Alchemy50RecipeUnlock.ShowAsHelpMessage("ed_alchemy50achieved", 7.0, 0.0, 1)
	
		PO3_Events_Form.UnregisterForSkillIncrease(self)
	endif
endevent

globalvariable property ED_Mechanics_BlueBlood_Global_ChainedBeastAwarded auto
globalvariable property ED_Mechanics_BlueBlood_Global_EmbraceTheBeastAwarded auto
globalvariable property ED_Mechanics_SkillTree_PerkPoints_Global auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto
globalvariable property ED_Mechanics_SkillTree_PerkPointsGrantedTotal_Global auto
globalvariable property ED_Mechanics_SkillTree_DenominatorXP_Global auto

message property ED_Mechanics_SkillTree_Message_MortalPerkPointGained auto
message property ED_Mechanics_Message_Alchemy50RecipeUnlock auto

sound property ED_Art_SoundM_Advance auto
sound property ED_Art_SoundM_AdvanceAge auto

perk property ED_Mechanics_Ab_ChainedBeast_Perk auto
perk property ED_Mechanics_Ab_ChainedBeast_EmbraceTheBeast_Perk auto
spell property ED_Mechanics_Ab_ChainedBeast_Spell auto
spell property ED_VampirePowers_Ab_Presence_Spell auto
spell property ED_Mechanics_UnlockDisplayAb_Potence auto
perk property ED_PerkTree_Disciplines_30_DeadlyStrength_Perk auto

formlist property ED_Mechanics_FormList_MortalPerkTreePerks auto
formlist property ED_Mechanics_FormList_VLPerkTreePerks auto
formlist property ED_Mechanics_FormList_HemomancyRewards auto
formlist property ED_Mechanics_FormList_SpellCleanup auto

globalvariable property ED_Mechanics_VampireAge auto
globalvariable property ED_Mechanics_VampireAgeRate auto
globalvariable property ED_Mechanics_VampireAgeExpMult auto
globalvariable property ED_Mechanics_VampireAgeCurrentExp auto
globalvariable property ED_Mechanics_VampireAgeCurrentLvlUpThreshold auto
globalvariable property ED_Mechanics_VampireAgeLvlUpExpIncrement auto
globalvariable property ED_Mechanics_Global_ChainedBeastAllowed auto
globalvariable property DLC1VampirePerkPoints auto
globalvariable property DLC1VampireTotalPerksEarned auto

ED_HotKeys_Script property ED_Mechanics_HotKeys_Quest auto
ED_BloodPoolManager_Script property ED_BloodPoolManager_Quest auto

actor property playerRef auto
