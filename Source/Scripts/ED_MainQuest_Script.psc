Scriptname ED_MainQuest_Script extends Quest  

; should be true when player is vampire, false when not/cured.
; set to true on first call of GainAgeExpirience()
bool isAging
bool HasShownAgeMessage
int NextMessageIndex = 0
int property MaxAge auto


actor property playerRef auto
globalvariable property ED_Mechanics_VampireAge auto
globalvariable property ED_Mechanics_VampireAgeRate auto
globalvariable property ED_Mechanics_VampireAgeCurrentExp auto
globalvariable property ED_Mechanics_VampireAgeCurrentLvlUpThreshold auto
globalvariable property ED_Mechanics_VampireAgeLvlUpExpIncrement auto
globalvariable property ED_Mechanics_Global_ChainedBeastAllowed auto


;spell[] property Age_Scaling_Display_Spell_List auto
perk[] property Age_Scaling_Perk_List auto

message property ED_Mechanics_Message_AgeLvlUpNotification auto
message[] property Age_Message_List auto


function PlayerBecameVampire()
	GainAgeExpirience(0.0)
	RewardBlueBloodRewardsIfNeeded()
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
		ED_Mechanics_VampireAgeCurrentExp.Mod(amountToAge)
		if ED_Mechanics_VampireAgeCurrentExp.value >= ED_Mechanics_VampireAgeCurrentLvlUpThreshold.value
			if !HasShownAgeMessage
				debug.Trace("Everdamned INFO: Player vampire just hit aging threshold on current age of " + ED_Mechanics_VampireAge.value + ", waiting for sleep to do lvlup")
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
	; TODO: blue blood rewards should be removed as well
	
	i = 0
	int __perklistSize
	perk __perkToDelete
	
	__perklistSize = ED_Mechanics_FormList_MortalPerkTreePerks.GetSize() 
	
	while i < __perklistSize
		__perkToDelete = ED_Mechanics_FormList_MortalPerkTreePerks.GetAt(i) as perk
		playerRef.RemovePerk(__perkToDelete)
		i += 1
	endwhile
	
	;i = 0
	;__perklistSize = ED_Mechanics_FormList_VLPerkTreePerks.GetSize() 
	
	;while i < __perklistSize
	;	__perkToDelete = ED_Mechanics_FormList_VLPerkTreePerks.GetAt(i) as perk
	;	playerRef.RemovePerk(__perkToDelete)
	;	i += 1
	;endwhile
	
	
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

globalvariable property ED_Mechanics_BlueBlood_Global_ChainedBeastAwarded auto
globalvariable property ED_Mechanics_BlueBlood_Global_EmbraceTheBeastAwarded auto

perk property ED_Mechanics_Ab_ChainedBeast_Perk auto
perk property ED_Mechanics_Ab_ChainedBeast_EmbraceTheBeast_Perk auto
spell property ED_Mechanics_Ab_ChainedBeast_Spell auto

formlist property ED_Mechanics_FormList_MortalPerkTreePerks auto
formlist property ED_Mechanics_FormList_VLPerkTreePerks auto

ED_HotKeys_Script property ED_Mechanics_HotKeys_Quest auto
