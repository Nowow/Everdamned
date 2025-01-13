;/ Decompiled by Champollion V1.0.1
Source   : DLC1PlayerVampireChangeScript.psc
Modified : 2020-12-09 01:31:39
Compiled : 2020-12-09 01:31:41
User     : maxim
Computer : CANOPUS
/;
scriptName DLC1PlayerVampireChangeScript extends Quest

;-- Properties --------------------------------------
idle property SpecialFeeding auto
globalvariable property SCS_PowerBite auto
perk property SCS_BloodStorm_Perk auto
String property LandStart = "LandStart" auto
Float property UnearthlyWillExtensionTimeSeconds auto
{How long (in real seconds) that feeding extends vampire time}
Bool property Untimed auto
spell property DLC1PlayerVampireLvl10AndBelowAbility auto
spell property SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_01 auto
sound property NPCVampireTransformation auto
globalvariable property DLC1BloodMagic auto
spell property DLC1PlayerVampireLvl40AndBelowAbility auto
sound property VampireIMODSound auto
armor property gargNecklace auto
perk property SCS_PerkTree_380_Perk_VampireLord_DragonAtMidnight auto
perk property LightFoot auto
spell property LeveledDrainSpell auto
globalvariable property DLC1VampireNextPerk auto
perk property DLC1CorpseCursePerk auto
globalvariable property DLC1MistformCount auto
spell property DLC1ConjureGargoyleLeftHand auto
spell property FeedBoost auto
perk property DLC1DetectLifePerk auto
spell property DLC1PlayerVampireLvl30AndBelowAbility auto
globalvariable property GameDaysPassed auto
globalvariable property pDLC1nVampireRingBeast auto
perk property SCS_Tremble_Perk auto
faction property HunterFaction auto
location property DLC1VampireCastleLocation auto
spell property LeveledAbility auto
spell property SCS_VampireSpells_VampireLord_Spell_BloodStorm_09 auto
spell property DLC1PlayerVampireLvl25AndBelowAbility auto
message property PlayerVampireExpirationWarning auto
globalvariable property SCS_Mechanics_Global_DisableHate auto
globalvariable property pDLC1nVampireNecklaceGargoyle auto
formlist property DLC1VampireHateFactions auto
globalvariable property DLC1VampireBloodPoints auto
String property Levitate = "LevitateStart" auto
magiceffect property DLC1RevertEffect auto
Float property DLC1BiteHealthRecover auto
spell property SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_04 auto
message property PlayerVampireFeedMessage auto
race property VampireLordRace auto
perk property SCS_Maelstrom_Perk auto
formlist property VampireDiSpellist auto
spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell auto
armor property DLC1VampireLordArmor auto
String property BiteStart = "BiteStart" auto
String property TransformToHuman = "TransformToHuman" auto
spell property DLC1VampireChange auto
globalvariable property DCL1VampireLevitateStateGlobal auto
{This Global tracks what state the Vampire Lord is in: 0 = Not a Vampire Lord, 1 = Walking, 2 = Levitating}
message property DLC1BloodPointsMsg auto
Quest property DialogueGenericVampire auto
String property LiftoffStart = "LiftoffStart" auto
globalvariable property pDLC1nVampireRingErudite auto
Float property DurationWarningTimeSeconds auto
{How long (in real seconds) before turning back we should warn the player}
spell property DLC1SupernaturalReflexes auto
perk property DLC1MistFormPerk auto
armor property DLC1ClothesVampireLordRoyalArmor auto
spell property SCS_VampireSpells_VampireLord_Spell_Raze_07 auto
armor property batNecklace auto
Quest property VampireTrackingQuest auto
message property DLC1VampirePerkEarned auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage4 auto
imagespacemodifier property VampireWarn auto
effectshader property DLC1VampireChangeBack02FXS auto
spell property DLC1Revert auto
spell property SCS_Abilities_Reward_Spell_NoHate auto
spell property SCS_VampireSpells_VampireLord_Spell_Raze_06 auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage2 auto
armor property beastRing auto
spell property DLC1AbVampireFloatBodyFX auto
{Spell FX Art holder for Levitation Glow.}
spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc auto
globalvariable property SCS_VampireLordDark_Tremble_Count auto
imagespacemodifier property VampireChange auto
spell property LeveledRaiseDeadSpell auto
spell property DLC1VampireDetectLife auto
spell property DLC1NightCloak auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage3 auto
spell property SCS_Maelstrom_Spell auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage1 auto
spell property VampireCharm auto
spell property SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_02 auto
perk property DLC1SupernaturalReflexesPerk auto
perk property DLC1NightCloakPerk auto
effectshader property DLC1VampireChangeBackFXS auto
spell property CurrentEquippedLeftSpell auto
spell property DLC1PlayerVampireLvl20AndBelowAbility auto
spell property DLC1VampiresGrip auto
spell property SCS_Abilities_VampireLord_Spell_Ab_VampireLordSunDamage auto
globalvariable property pDLC1nVampireNecklaceBats auto
Float property StandardDurationSeconds auto
{How long (in real seconds) the transformation lasts}
String property Ground = "GroundStart" auto
faction property DLC1PlayerVampireLordFaction auto
globalvariable property DLC1NightPower auto
globalvariable property PlayerVampireShiftBackTime auto
spell property SCS_VampireSpells_VampireLord_Spell_BloodStorm_07 auto
perk property DLC1VampireActivationBlocker auto
perk property DLC1VampiricGrip auto
spell property DLC1PlayerVampireLvl45AndBelowAbility auto
spell property DLC1PlayerVampireLvl35AndBelowAbility auto
spell property BleedingFXSpell auto
{This Spell is for making the target of feeding bleed.}
spell property SCS_VampireSpells_Vanilla_Power_Spell_Obfuscate auto
visualeffect property FeedBloodVFX auto
{Visual Effect on Wolf for Feeding Blood}
spell property SCS_Tremble_Spell auto
spell property DLC1VampireBats auto
spell property DLC1VampireMistform auto
location property DLC1VampireCastleDungeonLocation auto
spell property SCS_VampireSpells_VampireLord_Spell_BloodStorm_05 auto
spell property SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_03 auto
spell property VampireInvisibilityPC auto
globalvariable property DLC1VampirePerkPoints auto
spell property SCS_VampireSpells_VampireLord_Spell_Raze_09 auto
perk property DLC1UnearthlyWill auto
spell property SCS_VampireSpells_VampireLord_Spell_BloodStorm_08 auto
Bool property DLC1HasLightfoot auto
globalvariable property DLC1VampireTotalPerksEarned auto
globalvariable property DLC1ReflexesCount auto
globalvariable property VampireFeedReady auto
spell property DLC1CorpseCurse auto
playervampirequestscript property PlayerVampireQuest auto
globalvariable property TimeScale auto
spell property DLC1PlayerVampireLvl50AndOverAbility auto
armor property eruditeRing auto
perk property DLC1GargoylePerk auto
globalvariable property DLC1VampireMaxPerks auto
spell property SCS_VampireSpells_VampireLord_Spell_BloodStorm_06 auto
spell property SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_05 auto
spell property SCS_VampireSpells_VampireLord_Spell_Raze_08 auto
perk property DLC1VampireBite auto
spell property SCS_VampireSpells_VampireLord_Spell_Raze_05 auto
spell property DLC1PlayerVampireLvl15AndBelowAbility auto
location property DLC1VampireCastleGuildhallLocation auto

