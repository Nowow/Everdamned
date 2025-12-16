scriptName DLC1PlayerVampireChangeScript extends Quest

; EVERDAMNED script, remove this comment later

idle property SpecialFeeding auto

;globalvariable property SCS_PowerBite auto
;perk property SCS_BloodStorm_Perk auto

String property LandStart = "LandStart" auto
String property Levitate = "LevitateStart" auto
String property BiteStart = "BiteStart" auto
String property TransformToHuman = "TransformToHuman" auto
String property LiftoffStart = "LiftoffStart" auto
String property Ground = "GroundStart" auto

Float property UnearthlyWillExtensionTimeSeconds auto
{How long (in real seconds) that feeding extends vampire time}
Float property StandardDurationSeconds auto
{How long (in real seconds) the transformation lasts}
Float property DurationWarningTimeSeconds auto
{How long (in real seconds) before turning back we should warn the player}
Float property DLC1BiteHealthRecover auto

Bool property Untimed auto
Bool property DLC1HasLightfoot auto

spell property ED_VampirePowers_Ab_Masquerade_Spell auto
perk property ED_PerkTreeVL_Amaranth_Perk auto

spell property LeveledDrainSpell auto
spell property LeveledAbility auto
spell property LeveledRaiseDeadSpell auto
spell property CurrentEquippedLeftSpell auto
spell property ED_VampireSpellsVL_Vanilla_VampiricDrain_Spell auto
spell property ED_VampireSpellsVL_Raze_Spell auto
spell property ED_VampireSpellsVL_LordsServant_Spell auto
spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell auto
spell property DLC1VampireDetectLife auto
spell property DLC1NightCloak auto
spell property ED_VampireSpellsVL_Maelstrom_Spell auto
spell property DLC1ConjureGargoyleLeftHand auto
spell property DLC1VampiresGrip auto
spell property DLC1VampireBats auto
spell property DLC1VampireMistform auto
spell property ED_VampirePowersVL_RoyalGuardian_Ab_Spell auto
spell property ED_VampireSpellsVL_FlamesOfColdharbour_Spell auto
spell property ED_VampireSpellsVL_MarchingFlesh_Spell auto
spell property ED_VampireSpellsVL_IcyWinds_Spell auto
spell property ED_VampireSpellsVL_ShamblingHordes_Spell auto

spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_10_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_15_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_20_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_25_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_30_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_35_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_40_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_45_Spell auto
spell property ED_BeingVampireVL_Ab_LevelledPassive_50_Spell auto
spell property ED_BeingVampireVL_Vanilla_Ab_SunDamage auto

spell property FeedBoost auto
spell property DLC1Revert auto
spell property DLC1AbVampireFloatBodyFX auto

spell property DLC1VampireChange auto
spell property BleedingFXSpell auto
{This Spell is for making the target of feeding bleed.}
spell property DLC1CorpseCurse auto
;spell property DLC1SupernaturalReflexes auto

sound property NPCVampireTransformation auto

globalvariable property DLC1BloodMagic auto
globalvariable property DLC1VampireNextPerk auto
globalvariable property DLC1MistformCount auto
globalvariable property GameDaysPassed auto
globalvariable property pDLC1nVampireRingBeast auto
globalvariable property ED_Mechanics_Global_DisableHate auto
globalvariable property pDLC1nVampireNecklaceGargoyle auto
globalvariable property DLC1VampireBloodPoints auto
globalvariable property TimeScale auto
globalvariable property pDLC1nVampireNecklaceBats auto
;globalvariable property DLC1NightPower auto
globalvariable property PlayerVampireShiftBackTime auto
globalvariable property DLC1VampirePerkPoints auto
globalvariable property DLC1VampireTotalPerksEarned auto
globalvariable property DLC1ReflexesCount auto
globalvariable property VampireFeedReady auto
globalvariable property DLC1VampireMaxPerks auto
globalvariable property DCL1VampireLevitateStateGlobal auto
{This Global tracks what state the Vampire Lord is in: 0 = Not a Vampire Lord, 1 = Walking, 2 = Levitating}
globalvariable property pDLC1nVampireRingErudite auto

