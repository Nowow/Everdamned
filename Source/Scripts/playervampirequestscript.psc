scriptName PlayerVampireQuestScript extends Quest conditional


spell property VampireCureDisease auto
faction property VampirePCFaction auto
String property SCS_Stat1 auto
formlist property CrimeFactions auto
Int property VampireStatus auto conditional
Float property LastFeedTime auto
globalvariable property PlayerIsVampire auto
effectshader property VampireChangeFX auto
race property NordRaceVampire auto
static property XMarker auto
imagespacemodifier property VampireTransformIncreaseISMD auto
idle property VampireFeedingBedrollRight auto
magiceffect property DLC1VampireChangeFXEffect auto
magiceffect property DLC1VampireChangeEffect auto
Quest property VC01 auto
spell property DLC1VampireChange auto
formlist property DLC1CrimeFactions auto
race property NordRace auto
globalvariable property VampireFeedReady auto
idle property VampireFeedingBedRight auto
race property CureRace auto
formlist property DLC1VampireHateFactions auto
sound property MagVampireTransform01 auto
spell property DiseasePorphyricHemophelia auto
Float property FeedTimer auto
globalvariable property GameDaysPassed auto
imagespacemodifier property VampireTransformDecreaseISMD auto

spell property ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell auto
spell property SCS_Abilities_Reward_Spell_SlowerHunger auto

;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N auto
;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc auto
;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2 auto
;spell property SCS_VampireSpells_Vanilla_Power_Spell_BloodCauldron auto

;spell property SCS_VampireSpells_Reward_Power_Spell_VampiresCall auto
;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage3 auto
;spell property SCS_VampireSpells_Reward_Power_Spell_LamaesShroud auto
;spell property SCS_Abilities_Reward_Spell_UltimatePredator_Ab auto
;spell property SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower auto

;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage5 auto

;spell property SCS_VampireSpells_Vanilla_Power_Spell_Flaywind auto
;spell property SCS_VampireSpells_Vanilla_Power_Spell_VampiresCommand2 auto

;spell property SCS_Abilities_StrongBlood_Spell_04_Ab auto
;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage1 auto

;spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage4 auto
spell property ED_VampirePowers_Pw_Obfuscate_Spell auto

spell property ED_VampirePowers_Pw_VampiresWill_Spell auto
spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell auto
;spell property SCS_VampireSpells_Vanilla_Power_Spell_Nightwalk2 auto

; TODO: add hunger drop message
message property SCS_Help_HungerStage2 auto
message property SCS_Mechanics_Message_VampireProgression auto
; TODO: add feed message
message property SCS_Mechanics_Message_VampireFeed auto

;globalvariable property SCS_Mechanics_Global_HasLiftAndDrop auto

scs_futil_script property SCS_Main500_Quest auto

String property SCS_Stat0 auto
String property SCS_Stat2 auto


function OnUpdateGameTime()

	ED_BloodPoolManager_Quest.ProcessBonuses()
	FeedTimer = (GameDaysPassed.value - LastFeedTime) * 24.0100 / ED_Mechanics_Global_DelayBetweenStages.GetValue()
	if game.IsMovementControlsEnabled() && game.IsFightingControlsEnabled() && playerRef.GetCombatState() == 0 && !playerRef.HasMagicEffect(DLC1VampireChangeEffect) && !playerRef.HasMagicEffect(DLC1VampireChangeFXEffect)
		Float Chance
		;if Player.HasSpell(SCS_Abilities_Reward_Spell_SlowerHunger as form)
		;	Chance = ED_HungerChance
		;else
		;	Chance = ED_HungerChanceSlower
		;endIf
		if utility.RandomFloat(0.000000, 1.00000) < ED_HungerChance
			;SCS_Help_HungerStage2.ShowAsHelpMessage("SCS_HungerStage2Event", 5.00000, 0 as Float, 1)
			self.Devolve(false)
		endIf
	endIf
endFunction