;-- Variables ---------------------------------------
Float __UnearthlyWillExtensionTime = -1.00000
Float __durationWarningTime = -1.00000
Bool __tryingToShiftBack = false
Bool __trackingStarted = false
Bool __prepped = false
Bool __shiftingBack = false
Bool __shuttingDown = false

;-- Functions ---------------------------------------

function OnUpdate()

	actor PlayerActor = game.GetPlayer()
	game.SetInCharGen(false, false, false)
	if game.QueryStat("NumVampirePerks") as Float >= DLC1VampireMaxPerks.value
		game.AddAchievement(58)
	endIf
	if Untimed
		return 
	endIf
	if PlayerActor.HasMagicEffect(DLC1RevertEffect) && !PlayerActor.IsInKillMove() && !__tryingToShiftBack
		self.Revert()
	else
		game.ForceThirdPerson()
	endIf
endFunction

function Shutdown()

	if __shuttingDown
		return 
	endIf
	__shuttingDown = true
	actor PlayerActor = game.GetPlayer()
	DCL1VampireLevitateStateGlobal.SetValue(0 as Float)
	PlayerActor.GetActorBase().SetInvulnerable(false)
	PlayerActor.SetGhost(false)
	game.SetBeastForm(false)
	game.EnableFastTravel(true)
	game.SetInCharGen(false, false, false)
	PlayerActor.RemovePerk(DLC1VampireActivationBlocker)
	
	PlayerActor.RemoveSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell)
	self.UnloadSpells()
	game.EnablePlayerControls(false, false, true, true, true, false, false, false, 1)
	self.Stop()