perk property LightFoot auto
perk property ED_PerkTreeVL_Raze_Perk auto
perk property ED_PerkTreeVL_Maelstrom_Perk auto
perk property DLC1DetectLifePerk auto
perk property DLC1MistFormPerk auto
;perk property DLC1SupernaturalReflexesPerk auto
perk property DLC1NightCloakPerk auto
perk property DLC1VampireActivationBlocker auto
perk property DLC1VampiricGrip auto
perk property DLC1UnearthlyWill auto
perk property DLC1GargoylePerk auto

perk property ED_PerkTreeVL_RoyalGuardian_Perk auto
perk property ED_PerkTreeVL_FlamesOfColdharbour_Perk auto
perk property ED_PerkTreeVL_MarchingFlesh_Perk auto
perk property ED_PerkTreeVL_IcyWinds_Perk auto
perk property ED_PerkTreeVL_ShamblingHordes_Perk auto
perk property DLC1CorpseCursePerk auto

faction property HunterFaction auto
faction property DLC1PlayerVampireLordFaction auto

location property DLC1VampireCastleLocation auto
location property DLC1VampireCastleDungeonLocation auto
location property DLC1VampireCastleGuildhallLocation auto

message property PlayerVampireExpirationWarning auto
message property PlayerVampireFeedMessage auto
message property DLC1BloodPointsMsg auto
message property DLC1VampirePerkEarned auto

formlist property DLC1VampireHateFactions auto
formlist property ED_Mechanics_FormList_VLDispelList auto

armor property DLC1VampireLordArmor auto
armor property gargNecklace auto
armor property DLC1ClothesVampireLordRoyalArmor auto
armor property batNecklace auto
armor property beastRing auto
armor property eruditeRing auto

Quest property DialogueGenericVampire auto
Quest property VampireTrackingQuest auto

imagespacemodifier property VampireWarn auto
imagespacemodifier property VampireChange auto
effectshader property DLC1VampireChangeBack02FXS auto
effectshader property DLC1VampireChangeBackFXS auto






sound property VampireIMODSound auto

race property VampireLordRace auto

magiceffect property DLC1RevertEffect auto

visualeffect property FeedBloodVFX auto
{Visual Effect on Wolf for Feeding Blood}

playervampirequestscript property PlayerVampireQuest auto
ED_FeedManager_Script property ED_FeedManager_Quest auto

formlist property DLC1VampireSpellsPowers auto

DefaultObjectManager kDefObjMan
Event OnInit()
	kDefObjMan = Game.GetFormFromFile(0x00000031, "Skyrim.esm") as DefaultObjectManager
endEvent

;-- Variables ---------------------------------------
Float __UnearthlyWillExtensionTime = -1.00000
Float __durationWarningTime = -1.00000
Bool __tryingToShiftBack = false
Bool __trackingStarted = false
Bool __prepped = false
Bool __shiftingBack = false
Bool __shuttingDown = false

Bool function TestIntegrity()
	debug.Trace("Everdamned DEBUG: DLC1PlayerVampireChangeScript integrity tested!")
    return true
endFunction
Bool function TestIntegrityEverdamned()
	debug.Trace("Everdamned DEBUG: DLC1PlayerVampireChangeScript Everdamned integrity tested!")
    return true
endFunction


function OnUpdate()

	game.SetInCharGen(false, false, false)
	if game.QueryStat("NumVampirePerks") as Float >= DLC1VampireMaxPerks.value
		game.AddAchievement(58)
	endIf
	if Untimed
		return 
	endIf
	if playerRef.HasMagicEffect(DLC1RevertEffect) && !playerRef.IsInKillMove() && !__tryingToShiftBack
		self.Revert()
	else
		game.ForceThirdPerson()
	endIf
endFunction