; this function exists because dont want to change VampireFeed() interface to avoid compatibility issues
float _defaultHPtoBeEaten = 20.0 ; for compatibility, a default amount for feeds that do not know feed target
float _hpToBeEaten = 0.0
float __hpCacheVal
float property hpToBeEaten hidden
	
	function Set(float newValue)
		if newValue >= 0.0	
			_hpToBeEaten = newValue
		endif
	EndFunction
  
	float function Get()
		__hpCacheVal = _hpToBeEaten
		_hpToBeEaten = _defaultHPtoBeEaten
		return __hpCacheVal
	EndFunction

EndProperty

function EatThisActor(actor Target, float percentToDigest = 0.2)
	

	debug.Trace("Everdamned Info: actor to be eaten at 20% of base hp")
	hpToBeEaten = Target.getbaseav("health") * 0.2
	
	VampireFeed()
endFunction

function VampireFeed()

	VampireTransformDecreaseISMD.applyCrossFade(2.00000)
	utility.Wait(2.00000)
	imagespacemodifier.removeCrossFade(1.00000)
	game.IncrementStat("Necks Bitten", 1)
	SCS_Mechanics_Message_VampireFeed.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	VampireFeedReady.SetValue(0 as Float)
	LastFeedTime = GameDaysPassed.value
	self.VampireProgression(playerRef, 1)
	VampireStatus = 1
	self.StopHate(playerRef, false)
	self.UnregisterforUpdateGameTime()
	self.RegisterForUpdateGameTime(3 as Float)
endFunction

function StartHate(actor Player)

	if ED_Mechanics_Global_DisableHate.GetValue() == 0 as Float && !Player.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell as form)
		debug.Trace("EVERDAMNED DEBUG: You become hated due to stage 4", 0)
		Player.AddtoFaction(VampirePCFaction)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(true)
			i += 1
		endWhile
	endIf
endFunction

function VampireFeedBed()

	game.GetPlayer().PlayIdle(VampireFeedingBedRight)
endFunction

function StopHate(actor Player, Bool akForceStopHate)

	if VampireStatus != 4 || akForceStopHate == true
		Player.RemoveFromFaction(VampirePCFaction)
		Player.SetAttackActorOnSight(false)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(false)
			i += 1
		endWhile
	endIf
endFunction

function VampireCure(actor Player)

	game.IncrementStat("Vampirism Cures", 1)
	self.UnregisterforUpdateGameTime()
	VampireStatus = 0
	self.StopHate(Player, true)
	Player.RemoveSpell(DLC1VampireChange)
	Player.RemoveSpell(ED_BeingVampire_Ab_TrespassingCurse_Spell)
	Player.RemoveSpell(ED_BeingVampire_Ab_MoonlitWaters_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage3_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage4_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage3_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage4_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_VampiricDrain)
	Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage1_Spell)
	Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage2_Spell)
	Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage3_Spell)
	Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage4_Spell)
	
	Player.RemoveSpell(ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell)
	Player.RemoveSpell(ED_VampirePowers_Pw_VampiresWill_Spell)
	;Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_Flaywind)
	Player.RemoveSpell(ED_VampirePowers_Pw_Obfuscate_Spell)
	;Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower)
	;Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_VampiresCommand2)
	;Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_Nightwalk2)
	;Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodCauldron)
	if !CureRace
		Player.SetRace(NordRace)
	else
		Player.SetRace(CureRace)
	endIf
	PlayerIsVampire.SetValue(0 as Float)
	Player.DispelSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell)
	Player.RemoveSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell)
	
	;SCS_Main500_Quest.TearDownRewardSpells()
	
	;SCS_Mechanics_Global_Wassail_Current.SetValue(0.000000)
	;Float RestoreAmount = SCS_Mechanics_Global_Wassail_NerfAmount.GetValue()
	;if SCS_Stat0
	;	Player.ModActorValue("Health", RestoreAmount)
	;endIf
	;if SCS_Stat1
	;	Player.ModActorValue(SCS_Stat1, RestoreAmount)
	;endIf
	;if SCS_Stat2
	;	Player.ModActorValue(SCS_Stat2, RestoreAmount)
	;endIf
	;SCS_Mechanics_Global_Wassail_NerfAmount.SetValue(0.000000)
	;Player.DispelSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc)