endFunction

function Feed(actor victim)

	; Empty function
endFunction

function UnregisterForEvents()

	actor PlayerActor = game.GetPlayer()
	self.UnRegisterForAnimationEvent(PlayerActor as objectreference, Ground)
	self.UnRegisterForAnimationEvent(PlayerActor as objectreference, Levitate)
	self.UnRegisterForAnimationEvent(PlayerActor as objectreference, BiteStart)
	self.UnRegisterForAnimationEvent(PlayerActor as objectreference, LiftoffStart)
	self.UnRegisterForAnimationEvent(PlayerActor as objectreference, LandStart)
	self.UnRegisterForAnimationEvent(PlayerActor as objectreference, TransformToHuman)
endFunction

function WarnPlayer()

	VampireWarn.Apply(1.00000)
endFunction

; Skipped compiler generated GetState

Float function GameTimeDaysToRealTimeSeconds(Float gametime)

	Float gameSeconds = gametime * (60 * 60 * 24) as Float
	return gameSeconds / TimeScale.value
endFunction

function OnAnimationEventUnregistered(objectreference akSource, String asEventName)

	debug.Trace("EVERDAMNED ERROR: Animation Event Unregistered for " + akSource as String + ": " + asEventName, 2)
endFunction

function HandlePlayerLoadGame()

	if __prepped
		self.PreloadSpells()
	endIf
endFunction

function PreloadSpells()
	
	; TODO: replace with Everdamned spells, remember that they will not be levelled
	LeveledDrainSpell.Preload()
	LeveledRaiseDeadSpell.Preload()
	DLC1VampiresGrip.Preload()
	DLC1ConjureGargoyleLeftHand.Preload()
	DLC1CorpseCurse.Preload()
	SCS_Maelstrom_Spell.Preload()
endFunction

function RegisterForEvents()

	actor PlayerActor = game.GetPlayer()
	self.RegisterForAnimationEvent(PlayerActor as objectreference, Ground)
	self.RegisterForAnimationEvent(PlayerActor as objectreference, Levitate)
	self.RegisterForAnimationEvent(PlayerActor as objectreference, BiteStart)
	self.RegisterForAnimationEvent(PlayerActor as objectreference, LiftoffStart)
	self.RegisterForAnimationEvent(PlayerActor as objectreference, LandStart)
	self.RegisterForAnimationEvent(PlayerActor as objectreference, TransformToHuman)
endFunction

Bool function TestIntegrity()

	return true
endFunction

Float function RealTimeSecondsToGameTimeDays(Float realtime)

	Float scaledSeconds = realtime * TimeScale.value
	return scaledSeconds / (60 * 60 * 24) as Float
endFunction