; done
function Shutdown()

	if __shuttingDown
		return 
	endIf
	__shuttingDown = true
	DCL1VampireLevitateStateGlobal.SetValue(0 as Float)
	playerRef.GetActorBase().SetInvulnerable(false)
	playerRef.SetGhost(false)
	game.SetBeastForm(false)
	game.EnableFastTravel(true)
	game.SetInCharGen(false, false, false)
	playerRef.RemovePerk(DLC1VampireActivationBlocker)
	
	; adding here because it is attached to mortal vampire races, but not to VL
	; consider adding it to VL to not do this
	; UPD: not doing it because of khajiit
	;playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell)
	self.UnloadSpells()
	game.EnablePlayerControls(false, false, true, true, true, false, false, false, 1)
	self.Stop()
endFunction

function Feed(actor victim)

	; Empty function
endFunction

function UnregisterForEvents()

	self.UnRegisterForAnimationEvent(playerRef as objectreference, Ground)
	self.UnRegisterForAnimationEvent(playerRef as objectreference, Levitate)
	self.UnRegisterForAnimationEvent(playerRef as objectreference, BiteStart)
	self.UnRegisterForAnimationEvent(playerRef as objectreference, LiftoffStart)
	self.UnRegisterForAnimationEvent(playerRef as objectreference, LandStart)
	self.UnRegisterForAnimationEvent(playerRef as objectreference, TransformToHuman)
	
	;maybe dont need it, since game automatically unregisters animevents on racechange
	ED_FeedManager_Quest.UnRegisterFeedEvents()

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
	
	LeveledDrainSpell.Preload()
	LeveledRaiseDeadSpell.Preload()
	DLC1VampiresGrip.Preload()
	DLC1ConjureGargoyleLeftHand.Preload()
	DLC1CorpseCurse.Preload()
	ED_VampireSpellsVL_Maelstrom_Spell.Preload()
	
	ED_VampireSpellsVL_FlamesOfColdharbour_Spell.Preload()
	ED_VampireSpellsVL_ShamblingHordes_Spell.Preload()
	ED_VampireSpellsVL_IcyWinds_Spell.Preload()
endFunction


; called from StartTracking()
function RegisterForEvents()

	self.RegisterForAnimationEvent(playerRef as objectreference, Ground)
	self.RegisterForAnimationEvent(playerRef as objectreference, Levitate)
	self.RegisterForAnimationEvent(playerRef as objectreference, BiteStart)
	self.RegisterForAnimationEvent(playerRef as objectreference, LiftoffStart)
	self.RegisterForAnimationEvent(playerRef as objectreference, LandStart)
	self.RegisterForAnimationEvent(playerRef as objectreference, TransformToHuman)
	
	;maybe dont need to call here, just rely on OnRaceSwitchComplete in ED_FeedManager_PlayerAlias script
	ED_FeedManager_Quest.RegisterFeedEvents()
	
endFunction

Float function RealTimeSecondsToGameTimeDays(Float realtime)

	Float scaledSeconds = realtime * TimeScale.value
	return scaledSeconds / (60 * 60 * 24) as Float
endFunction

