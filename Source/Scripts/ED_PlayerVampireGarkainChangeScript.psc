 Scriptname ED_PlayerVampireGarkainChangeScript extends Quest

Race Property ED_VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto

Message Property PlayerWerewolfFeedMessage auto

ImageSpaceModifier Property WerewolfWarn auto
ImageSpaceModifier Property WerewolfChange auto

Sound Property WerewolfIMODSound auto
Idle Property SpecialFeeding auto

Spell Property ED_VampirePowers_GarkainBeast_lvl10_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl15_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl20_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl25_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl30_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl35_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl40_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl45_Ab auto
Spell Property ED_VampirePowers_GarkainBeast_lvl50Plus_Ab auto

Spell Property FeedBoost auto
Spell property BleedingFXSpell auto
{This Spell is for making the target of feeding bleed.}

Armor Property WolfSkinFXArmor auto

Quest Property DLC1TrackingQuest auto

bool Property Untimed auto

FormList Property CrimeFactions auto

spell property SCS_VampireSpells_Vanilla_Power_Spell_Obfuscate auto
globalvariable property ED_Mechanics_Global_DisableHate auto
location property DLC1VampireCastleLocation auto
location property DLC1VampireCastleGuildhallLocation auto
location property DLC1VampireCastleDungeonLocation auto
faction property DLC1PlayerVampireLordFaction auto
formlist property DLC1VampireHateFactions auto
faction property HunterFaction auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell auto
spell property ED_BeingVampireVL_Vanilla_Ab_SunDamage auto
spell property ED_VampirePowers_GarkainBeast_Change auto
spell property ED_VampirePowers_GarkainBeast_Revert auto
globalvariable property DLC1VampireMaxPerks auto
playervampirequestscript property PlayerVampireQuest auto
spell property SCS_Abilities_Reward_Spell_NoHate auto
perk property DLC1VampireActivationBlocker auto


imagespacemodifier property VampireChange auto
sound property VampireIMODSound auto
effectshader property DLC1VampireChangeBackFXS auto
effectshader property DLC1VampireChangeBack02FXS auto

formlist property ED_VampirePowers_GarkainBeast_Powers_List auto
formlist property DLC1VampireSpellsPowers auto
perk property ED_PerkTree_General_40_EmbraceTheBeast_Perk auto
message property ED_Mechanics_Garkain_ThirstQuenched_Message auto

globalvariable property pDLC1nVampireRingBeast auto
globalvariable property pDLC1nVampireRingErudite auto
globalvariable property pDLC1nVampireNecklaceBats auto
globalvariable property pDLC1nVampireNecklaceGargoyle auto
armor property gargNecklace auto
armor property batNecklace auto
armor property beastRing auto
armor property eruditeRing auto

actor property playerRef auto


DefaultObjectManager kDefObjMan

bool __tryingToShiftBack = false
bool __shiftingBack = false
bool __shuttingDown = false
bool __trackingStarted = false
bool __killmoveStarted = false

Event OnInit()
	kDefObjMan = Game.GetFormFromFile(0x00000031, "Skyrim.esm") as DefaultObjectManager
endEvent

Function SetForm(string key, Form newForm) native

Function PrepShift()

    Debug.Trace("EVERDAMNED: GARKAIN: Prepping shift...")
    

    ; sets up the UI restrictions
    Game.SetBeastForm(True)
    Game.EnableFastTravel(False)

    ; screen effect
    WerewolfChange.Apply()
    WerewolfIMODSound.Play(playerRef)

    ; get rid of your summons
    ;int count = 0
    ;while (count < WerewolfDispelList.GetSize())
    ;    Spell gone = WerewolfDispelList.GetAt(count) as Spell
    ;    if (gone != None)
    ;        Game.GetPlayer().DispelSpell(gone)
    ;    endif
    ;    count += 1
    ;endwhile


    Game.DisablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 1)
    Game.ForceThirdPerson()
    Game.ShowFirstPersonGeometry(false)
EndFunction