function StartTracking()

	actor PlayerActor = game.GetPlayer()
	if __trackingStarted
		return 
	endIf
	__trackingStarted = true
	if PlayerActor.IsEquipped(beastRing as form)
		pDLC1nVampireRingBeast.SetValue(1 as Float)
	endIf
	if PlayerActor.IsEquipped(eruditeRing as form)
		pDLC1nVampireRingErudite.SetValue(1 as Float)
	endIf
	if PlayerActor.IsEquipped(batNecklace as form)
		pDLC1nVampireNecklaceBats.SetValue(1 as Float)
	endIf
	if PlayerActor.IsEquipped(gargNecklace as form)
		pDLC1nVampireNecklaceGargoyle.SetValue(1 as Float)
	endIf
	self.RegisterForEvents()
	DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
	; TODO: not need dispel this spell because no such spell will be? idk
	PlayerActor.DispelSpell(SCS_VampireSpells_Vanilla_Power_Spell_Obfuscate)
	PlayerActor.UnequipAll()
	
	; TODO: when decided on DragonAtMidnight perk
	if PlayerActor.HasPerk(SCS_PerkTree_380_Perk_VampireLord_DragonAtMidnight)
		PlayerActor.EquipItem(DLC1ClothesVampireLordRoyalArmor as form, false, true)
	else
		PlayerActor.EquipItem(DLC1VampireLordArmor as form, false, true)
	endIf
	
	
	; TODO: decide whether disable hate would be a thing
	if SCS_Mechanics_Global_DisableHate.GetValue() == 0 as Float
		if !PlayerActor.IsInLocation(DLC1VampireCastleLocation) && !PlayerActor.IsInLocation(DLC1VampireCastleGuildhallLocation) && !PlayerActor.IsInLocation(DLC1VampireCastleDungeonLocation)
			PlayerActor.SetAttackActorOnSight(true)
			game.SendWereWolfTransformation()
		endIf
		PlayerActor.AddToFaction(DLC1PlayerVampireLordFaction)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(true)
			i += 1
		endWhile
		HunterFaction.SetPlayerEnemy(true)
	endIf
	game.SetPlayerReportCrime(false)
	; TODO: do we need that?
	__durationWarningTime = self.RealTimeSecondsToGameTimeDays(DurationWarningTimeSeconds)
	__UnearthlyWillExtensionTime = self.RealTimeSecondsToGameTimeDays(UnearthlyWillExtensionTimeSeconds)
	
	PlayerActor.RestoreActorValue("Health", 100 as Float)
	; TODO: part where change mortal form passives to VL passives
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage1)
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage2)
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage3)
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage4)
	; TODO: convert levelled passives
	PlayerActor.AddSpell(LeveledAbility, false)
	; TODO: create vampire lord sun damage and replace it here
	PlayerActor.AddSpell(SCS_Abilities_VampireLord_Spell_Ab_VampireLordSunDamage, false)
	; TODO: ?? probably should already be available since vampire
	PlayerActor.AddSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell, false)
	PlayerActor.AddSpell(DLC1Revert, false)
	; TODO: convert bats
	PlayerActor.AddSpell(DLC1VampireBats, false)
	PlayerActor.EquipSpell((DialogueGenericVampire as vampirequestscript).LastPower, 2)
	; TODO: main action goes here, add all new spells and perks that 
	self.CheckPerkSpells()

	if PlayerActor.HasPerk(LightFoot)
		DLC1HasLightfoot = true
	else
		DLC1HasLightfoot = false
		PlayerActor.AddPerk(LightFoot)
	endIf
	
	Float currentTime = GameDaysPassed.GetValue()
	; TODO: ??? needed?
	Float regressTime = currentTime + self.RealTimeSecondsToGameTimeDays(StandardDurationSeconds)
	if PlayerActor.HasPerk(DLC1UnearthlyWill)
		regressTime += __UnearthlyWillExtensionTime
	endIf
	
	PlayerVampireShiftBackTime.SetValue(regressTime)
	PlayerActor.DispelSpell(DLC1VampireChange)
	self.RegisterForUpdate(3.00000)
	self.SetStage(10)
endFunction