endFunction

function VampireFeedBedRoll()

	game.GetPlayer().PlayIdle(VampireFeedingBedrollRight)
endFunction

Bool function TestIntegrity()

	return true
endFunction


function VampireChange(actor Target)

	
	game.DisablePlayerControls(true, true, false, false, false, true, true, false, 0)
	VampireChangeFX.play(Target as objectreference, -1.00000)
	VampireTransformIncreaseISMD.applyCrossFade(2.00000)
	objectreference myXmarker = Target.PlaceAtMe(XMarker as form, 1, false, false)
	MagVampireTransform01.play(myXmarker)
	myXmarker.Disable(false)
	utility.Wait(2.00000)
	imagespacemodifier.removeCrossFade(1.00000)
	VampireChangeFX.stop(Target as objectreference)
	race PlayerRace = Target.GetActorBase().GetRace()
	CureRace = PlayerRace
	Int RaceID = ED_Races.Find(PlayerRace as form)
	if RaceID >= 0
		Target.SetRace(ED_RacesVampire.GetAt(RaceID) as race)
	else
		ED_Mechanics_Message_RaceBroken.Show()
		Target.SetRace(NordRaceVampire)
	endIf
	VampireCureDisease.Cast(Target as objectreference, none)
	VampireStatus = 1
	self.VampireProgression(playerRef, 1)
	self.RegisterForUpdateGameTime(3 as Float)
	LastFeedTime = GameDaysPassed.value
	PlayerIsVampire.SetValue(1 as Float)
	;SCS_Main500_Quest.RebuildRewardSpells()
	utility.Wait(1.00000)
	ED_FeedManager_Quest.RegisterFeedEvents()
	ED_MainQuest.GainAgeExpirience(0.0)
	game.EnablePlayerControls(true, true, true, true, true, true, true, true, 0)
	if VC01.GetStageDone(200) == 1 as Bool
		VC01.SetStage(25)
	endIf
endFunction

Bool function Devolve(Bool abForceDevolve)

	if (FeedTimer >= 3 as Float || abForceDevolve == true) && VampireStatus == 3
		VampireFeedReady.SetValue(3 as Float)
		if ED_Mechanics_Global_DisableHate.GetValue() == 0 as Float && !playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell as form)
			ED_Mechanics_Message_VampireProgression_Stage4.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		else
			ED_Mechanics_Message_VampireProgression_Stage4_Masquerade.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		endIf
		VampireStatus = 4
		self.VampireProgression(playerRef, 4)
		self.UnregisterforUpdateGameTime()
	elseIf (FeedTimer >= 2 as Float || abForceDevolve == true) && VampireStatus == 2
		if abForceDevolve
			LastFeedTime -= 1 as Float
		endIf
		VampireFeedReady.SetValue(2 as Float)
		ED_Mechanics_Message_VampireProgression_Stage3.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		VampireStatus = 3
		self.VampireProgression(playerRef, 3)
	elseIf (FeedTimer >= 1 as Float || abForceDevolve == true) && VampireStatus == 1
		if abForceDevolve
			LastFeedTime -= 1 as Float
		endIf
		VampireFeedReady.SetValue(1 as Float)
		ED_Mechanics_Message_VampireProgression_Stage2.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		VampireStatus = 2
		self.VampireProgression(playerRef, 2)
	endIf
endFunction