Function InitialShift()
    
	Debug.Trace("EVERDAMNED: GARKAIN: Player beginning transformation.")
    WerewolfWarn.Apply()

    if (Game.GetPlayer().IsDead())
        Debug.Trace("EVERDAMNED: GARKAIN: Player is dead; bailing out.")
        return
    endif
	
	; using Vampire Lord setup to track player original race
	
	
	Race currRace = playerRef.GetRace()
	
	if (currRace != ED_VampireGarkainBeastRace)
		Debug.Trace("EVERDAMNED: GARKAIN: Setting original player race before transform.")
		
		DLC1VampireTrackingQuest vts = (DLC1TrackingQuest as DLC1VampireTrackingQuest)
		if (vts.PlayerRace == None)
			Debug.Trace("EVERDAMNED: GARKAIN: DLC1VampireTrackingQuest race is none, setting it to some curr race.")
			vts.PlayerRace = currRace
		else
			Debug.Trace("EVERDAMNED: GARKAIN: DLC1VampireTrackingQuest race was already filled!")
		endif
		
	else
		Debug.Trace("EVERDAMNED: GARKAIN: For some reason InitialShift got callen when player is already Garkain, cant set original race.")
	endif
   
    ; actual switch
    playerRef.SetRace(ED_VampireGarkainBeastRace)
EndFunction

Function StartTracking()
    if (__trackingStarted)
        return
    endif

    __trackingStarted = true
	__killmoveStarted = false

    Debug.Trace("EVERDAMNED: GARKAIN: Race swap done; starting tracking and effects.")
	
	; TODO: vampire rings and trinkets
	
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
	
	if playerRef.hasperk(ED_PerkTree_General_40_EmbraceTheBeast_Perk)
		debug.Trace("Everdamned DEBUG: player has EmbraceTheBeast perk, changing default objects to allow perk menu and power selection")
		kDefObjMan.SetForm("RIVR", ED_VampireGarkainBeastRace)
		kDefObjMan.SetForm("RIVS", ED_VampirePowers_GarkainBeast_Powers_List)
	endif

    Game.GetPlayer().UnequipAll()
	
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
	
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
	playerRef.RemoveSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell)
	playerRef.AddSpell(ED_BeingVampireVL_Vanilla_Ab_SunDamage, false)
	
	playerRef.DispelSpell(ED_VampirePowers_GarkainBeast_Change)
	playerRef.AddSpell(ED_VampirePowers_GarkainBeast_Revert, false)

    ; unequip magic
    Spell left = Game.GetPlayer().GetEquippedSpell(0)
    Spell right = Game.GetPlayer().GetEquippedSpell(1)
    Spell power = Game.GetPlayer().GetEquippedSpell(2)
    Shout voice = Game.GetPlayer().GetEquippedShout()
    if (left != None)
        playerRef.UnequipSpell(left, 0)
    endif
    if (right != None)
        playerRef.UnequipSpell(right, 1)
    endif
    if (power != None)
        playerRef.UnequipSpell(power, 2)
    else
;         Debug.Trace("EVERDAMNED: GARKAIN:No power equipped.")
    endif
    if (voice != None)
        playerRef.UnequipShout(voice)
    else
;         Debug.Trace("EVERDAMNED: GARKAIN:No shout equipped.")
    endif



    ; and some rad claws
    int playerLevel = playerRef.GetLevel()
    if     (playerLevel <= 10)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl10_Ab, false)
    elseif (playerLevel <= 15)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl15_Ab, false)
    elseif (playerLevel <= 20)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl20_Ab, false)
    elseif (playerLevel <= 25)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl25_Ab, false)
    elseif (playerLevel <= 30)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl30_Ab, false)
    elseif (playerLevel <= 35)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl35_Ab, false)
    elseif (playerLevel <= 40)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl40_Ab, false)
    elseif (playerLevel <= 45)
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl45_Ab, false)
    else
        playerRef.AddSpell(ED_VampirePowers_GarkainBeast_lvl50Plus_Ab, false)
    endif

	
	; to catch Brutalize execution, because not all button activation do actually play the animation
	;RegisterForAnimationEvent(playerRef, "KillMoveStart")
	RegisterForAnimationEvent(playerRef, "SoundPlay.NPCWerewolfFeedingKill")
	
    SetStage(10) ; we're done with the transformation handling
EndFunction

; called from stage 11
Function Feed(Actor victim)
;     Debug.Trace("EVERDAMNED: GARKAIN:start newShiftTime = " + GameTimeDaysToRealTimeSeconds(PlayerWerewolfShiftBackTime.GetValue()) + ", __feedExtensionTime = " + GameTimeDaysToRealTimeSeconds(__feedExtensionTime))
    