function PrepShift()

	actor PlayerActor = game.GetPlayer()
	VampireChange.Apply(1.00000)
	VampireIMODSound.Play(PlayerActor as objectreference)
	game.SetInCharGen(true, true, false)
	; TODO: activation blocker converted, check if no more work necessary
	PlayerActor.AddPerk(DLC1VampireActivationBlocker)
	game.SetBeastForm(true)
	game.EnableFastTravel(false)
	PlayerActor.SetActorValue("GrabActorOffset", 70 as Float)
	Int Count = 0
	; TODO: dispells werewolf and regular summons (atronachs and dead thralls). seems like unwanted behavior
	while Count < VampireDiSpellist.GetSize()
		spell Gone = VampireDiSpellist.GetAt(Count) as spell
		if Gone != none
			PlayerActor.DispelSpell(Gone)
		endIf
		Count += 1
	endWhile
	
	game.DisablePlayerControls(false, false, true, false, false, false, false, false, 1)
	game.ForceThirdPerson()
	game.ShowFirstPersonGeometry(false)
	self.EstablishLeveledSpells()
	self.PreloadSpells()
	__prepped = true
endFunction

function UnloadSpells()

	LeveledDrainSpell.Unload()
	LeveledRaiseDeadSpell.Unload()
	DLC1VampiresGrip.Unload()
	DLC1ConjureGargoyleLeftHand.Unload()
	DLC1CorpseCurse.Unload()
	SCS_Maelstrom_Spell.Unload()
endFunction

function CheckPerkSpells()

	actor PlayerActor = game.GetPlayer()
	if PlayerActor.HasPerk(DLC1MistFormPerk) && !PlayerActor.HasSpell(DLC1VampireMistform as form) && DLC1MistformCount.GetValue() < 1 as Float
		PlayerActor.AddSpell(DLC1VampireMistform, false)
	endIf
	if PlayerActor.HasPerk(DLC1DetectLifePerk) && !PlayerActor.HasSpell(DLC1VampireDetectLife as form)
		PlayerActor.AddSpell(DLC1VampireDetectLife, false)
	endIf
	if PlayerActor.HasPerk(DLC1SupernaturalReflexesPerk) && !PlayerActor.HasSpell(DLC1SupernaturalReflexes as form) && DLC1ReflexesCount.GetValue() < 1 as Float
		PlayerActor.AddSpell(DLC1SupernaturalReflexes, false)
	endIf
	if PlayerActor.HasPerk(SCS_Tremble_Perk) && !PlayerActor.HasSpell(SCS_Tremble_Spell as form) && SCS_VampireLordDark_Tremble_Count.GetValue() < 1 as Float
		PlayerActor.AddSpell(SCS_Tremble_Spell, false)
	endIf
	if PlayerActor.HasPerk(DLC1VampiricGrip) && !PlayerActor.HasSpell(DLC1VampiresGrip as form)
		PlayerActor.AddSpell(DLC1VampiresGrip, false)
	endIf
	if PlayerActor.HasPerk(DLC1GargoylePerk) && !PlayerActor.HasSpell(DLC1ConjureGargoyleLeftHand as form)
		PlayerActor.AddSpell(DLC1ConjureGargoyleLeftHand, false)
	endIf
	if PlayerActor.HasPerk(DLC1CorpseCursePerk) && !PlayerActor.HasSpell(DLC1CorpseCurse as form)
		PlayerActor.AddSpell(DLC1CorpseCurse, false)
	endIf
	if PlayerActor.HasPerk(SCS_Maelstrom_Perk) && !PlayerActor.HasSpell(SCS_Maelstrom_Spell as form)
		PlayerActor.AddSpell(SCS_Maelstrom_Spell, false)
	endIf
	if PlayerActor.HasPerk(DLC1NightCloakPerk) && !PlayerActor.HasSpell(DLC1NightCloak as form)
		PlayerActor.AddSpell(DLC1NightCloak, false)
	endIf
endFunction