; called from this quest's alias script on OnRaceSwitchComplete
function StartTracking()

	if __trackingStarted
		debug.Trace("Everdamned DEBUG: Vampire Lord script StartTracking() called, but already __trackingStarted == true")
		return 
	endIf
	__trackingStarted = true
	
	debug.Trace("Everdamned DEBUG: Vampire Lord StartTracking()")
	kDefObjMan.SetForm("RIVR", VampireLordRace)
	kDefObjMan.SetForm("RIVS", DLC1VampireSpellsPowers)
	
	if playerRef.IsEquipped(beastRing as form)
		pDLC1nVampireRingBeast.SetValue(1 as Float)
	endIf
	if playerRef.IsEquipped(eruditeRing as form)
		pDLC1nVampireRingErudite.SetValue(1 as Float)
	endIf
	if playerRef.IsEquipped(batNecklace as form)
		pDLC1nVampireNecklaceBats.SetValue(1 as Float)
	endIf
	if playerRef.IsEquipped(gargNecklace as form)
		pDLC1nVampireNecklaceGargoyle.SetValue(1 as Float)
	endIf
	self.RegisterForEvents()
	DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
	
	;not need dispel this spell because no such spell will be? idk
	;playerRef.DispelSpell(SCS_VampireSpells_Vanilla_Power_Spell_Obfuscate)
	playerRef.UnequipAll()
	
	if playerRef.HasPerk(ED_PerkTreeVL_Amaranth_Perk)
		playerRef.EquipItem(DLC1ClothesVampireLordRoyalArmor as form, false, true)
	else
		playerRef.EquipItem(DLC1VampireLordArmor as form, false, true)
	endIf
	
	if ED_Mechanics_Global_DisableHate.GetValue() == 0 as Float
		if !playerRef.IsInLocation(DLC1VampireCastleLocation) && !playerRef.IsInLocation(DLC1VampireCastleGuildhallLocation) && !playerRef.IsInLocation(DLC1VampireCastleDungeonLocation)
			playerRef.SetAttackActorOnSight(true)
			game.SendWereWolfTransformation()
		endIf
		playerRef.AddToFaction(DLC1PlayerVampireLordFaction)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(true)
			i += 1
		endWhile
		HunterFaction.SetPlayerEnemy(true)
	endIf
	game.SetPlayerReportCrime(false)
	;do we need that?
	__durationWarningTime = self.RealTimeSecondsToGameTimeDays(DurationWarningTimeSeconds)
	__UnearthlyWillExtensionTime = self.RealTimeSecondsToGameTimeDays(UnearthlyWillExtensionTimeSeconds)
	
	playerRef.RestoreActorValue("Health", 100 as Float)
	
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell)
	playerRef.AddSpell(LeveledAbility, false)
	playerRef.AddSpell(ED_BeingVampireVL_Vanilla_Ab_SunDamage, false)
	
	playerRef.addperk(ED_Mechanics_Perk_VLVampiresSightCrutch)
	
	; adding here because it is attached to mortal vampire races, but not to VL
	; consider adding it to VL to not do this
	; UPD: added to alias
	;playerRef.AddSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell, false)
	playerRef.AddSpell(DLC1Revert, false)
	playerRef.AddSpell(DLC1VampireBats, false)
	playerRef.EquipSpell((DialogueGenericVampire as vampirequestscript).LastPower, 2)
	self.CheckPerkSpells()

	if playerRef.HasPerk(LightFoot)
		DLC1HasLightfoot = true
	else
		DLC1HasLightfoot = false
		playerRef.AddPerk(LightFoot)
	endIf
	
	Float currentTime = GameDaysPassed.GetValue()
	; ??? needed?
	Float regressTime = currentTime + self.RealTimeSecondsToGameTimeDays(StandardDurationSeconds)
	if playerRef.HasPerk(DLC1UnearthlyWill)
		regressTime += __UnearthlyWillExtensionTime
	endIf
	
	PlayerVampireShiftBackTime.SetValue(regressTime)
	playerRef.DispelSpell(DLC1VampireChange)
	self.RegisterForUpdate(3.00000)
	self.SetStage(10)
endFunction

function PrepShift()

	VampireChange.Apply(1.00000)
	VampireIMODSound.Play(playerRef)
	game.SetInCharGen(true, true, false)
	playerRef.AddPerk(DLC1VampireActivationBlocker)
	game.SetBeastForm(true)
	game.EnableFastTravel(false)
	playerRef.SetActorValue("GrabActorOffset", 70 as Float)
	Int Count = 0
	
	;dispells werewolf and certain VL summon/reanimate spells, all of that probably obsolete
	while Count < ED_Mechanics_FormList_VLDispelList.GetSize()
		spell Gone = ED_Mechanics_FormList_VLDispelList.GetAt(Count) as spell
		if Gone != none
			playerRef.DispelSpell(Gone)
		endIf
		Count += 1
	endWhile
	
	game.DisablePlayerControls(false, false, true, false, false, false, false, false, 1)
	game.ForceThirdPerson()
	game.ShowFirstPersonGeometry(false)
	self.EstablishLeveledSpells()
	self.PreloadSpells()
	
	spell CurrentEquippedLeftSpellMortal = playerRef.GetEquippedSpell(0)
	; unequipping left hand spell so that spell cost abilities do not carry over
	playerRef.UnequipSpell(CurrentEquippedLeftSpellMortal, 0)
	
	__prepped = true