;     Debug.Trace("EVERDAMNED: GARKAIN:default newShiftTime = " + GameTimeDaysToRealTimeSeconds(newShiftTime) + ", __feedExtensionTime = " + GameTimeDaysToRealTimeSeconds(__feedExtensionTime))
    Debug.Trace("EVERDAMNED: GARKAIN: FEEEEEEEED")
    playerRef.PlayIdle(SpecialFeeding)
    
    ;This is for adding a spell that simulates bleeding
    BleedingFXSpell.Cast(victim,victim)
	Debug.Notification("This is FEED func from quest!")
    
	;PlayerWerewolfFeedMessage.Show()
	;FeedBoost.Cast(Game.GetPlayer())
	; victim.SetActorValue("Variable08", 100)
	if !(playerRef.hasperk(ED_PerkTree_General_40_EmbraceTheBeast_Perk)) && GetStage() < 80
		debug.Trace("Everdamned INFO: Untamed Garkain just fed on corpse, reverting to mortal when out of combat")
		Message.ResetHelpMessage("ed_garkain_thirstquenched")
		ED_Mechanics_Garkain_ThirstQuenched_Message.ShowAsHelpMessage("ed_garkain_thirstquenched", 3.0, 1.0, 1)
		SetStage(80)
	else
		SetStage(10)
	endif
EndFunction

; called from stage 80
function ShiftBackWhenOutOfCombat()
	if !(playerRef.isincombat())
		debug.Trace("Everdamned DEBUG: ShiftBackWhenOutOfCombat called to revert from Garkain, but player in combat")
		ED_VampirePowers_GarkainBeast_Revert.Cast(playerRef, playerRef)
	else
		debug.Trace("Everdamned INFO: ShiftBackWhenOutOfCombat called to revert from Garkain, out of combat, commencing revert")
		RegisterForSingleUpdate(10.0)
	endif 
endfunction

Event OnUpdate()
	if GetStage() == 80
		ShiftBackWhenOutOfCombat()
	endif
EndEvent

function Revert()

	Debug.Trace("Everdamned DEBUG: Garkain quest REVERT got called.")
	
	if game.QueryStat("NumVampirePerks") as Float >= DLC1VampireMaxPerks.value
		game.AddAchievement(58)
	endIf
	self.UnregisterForUpdate()
	self.SetStage(100)
endFunction

; called from stage 20
Function WarnPlayer()
    Debug.Trace("Everdamned DEBUG: Player about to transform back.")
    WerewolfWarn.Apply()
EndFunction


; called from stage 100
Function ShiftBack()
    __tryingToShiftBack = true

    while (Game.GetPlayer().GetAnimationVariableBool("bIsSynced"))
        Debug.Trace("EVERDAMNED: GARKAIN: Waiting for synced animation to finish...")
        Utility.Wait(0.1)
    endwhile
    Debug.Trace("EVERDAMNED: GARKAIN: Sending transform event to turn player back to normal.")

    __shiftingBack = false

    ActuallyShiftBackIfNecessary()
EndFunction