function EstablishLeveledSpells()

	actor PlayerActor = game.GetPlayer()
	Int PlayerLevel = PlayerActor.GetLevel()
	if PlayerLevel <= 10
		if PlayerActor.HasPerk(SCS_BloodStorm_Perk)
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_BloodStorm_05
		else
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_Raze_05
		endIf
		LeveledRaiseDeadSpell = SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_01
	elseIf PlayerLevel <= 20
		if PlayerActor.HasPerk(SCS_BloodStorm_Perk)
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_BloodStorm_06
		else
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_Raze_06
		endIf
		LeveledRaiseDeadSpell = SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_02
	elseIf PlayerLevel <= 30
		if PlayerActor.HasPerk(SCS_BloodStorm_Perk)
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_BloodStorm_07
		else
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_Raze_07
		endIf
		LeveledRaiseDeadSpell = SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_03
	elseIf PlayerLevel <= 40
		if PlayerActor.HasPerk(SCS_BloodStorm_Perk)
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_BloodStorm_08
		else
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_Raze_08
		endIf
		LeveledRaiseDeadSpell = SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_04
	else
		if PlayerActor.HasPerk(SCS_BloodStorm_Perk)
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_BloodStorm_09
		else
			LeveledDrainSpell = SCS_VampireSpells_VampireLord_Spell_Raze_09
		endIf
		LeveledRaiseDeadSpell = SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_05
	endIf
	; TODO: convert levelled passive
	if PlayerLevel <= 10
		LeveledAbility = DLC1PlayerVampireLvl10AndBelowAbility
	elseIf PlayerLevel <= 15
		LeveledAbility = DLC1PlayerVampireLvl15AndBelowAbility
	elseIf PlayerLevel <= 20
		LeveledAbility = DLC1PlayerVampireLvl20AndBelowAbility
	elseIf PlayerLevel <= 25
		LeveledAbility = DLC1PlayerVampireLvl25AndBelowAbility
	elseIf PlayerLevel <= 30
		LeveledAbility = DLC1PlayerVampireLvl30AndBelowAbility
	elseIf PlayerLevel <= 35
		LeveledAbility = DLC1PlayerVampireLvl35AndBelowAbility
	elseIf PlayerLevel <= 40
		LeveledAbility = DLC1PlayerVampireLvl40AndBelowAbility
	elseIf PlayerLevel <= 45
		LeveledAbility = DLC1PlayerVampireLvl45AndBelowAbility
	else
		LeveledAbility = DLC1PlayerVampireLvl50AndOverAbility
	endIf
endFunction

function InitialShift()

	actor PlayerActor = game.GetPlayer()
	VampireWarn.Apply(1.00000)
	if PlayerActor.IsDead()
		return 
	endIf
	PlayerActor.GetActorBase().SetInvulnerable(true)
	PlayerActor.SetGhost(true)
	PlayerActor.SetRace(VampireLordRace)
	PlayerActor.AddSpell(DLC1AbVampireFloatBodyFX, false)
endFunction

function SetUntimed(Bool untimedValue)

	Untimed = untimedValue
	if Untimed
		self.UnregisterForUpdate()
	endIf
endFunction

; Skipped compiler generated GotoState

function Revert()

	if game.QueryStat("NumVampirePerks") as Float >= DLC1VampireMaxPerks.value
		game.AddAchievement(58)
	endIf
	self.UnregisterForUpdate()
	self.SetStage(100)
endFunction