endFunction

function UnloadSpells()

	LeveledDrainSpell.Unload()
	LeveledRaiseDeadSpell.Unload()
	DLC1VampiresGrip.Unload()
	DLC1ConjureGargoyleLeftHand.Unload()
	;gutwrench
	DLC1CorpseCurse.Unload()
	ED_VampireSpellsVL_Maelstrom_Spell.Unload()
	
	ED_VampireSpellsVL_FlamesOfColdharbour_Spell.Unload()
	ED_VampireSpellsVL_ShamblingHordes_Spell.Unload()
	ED_VampireSpellsVL_IcyWinds_Spell.Unload()
endFunction

function CheckPerkSpells()
	
	if playerRef.HasPerk(DLC1GargoylePerk) && !playerRef.HasSpell(DLC1ConjureGargoyleLeftHand)
		playerRef.AddSpell(DLC1ConjureGargoyleLeftHand, false)
	endIf
	if playerRef.HasPerk(DLC1MistFormPerk) && !playerRef.HasSpell(DLC1VampireMistform as form) && DLC1MistformCount.GetValue() < 1 as Float
		playerRef.AddSpell(DLC1VampireMistform, false)
	endIf
	if playerRef.HasPerk(DLC1DetectLifePerk) && !playerRef.HasSpell(DLC1VampireDetectLife as form)
		playerRef.AddSpell(DLC1VampireDetectLife, false)
	endIf
	if playerRef.HasPerk(DLC1NightCloakPerk) && !playerRef.HasSpell(DLC1NightCloak as form)
		playerRef.AddSpell(DLC1NightCloak, false)
	endIf
		if playerRef.HasPerk(DLC1VampiricGrip) && !playerRef.HasSpell(DLC1VampiresGrip as form)
		playerRef.AddSpell(DLC1VampiresGrip, false)
	endIf
	;gutwrench
	if playerRef.HasPerk(DLC1CorpseCursePerk) && !playerRef.HasSpell(DLC1CorpseCurse as form)
		playerRef.AddSpell(DLC1CorpseCurse, false)
	endIf
	
	if playerRef.HasPerk(ED_PerkTreeVL_RoyalGuardian_Perk) && !playerRef.HasSpell(ED_VampirePowersVL_RoyalGuardian_Ab_Spell)
		playerRef.AddSpell(ED_VampirePowersVL_RoyalGuardian_Ab_Spell, false)
	endIf
	if playerRef.HasPerk(ED_PerkTreeVL_FlamesOfColdharbour_Perk) && !playerRef.HasSpell(ED_VampireSpellsVL_FlamesOfColdharbour_Spell)
		playerRef.AddSpell(ED_VampireSpellsVL_FlamesOfColdharbour_Spell, false)
	endIf

	if playerRef.HasPerk(ED_PerkTreeVL_MarchingFlesh_Perk) && !playerRef.HasSpell(ED_VampireSpellsVL_MarchingFlesh_Spell as form)
		playerRef.AddSpell(ED_VampireSpellsVL_MarchingFlesh_Spell, false)
	endIf
	if playerRef.HasPerk(ED_PerkTreeVL_IcyWinds_Perk) && !playerRef.HasSpell(ED_VampireSpellsVL_IcyWinds_Spell as form)
		playerRef.AddSpell(ED_VampireSpellsVL_IcyWinds_Spell, false)
	endIf
	if playerRef.HasPerk(ED_PerkTreeVL_ShamblingHordes_Perk) && !playerRef.HasSpell(ED_VampireSpellsVL_ShamblingHordes_Spell as form)
		playerRef.AddSpell(ED_VampireSpellsVL_ShamblingHordes_Spell, false)
	endIf
	if playerRef.HasPerk(ED_PerkTreeVL_Maelstrom_Perk) && !playerRef.HasSpell(ED_VampireSpellsVL_Maelstrom_Spell as form)
		playerRef.AddSpell(ED_VampireSpellsVL_Maelstrom_Spell, false)
	endIf
	
	
	; The Reaping, have celerity now
	;if playerRef.HasPerk(DLC1SupernaturalReflexesPerk) && !playerRef.HasSpell(DLC1SupernaturalReflexes as form) && DLC1ReflexesCount.GetValue() < 1 as Float
	;	playerRef.AddSpell(DLC1SupernaturalReflexes, false)
	;endIf
	
	; made it into ability
	;if playerRef.HasPerk(SCS_Tremble_Perk) && !playerRef.HasSpell(SCS_Tremble_Spell as form) && SCS_VampireLordDark_Tremble_Count.GetValue() < 1 as Float
	;	playerRef.AddSpell(SCS_Tremble_Spell, false)
	;endIf	
	