function VampireProgression(actor Player, Int VampireStage)

	; TODO: move all that somewhere out of here. maybe leave abilities and move spells elsewhere
	; TODO: make it so AgeOrStageChange only triggers when actually stages are changed, not when called on the same stage
	;removing permanent passives for some reason, maybe because of the way progession is used in vanilla scripts
	Player.RemoveSpell(ED_BeingVampire_Ab_TrespassingCurse_Spell)
	Player.RemoveSpell(ED_BeingVampire_Ab_MoonlitWaters_Spell)
	
	; for reference if need apply same mechanic
	;Bool GiveBackMyth = false
	
	debug.Trace("Everdamned DEBUG: VampireProgression was called for stage " + VampireStage)
	
	if VampireStage == 2
		if VampireStatus == 0
			debug.Trace("Everdamned ERROR: VampireProgression for stage 2 while Vampire Status is 0")
		endif
		VampireTransformIncreaseISMD.applyCrossFade(2.00000)
		utility.Wait(2.00000)
		imagespacemodifier.removeCrossFade(1.00000)
		
		; working assumption that you only get to stage 2 from stage 1
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage1_Spell)
		Player.AddSpell(ED_BeingVampire_Ab_Status_Stage2_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Ab_LastStandFrenzy_Spell)
		
		ED_BloodPoolManager_Quest.AtStageOrAgeChange(VampireStage, ED_VampireAge.GetValue() as int, 0.0)
		
		;Player.AddSpell(ED_BeingVampire_Vanilla_VampiricDrain, false)
		;Player.AddSpell(ED_VampirePowers_Pw_VampiresWill_Spell, false)
		;Player.RemoveSpell(ED_BeingVampire_Ab_LastStandFrenzy_Spell
		; wassail
		;Player.AddSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N, false)
		;Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodCauldron)
		;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower, true)
		
	elseIf VampireStage == 3
		if VampireStatus == 0
			debug.Trace("Everdamned ERROR: VampireProgression for stage 3 while Vampire Status is 0")
		endif
		VampireTransformIncreaseISMD.applyCrossFade(2.00000)
		utility.Wait(2.00000)
		imagespacemodifier.removeCrossFade(1.00000)
		
		; working assumption that you only get to stage 3 from stage 2 or 1
		
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage2_Spell)
		Player.AddSpell(ED_BeingVampire_Ab_Status_Stage3_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage3_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage3_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Ab_LastStandFrenzy_Spell)
		
		ED_BloodPoolManager_Quest.AtStageOrAgeChange(VampireStage, ED_VampireAge.GetValue() as int, 0.0)
		
		;Player.AddSpell(ED_BeingVampire_Vanilla_VampiricDrain, false)
		
		
	elseIf VampireStage == 4
		if VampireStatus == 0
			debug.Trace("Everdamned ERROR: VampireProgression for stage 4 while Vampire Status is 0")
		endif
		VampireTransformIncreaseISMD.applyCrossFade(2.00000)
		utility.Wait(2.00000)
		imagespacemodifier.removeCrossFade(1.00000)
		
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage3_Spell)
		Player.AddSpell(ED_BeingVampire_Ab_Status_Stage4_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage3_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage4_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage3_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage4_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell, false)
		
		ED_BloodPoolManager_Quest.AtStageOrAgeChange(VampireStage, ED_VampireAge.GetValue() as int, 0.0)
		
		;Player.AddSpell(ED_BeingVampire_Vanilla_VampiricDrain, false)
		
		self.StartHate(Player)
	elseIf VampireStage == 1

		; -----------------------------------------------------------------------------------------------
		; adding all general vampire passives here each time, for reasons i'm not going to look into
		; but probably due to other vanilla/modded scripts having a tendency to call VampireProgression
		; even if thats not their business
		
		; waterwalking+waterbreathing
		Player.AddSpell(ED_BeingVampire_Ab_MoonlitWaters_Spell, false)
		; dampen healing, probably should be redone
		; vampire feed perk holder
		; resist poison and disease
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight, false)
		
		; deprecated in favor of PassivesHolder
		;Player.AddSpell(ED_BeingVampire_Vanilla_Ab_StillHeart_Spell_WasNightstalkersFootsteps, false)
		; movspeed increase, amount controlled by age perks
		Player.AddSpell(ED_BeingVampire_Ab_Stalker_Spell, false)
		
		; is attached to vampire races, do not need to be added
		; will be added for vampire transformations
		;Player.AddSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell, false)
		
		Player.AddSpell(ED_BeingVampire_Vanilla_VampiricDrain, false)
		Player.AddSpell(ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell, true)
		; -----------------------------------------------------------------------------------------------
		
		;;
		
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage3_Spell)
		Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage4_Spell)
		Player.AddSpell(ED_BeingVampire_Ab_Status_Stage1_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage3_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage4_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage3_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage4_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell, false)
		
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
		Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell)
		Player.AddSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell, false)
		
		Player.AddSpell(ED_BeingVampire_Ab_LastStandFrenzy_Spell, false)
		
		; i dont remember why do I do that here and not in VampireFeed but there was some reason
		ED_BloodPoolManager_Quest.AtStageOrAgeChange(VampireStage, ED_VampireAge.GetValue() as int, hpToBeEaten)
		

		
		; now a perk
		;Player.AddSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage1, false)

		;Player.AddSpell(ED_VampirePowers_Pw_VampiresWill_Spell, false)		
		;Player.AddSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2, false)
		;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N)
		;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage3)
		;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage4)
		;if !Player.HasSpell(SCS_Abilities_Reward_Spell_UltimatePredator_Ab as form)
		;	Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower)
		;	Player.RemoveSpell(ED_VampirePowers_Pw_Obfuscate_Spell)
		;	Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_Flaywind)
		;endIf
		
		;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_VampiresCommand2, true)
		;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_Nightwalk2, true)
		;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodCauldron, true)
		
		
		;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage5)
		
	;	if Player.HasSpell(SCS_Abilities_StrongBlood_Spell_04_Ab as form)
	;		Player.RemoveSpell(SCS_Abilities_StrongBlood_Spell_04_Ab)
	;		GiveBackMyth = true
	;	endIf
	
	endIf
	
	;giving back permanent passives
	;idk why the unplug-plug but...
	utility.Wait(1.50000)
	Player.AddSpell(ED_BeingVampire_Ab_MoonlitWaters_Spell, false)
	Player.AddSpell(ED_BeingVampire_Ab_TrespassingCurse_Spell, false)
	
	;if GiveBackMyth
	;	Player.AddSpell(SCS_Abilities_StrongBlood_Spell_04_Ab, false)
	;endIf