Function ActuallyShiftBackIfNecessary()
    if (__shiftingBack)
        return
    endif

    __shiftingBack = true

    Debug.Trace("EVERDAMNED: GARKAIN: Player returning to normal.")
	
	; screen effect
    ;WerewolfChange.Apply()
    ;WerewolfIMODSound.Play(playerRef)
	 
	playerRef.GetActorBase().SetInvulnerable(true)
	playerRef.SetGhost(true)
    Game.SetInCharGen(true, true, false)
	

    UnRegisterForAnimationEvent(playerRef, "KillMoveStart")
	UnRegisterForAnimationEvent(playerRef, "SoundPlay.NPCWerewolfFeedingKill")
    UnRegisterForUpdate() ; just in case

    if (Game.GetPlayer().IsDead())
        Debug.Trace("EVERDAMNED: GARKAIN: Player is dead; bailing out.")
        return
    endif
	
	VampireChange.Apply(1.00000)
	VampireIMODSound.Play(playerRef as objectreference)
	;DLC1VampireChangeBackFXS.Play(playerRef as objectreference, 5.0000)
	
	;;; REMOVE SPELLS
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl10_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl15_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl20_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl25_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl30_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl35_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl40_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl45_Ab)
	playerRef.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl50Plus_Ab)
	
	playerRef.RemoveSpell(ED_BeingVampireVL_Vanilla_Ab_SunDamage)

    ; make sure your health is reasonable before turning you back
    float currHealth = Game.GetPlayer().GetAV("health")
    if (currHealth <= 101)
        Debug.Trace("EVERDAMNED: GARKAIN: Player's health is only " + currHealth + "; restoring.")
        Game.GetPlayer().RestoreAV("health", 101 - currHealth)
    endif

    ; change you back
	DLC1VampireTrackingQuest vts = (DLC1TrackingQuest as DLC1VampireTrackingQuest)
	Race originalRace = vts.PlayerRace
    Debug.Trace("EVERDAMNED: GARKAIN: Setting race " + originalRace + " on " + playerRef)
	utility.Wait(3)
    playerRef.SetRace(originalRace)
	
	PlayerVampireQuest.VampireProgression(playerRef, PlayerVampireQuest.VampireStatus)
	;DLC1VampireChangeBackFXS.Stop(playerRef as objectreference)
	;DLC1VampireChangeBack02FXS.Play(playerRef as objectreference, 0.100000)
	
	playerRef.RemoveFromFaction(DLC1PlayerVampireLordFaction)
	HunterFaction.SetPlayerEnemy(false)
	if !playerRef.IsInLocation(DLC1VampireCastleLocation) && !playerRef.IsInLocation(DLC1VampireCastleGuildhallLocation) && !playerRef.IsInLocation(DLC1VampireCastleDungeonLocation)
		game.SendWereWolfTransformation()
	endIf
	
	if PlayerVampireQuest.VampireStatus < 4 || ED_Mechanics_Global_DisableHate.GetValue() == 1 as Float || playerRef.HasSpell(SCS_Abilities_Reward_Spell_NoHate as form)
		playerRef.SetAttackActorOnSight(false)
		Int i = 0
		while i < DLC1VampireHateFactions.GetSize()
			(DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(false)
			i += 1
		endWhile
	endIf
	
    ; and you're now recognized
    Game.SetPlayerReportCrime(true)

    ; give the set race event a chance to come back, otherwise shut us down
    Utility.Wait(5)
    Shutdown()
EndFunction

Function Shutdown()
    if (__shuttingDown)
        return
    endif

    __shuttingDown = true
	
	kDefObjMan.SetForm("RIVR", DLC1VampireBeastRace)
	kDefObjMan.SetForm("RIVS", DLC1VampireSpellsPowers)

    playerRef.GetActorBase().SetInvulnerable(false)
    playerRef.SetGhost(false)
    Game.SetBeastForm(False)
    Game.EnableFastTravel(True)
	Game.EnablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abLooking = false, abSneaking = false, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 1)
    Game.ShowFirstPersonGeometry(true)
	Game.SetInCharGen(false, false, false)

	playerRef.RemovePerk(DLC1VampireActivationBlocker)
	
    Stop()
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    ;if (asEventName == "KillMoveStart")
		;debug.Notification("Triggered KillMoveStart animation event!")
		;__killmoveStarted = true
		
		; so that if there is no followup for some reason we invalidate
		;RegisterForSingleUpdate(10)
	if (asEventName == "SoundPlay.NPCWerewolfFeedingKill")
		
		; TODO: capture killmove target somehow
		; probaby should use a new quest that will find "closest" target that is in pairedanim
		; in worst case we end up using a different actor to calcuate HpEaten
		
		; do the same for Vampire Lord
	
		if __killmoveStarted || !(playerRef.IsInKillMove())
			return
		endif
		__killmoveStarted = true
		utility.wait(2)
		;UnregisterForUpdate()
		ED_Mechanics_GarkainBeast_EatenCloak.Cast(playerRef, playerRef)
		ED_Mechanics_GarkainBeast_CombatFeed.Cast(playerRef, playerRef)
		PlayerVampireQuest.VampireFeed()
		if !(playerRef.hasperk(ED_PerkTree_General_40_EmbraceTheBeast_Perk)) && GetStage() < 80
			debug.Trace("Everdamned INFO: Untamed Garkain just Brutalized/killfed on an actor, reverting to mortal when out of combat")
			Message.ResetHelpMessage("ed_garkain_thirstquenched")
			ED_Mechanics_Garkain_ThirstQuenched_Message.ShowAsHelpMessage("ed_garkain_thirstquenched", 3.0, 1.0, 1)
			SetStage(80)
		endif
		__killmoveStarted = false
    endif
EndEvent


Spell Property ED_Mechanics_GarkainBeast_CombatFeed Auto
Spell Property ED_Mechanics_GarkainBeast_EatenCloak Auto