endFunction

; done
function EstablishLeveledSpells()

	Int PlayerLevel = playerRef.GetLevel()
	bool PlayerHasRaze = playerRef.HasPerk(ED_PerkTreeVL_Raze_Perk)
	
	if playerRef.HasPerk(ED_PerkTreeVL_Raze_Perk)
		LeveledDrainSpell = ED_VampireSpellsVL_Raze_Spell
	else
		LeveledDrainSpell = ED_VampireSpellsVL_Vanilla_VampiricDrain_Spell
	endif
	
	LeveledRaiseDeadSpell = ED_VampireSpellsVL_LordsServant_Spell

	if PlayerLevel <= 10
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_10_Spell
	elseIf PlayerLevel <= 15
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_15_Spell
	elseIf PlayerLevel <= 20
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_20_Spell
	elseIf PlayerLevel <= 25
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_25_Spell
	elseIf PlayerLevel <= 30
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_30_Spell
	elseIf PlayerLevel <= 35
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_35_Spell
	elseIf PlayerLevel <= 40
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_40_Spell
	elseIf PlayerLevel <= 45
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_45_Spell
	else
		LeveledAbility = ED_BeingVampireVL_Ab_LevelledPassive_50_Spell
	endIf
endFunction

function InitialShift()

	VampireWarn.Apply(1.00000)
	if playerRef.IsDead()
		return 
	endIf
	playerRef.GetActorBase().SetInvulnerable(true)
	playerRef.SetGhost(true)
	playerRef.SetRace(VampireLordRace)
	playerRef.AddSpell(DLC1AbVampireFloatBodyFX, false)
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

	if __shiftingBack
		return 
	endIf
	__shiftingBack = true
	playerRef.GetActorBase().SetInvulnerable(true)
	playerRef.SetGhost(true)
	if !DLC1HasLightfoot
		playerRef.RemovePerk(LightFoot)
	endIf
	self.UnregisterForEvents()
	DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
	game.SetInCharGen(true, true, false)
	self.UnregisterForUpdate()
	if playerRef.IsDead()
		return 
	endIf
	VampireChange.Apply(1.00000)
	VampireIMODSound.Play(playerRef as objectreference)
	DLC1VampireChangeBackFXS.Play(playerRef as objectreference, 12.0000)
	playerRef.RestoreActorValue("Health", 100 as Float)
	Int Count = 0
	
	while Count < ED_Mechanics_FormList_VLDispelList.GetSize()
		spell Gone = ED_Mechanics_FormList_VLDispelList.GetAt(Count) as spell
		if Gone != none
			playerRef.DispelSpell(Gone)
		endIf
		Count += 1
	endWhile
	
	; if player does not have the perk, spell ends.
	; if player has, reanimated undead is stored until he transforms back
	if !(playerRef.HasPerk(ED_PerkTreeVL_UndyingLoyalty_Perk))
		playerRef.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell)
	endif
	
	;wassail
	;playerRef.DispelSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc)
	
	CurrentEquippedLeftSpell = playerRef.GetEquippedSpell(0)
	(DialogueGenericVampire as vampirequestscript).LastLeftHandSpell = CurrentEquippedLeftSpell
	if playerRef.GetEquippedSpell(2) == DLC1Revert
		(DialogueGenericVampire as vampirequestscript).LastPower = DLC1VampireBats
	else
		(DialogueGenericVampire as vampirequestscript).LastPower = playerRef.GetEquippedSpell(2)
	endIf
	
	; unequipping left hand spell so that spell cost abilities do not carry over
	playerRef.UnequipSpell(CurrentEquippedLeftSpell, 0)
	
	playerRef.RemoveSpell(LeveledDrainSpell)
	playerRef.RemoveSpell(LeveledRaiseDeadSpell)
	playerRef.RemoveSpell(LeveledAbility)

	playerRef.RemoveSpell(DLC1VampiresGrip)
	;playerRef.RemoveSpell(DLC1ConjureGargoyleLeftHand)
	;player has this in mortal form as well
	if playerRef.HasPerk(DLC1GargoylePerk) && !playerRef.HasSpell(DLC1ConjureGargoyleLeftHand)
		playerRef.AddSpell(DLC1ConjureGargoyleLeftHand, false)
	endIf
	
	playerRef.RemoveSpell(DLC1VampireDetectLife)
	playerRef.RemoveSpell(DLC1VampireMistform)
	playerRef.RemoveSpell(DLC1VampireBats)
	playerRef.RemoveSpell(DLC1NightCloak)
	playerRef.RemoveSpell(DLC1Revert)
	
	playerRef.RemoveSpell(ED_BeingVampireVL_Vanilla_Ab_SunDamage)
	
	; here because of mortal races that do not have
	; vamp sight by default and are also given it by script
	playerRef.RemovePerk(ED_Mechanics_Perk_VLVampiresSightCrutch)

	playerRef.RemoveSpell(ED_VampireSpellsVL_Maelstrom_Spell)
	playerRef.RemoveSpell(ED_VampireSpellsVL_FlamesOfColdharbour_Spell)
	playerRef.RemoveSpell(ED_VampireSpellsVL_IcyWinds_Spell)
	playerRef.RemoveSpell(ED_VampireSpellsVL_MarchingFlesh_Spell)
	playerRef.RemoveSpell(ED_VampireSpellsVL_ShamblingHordes_Spell)
	playerRef.RemoveSpell(ED_VampirePowersVL_RoyalGuardian_Ab_Spell)
	
	playerRef.RemoveSpell(DLC1CorpseCurse)
	;playerRef.RemoveSpell(DLC1SupernaturalReflexes)
	
	playerRef.DispelSpell(DLC1VampireDetectLife)
	playerRef.DispelSpell(DLC1VampireMistform)
	playerRef.DispelSpell(DLC1Revert)
	playerRef.RemoveSpell(DLC1AbVampireFloatBodyFX)
	pDLC1nVampireNecklaceBats.SetValue(0 as Float)
	pDLC1nVampireNecklaceGargoyle.SetValue(0 as Float)
	pDLC1nVampireRingBeast.SetValue(0 as Float)
	pDLC1nVampireRingErudite.SetValue(0 as Float)
	
	PlayerVampireQuest.VampireProgression(playerRef, PlayerVampireQuest.VampireStatus)
	playerRef.RemoveItem(DLC1VampireLordArmor as form, 2, true, none)
	playerRef.RemoveItem(DLC1ClothesVampireLordRoyalArmor as form, 2, true, none)
	playerRef.SetRace((VampireTrackingQuest as dlc1vampiretrackingquest).PlayerRace)
	DLC1VampireChangeBackFXS.Stop(playerRef as objectreference)
	DLC1VampireChangeBack02FXS.Play(playerRef as objectreference, 0.100000)
	game.ShowFirstPersonGeometry(true)
	playerRef.RemoveFromFaction(DLC1PlayerVampireLordFaction)
	HunterFaction.SetPlayerEnemy(false)
	if !playerRef.IsInLocation(DLC1VampireCastleLocation) && !playerRef.IsInLocation(DLC1VampireCastleGuildhallLocation) && !playerRef.IsInLocation(DLC1VampireCastleDungeonLocation)
		game.SendWereWolfTransformation()
	endIf
	

	if PlayerVampireQuest.VampireStatus < 4 || ED_Mechanics_Global_DisableHate.GetValue() == 1 as Float || playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
		playerRef.SetAttackActorOnSight(false)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(false)
			i += 1
		endWhile
	endIf
	game.SetPlayerReportCrime(true)
	utility.Wait(5.00000)