function ActuallyShiftBackIfNecessary()

	actor PlayerActor = game.GetPlayer()
	if __shiftingBack
		return 
	endIf
	__shiftingBack = true
	PlayerActor.GetActorBase().SetInvulnerable(true)
	PlayerActor.SetGhost(true)
	if !DLC1HasLightfoot
		PlayerActor.RemovePerk(LightFoot)
	endIf
	self.UnregisterForEvents()
	DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
	game.SetInCharGen(true, true, false)
	self.UnregisterForUpdate()
	if PlayerActor.IsDead()
		return 
	endIf
	VampireChange.Apply(1.00000)
	VampireIMODSound.Play(PlayerActor as objectreference)
	DLC1VampireChangeBackFXS.Play(PlayerActor as objectreference, 12.0000)
	PlayerActor.RestoreActorValue("Health", 100 as Float)
	Int Count = 0
	while Count < VampireDiSpellist.GetSize()
		spell Gone = VampireDiSpellist.GetAt(Count) as spell
		if Gone != none
			PlayerActor.DispelSpell(Gone)
		endIf
		Count += 1
	endWhile
	PlayerActor.DispelSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc)
	CurrentEquippedLeftSpell = PlayerActor.GetEquippedSpell(0)
	(DialogueGenericVampire as vampirequestscript).LastLeftHandSpell = CurrentEquippedLeftSpell
	if PlayerActor.GetEquippedSpell(2) == DLC1Revert
		(DialogueGenericVampire as vampirequestscript).LastPower = DLC1VampireBats
	else
		(DialogueGenericVampire as vampirequestscript).LastPower = PlayerActor.GetEquippedSpell(2)
	endIf
	PlayerActor.RemoveSpell(LeveledDrainSpell)
	PlayerActor.RemoveSpell(LeveledRaiseDeadSpell)
	PlayerActor.RemoveSpell(DLC1VampiresGrip)
	PlayerActor.RemoveSpell(DLC1ConjureGargoyleLeftHand)
	PlayerActor.RemoveSpell(DLC1CorpseCurse)
	PlayerActor.RemoveSpell(SCS_Maelstrom_Spell)
	PlayerActor.RemoveSpell(DLC1VampireDetectLife)
	PlayerActor.RemoveSpell(DLC1VampireMistform)
	PlayerActor.RemoveSpell(DLC1VampireBats)
	PlayerActor.RemoveSpell(DLC1SupernaturalReflexes)
	PlayerActor.RemoveSpell(DLC1NightCloak)
	PlayerActor.RemoveSpell(DLC1Revert)
	PlayerActor.RemoveSpell(SCS_Abilities_VampireLord_Spell_Ab_VampireLordSunDamage)
	PlayerActor.RemoveSpell(LeveledAbility)
	PlayerActor.RemoveSpell(SCS_Tremble_Spell)
	PlayerActor.DispelSpell(DLC1VampireDetectLife)
	PlayerActor.DispelSpell(DLC1VampireMistform)
	PlayerActor.DispelSpell(DLC1SupernaturalReflexes)
	PlayerActor.DispelSpell(DLC1ConjureGargoyleLeftHand)
	PlayerActor.DispelSpell(DLC1Revert)
	PlayerActor.RemoveSpell(DLC1AbVampireFloatBodyFX)
	pDLC1nVampireNecklaceBats.SetValue(0 as Float)
	pDLC1nVampireNecklaceGargoyle.SetValue(0 as Float)
	pDLC1nVampireRingBeast.SetValue(0 as Float)
	pDLC1nVampireRingErudite.SetValue(0 as Float)
	PlayerVampireQuest.VampireProgression(PlayerActor, PlayerVampireQuest.VampireStatus)
	PlayerActor.RemoveItem(DLC1VampireLordArmor as form, 2, true, none)
	PlayerActor.RemoveItem(DLC1ClothesVampireLordRoyalArmor as form, 2, true, none)
	PlayerActor.SetRace((VampireTrackingQuest as dlc1vampiretrackingquest).PlayerRace)
	DLC1VampireChangeBackFXS.Stop(PlayerActor as objectreference)
	DLC1VampireChangeBack02FXS.Play(PlayerActor as objectreference, 0.100000)
	game.ShowFirstPersonGeometry(true)
	PlayerActor.RemoveFromFaction(DLC1PlayerVampireLordFaction)
	HunterFaction.SetPlayerEnemy(false)
	if !PlayerActor.IsInLocation(DLC1VampireCastleLocation) && !PlayerActor.IsInLocation(DLC1VampireCastleGuildhallLocation) && !PlayerActor.IsInLocation(DLC1VampireCastleDungeonLocation)
		game.SendWereWolfTransformation()
	endIf
	if PlayerVampireQuest.VampireStatus < 4 || SCS_Mechanics_Global_DisableHate.GetValue() == 1 as Float || PlayerActor.HasSpell(SCS_Abilities_Reward_Spell_NoHate as form)
		PlayerActor.SetAttackActorOnSight(false)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(false)
			i += 1
		endWhile
	endIf
	game.SetPlayerReportCrime(true)
	utility.Wait(5.00000)