endFunction

ED_BloodPoolManager_Script Property ED_BloodPoolManager_Quest Auto
ED_FeedManager_Script Property ED_FeedManager_Quest Auto
ED_MainQuest_Script Property ED_MainQuest Auto

globalvariable property ED_VampireAge auto
actor property playerRef auto


spell property ED_BeingVampire_Ab_Status_Stage3_Spell auto
spell property ED_BeingVampire_Ab_LastStandFrenzy_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage4_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_VampiricDrain auto
spell property ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight auto
; deprecated in favor of PassivesHolder
;spell property ED_BeingVampire_Vanilla_Ab_StillHeart_Spell_WasNightstalkersFootsteps auto
spell property ED_BeingVampire_Ab_Stalker_Spell auto

Float property ED_HungerChanceSlower auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell auto
formlist property ED_RacesVampire auto
formlist property ED_Races auto
message property ED_Mechanics_Message_RaceBroken auto
message property ED_Mechanics_Message_VampireProgression_Stage2 auto
globalvariable property ED_Mechanics_Global_DelayBetweenStages auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell auto
spell property ED_VampirePowers_Ab_Masquerade_Spell auto
message property ED_Mechanics_Message_VampireProgression_Stage4 auto
message property ED_Mechanics_Message_VampireProgression_Stage4_Masquerade auto
message property ED_Mechanics_Message_VampireProgression_Stage3 auto
spell property ED_BeingVampire_Ab_MoonlitWaters_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell auto
globalvariable property ED_Mechanics_Global_DisableHate auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage4_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage4_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage2_Spell auto
spell property ED_BeingVampire_Ab_TrespassingCurse_Spell auto
Float property ED_HungerChance auto