endFunction

;done
function ShiftBack()

	__tryingToShiftBack = true
	while playerRef.GetAnimationVariableBool("bIsSynced")
		utility.Wait(0.100000)
	endWhile
	__shiftingBack = false
	self.ActuallyShiftBackIfNecessary()
endFunction

function OnAnimationEvent(objectreference akActor, String akEventName)

	if akActor == playerRef as objectreference
		if akEventName == TransformToHuman
			self.ActuallyShiftBackIfNecessary()
		endIf

		if akEventName == BiteStart
			DLC1VampireBloodPoints.Mod(3.0)
			if DLC1VampireTotalPerksEarned.value < DLC1VampireMaxPerks.value
				DLC1BloodPointsMsg.Show()
				if DLC1VampireBloodPoints.value >= DLC1VampireNextPerk.value
					
					DLC1VampireBloodPoints.Mod(-DLC1VampireNextPerk.value)
					DLC1VampirePerkPoints.Mod(1.0)
					DLC1VampireTotalPerksEarned.Mod(1.0)
					DLC1VampireNextPerk.Mod(1.0)
					DLC1VampirePerkEarned.Show()
				endIf
			endIf

			playerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100 as Float)
			; that is handled by VampireFeed which gets called from feed manager
			;game.IncrementStat("Necks Bitten", 1)
			
		endIf
		if akEventName == LandStart
			DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
		endIf
		if akEventName == Ground
			DCL1VampireLevitateStateGlobal.SetValue(1 as Float)
			CurrentEquippedLeftSpell = playerRef.GetEquippedSpell(0)
			if CurrentEquippedLeftSpell != none
				playerRef.UnequipSpell(CurrentEquippedLeftSpell, 0)
			endIf
			playerRef.UnequipSpell(LeveledDrainSpell, 1)
			playerRef.RemoveSpell(LeveledRaiseDeadSpell)
			playerRef.RemoveSpell(DLC1CorpseCurse)
			playerRef.RemoveSpell(DLC1VampiresGrip)
			playerRef.RemoveSpell(DLC1ConjureGargoyleLeftHand)
			playerRef.RemoveSpell(ED_VampireSpellsVL_Maelstrom_Spell)
			playerRef.RemoveSpell(ED_VampireSpellsVL_FlamesOfColdharbour_Spell)
			playerRef.RemoveSpell(ED_VampireSpellsVL_IcyWinds_Spell)
			playerRef.RemoveSpell(ED_VampireSpellsVL_MarchingFlesh_Spell)
			playerRef.RemoveSpell(ED_VampireSpellsVL_ShamblingHordes_Spell)

		endIf
		if akEventName == LiftoffStart
			DCL1VampireLevitateStateGlobal.SetValue(2 as Float)
		endIf
		if akEventName == Levitate
			DCL1VampireLevitateStateGlobal.SetValue(2 as Float)
			playerRef.EquipSpell(LeveledDrainSpell, 1)
			if (DialogueGenericVampire as vampirequestscript).LastLeftHandSpell == none
				(DialogueGenericVampire as vampirequestscript).LastLeftHandSpell = ED_VampireSpellsVL_LordsServant_Spell
			endIf
			if CurrentEquippedLeftSpell == none
				CurrentEquippedLeftSpell = (DialogueGenericVampire as vampirequestscript).LastLeftHandSpell
			endIf
			self.CheckPerkSpells()
			playerRef.AddSpell(LeveledRaiseDeadSpell, false)
			playerRef.EquipSpell(CurrentEquippedLeftSpell, 0)
			playerRef.EquipSpell(LeveledDrainSpell, 1)
		endIf
	endIf
endFunction

actor property playerRef auto

perk property ED_PerkTreeVL_UndyingLoyalty_Perk auto
perk property ED_Mechanics_Perk_VLVampiresSightCrutch auto