endFunction

function ShiftBack()

	__tryingToShiftBack = true
	actor PlayerActor = game.GetPlayer()
	while PlayerActor.GetAnimationVariableBool("bIsSynced")
		utility.Wait(0.100000)
	endWhile
	__shiftingBack = false
	self.ActuallyShiftBackIfNecessary()
endFunction

function OnAnimationEvent(objectreference akActor, String akEventName)

	actor PlayerActor = game.GetPlayer()
	if akActor == PlayerActor as objectreference
		if akEventName == TransformToHuman
			self.ActuallyShiftBackIfNecessary()
		endIf
		if akEventName == BiteStart
			DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value + 1 as Float
			if DLC1VampireTotalPerksEarned.value < DLC1VampireMaxPerks.value
				DLC1BloodPointsMsg.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
				if DLC1VampireBloodPoints.value >= DLC1VampireNextPerk.value
					DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value - DLC1VampireNextPerk.value
					DLC1VampirePerkPoints.value = DLC1VampirePerkPoints.value + 1 as Float
					DLC1VampireTotalPerksEarned.value = DLC1VampireTotalPerksEarned.value + 1 as Float
					DLC1VampireNextPerk.value = DLC1VampireNextPerk.value + 1 as Float
					DLC1VampirePerkEarned.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
				endIf
				PlayerActor.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100 as Float)
			endIf
			if PlayerActor.HasPerk(DLC1VampireBite) == 1 as Bool
				PlayerActor.RestoreActorValue("Health", DLC1BiteHealthRecover)
				PlayerActor.RestoreActorValue("Magicka", 150 as Float)
				game.AdvanceSkill("Destruction", SCS_PowerBite.GetValue())
			endIf
			PlayerActor.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100 as Float)
			game.IncrementStat("Necks Bitten", 1)
		endIf
		if akEventName == LandStart
			DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
		endIf
		if akEventName == Ground
			DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
			CurrentEquippedLeftSpell = PlayerActor.GetEquippedSpell(0)
			if CurrentEquippedLeftSpell != none
				PlayerActor.UnequipSpell(CurrentEquippedLeftSpell, 0)
			endIf
			PlayerActor.UnequipSpell(LeveledDrainSpell, 1)
			PlayerActor.RemoveSpell(LeveledRaiseDeadSpell)
			PlayerActor.RemoveSpell(DLC1CorpseCurse)
			PlayerActor.RemoveSpell(DLC1VampiresGrip)
			PlayerActor.RemoveSpell(DLC1ConjureGargoyleLeftHand)
			PlayerActor.RemoveSpell(SCS_Maelstrom_Spell)
		endIf
		if akEventName == LiftoffStart
			DCL1VampireLevitateStateGlobal.SetValue(2 as Float)
		endIf
		if akEventName == Levitate
			DCL1VampireLevitateStateGlobal.SetValue(2 as Float)
			PlayerActor.EquipSpell(LeveledDrainSpell, 1)
			if (DialogueGenericVampire as vampirequestscript).LastLeftHandSpell == none
				(DialogueGenericVampire as vampirequestscript).LastLeftHandSpell = SCS_VampireSpells_VampireLord_Spell_Spell00_LordsServant_01
			endIf
			if CurrentEquippedLeftSpell == none
				CurrentEquippedLeftSpell = (DialogueGenericVampire as vampirequestscript).LastLeftHandSpell
			endIf
			self.CheckPerkSpells()
			PlayerActor.AddSpell(LeveledRaiseDeadSpell, false)
			PlayerActor.EquipSpell(CurrentEquippedLeftSpell, 0)
			PlayerActor.EquipSpell(LeveledDrainSpell, 1)
		endIf
	endIf
endFunction
