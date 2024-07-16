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
globalvariable property SCS_Mechanics_Global_DisableHate auto
location property DLC1VampireCastleLocation auto
location property DLC1VampireCastleGuildhallLocation auto
location property DLC1VampireCastleDungeonLocation auto
faction property DLC1PlayerVampireLordFaction auto
formlist property DLC1VampireHateFactions auto
faction property HunterFaction auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage1 auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage2 auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage3 auto
spell property SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage4 auto
spell property SCS_Abilities_VampireLord_Spell_Ab_VampireLordSunDamage auto
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

DefaultObjectManager kDefObjMan

spell property SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc auto


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
    Actor player = Game.GetPlayer()

    ; sets up the UI restrictions
    Game.SetBeastForm(True)
    Game.EnableFastTravel(False)

    ; screen effect
    WerewolfChange.Apply()
    WerewolfIMODSound.Play(player)

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
	
	Actor PlayerRef = Game.GetPlayer()
	Race currRace = PlayerRef.GetRace()
	
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
    PlayerRef.SetRace(ED_VampireGarkainBeastRace)
EndFunction

Function StartTracking()
    if (__trackingStarted)
        return
    endif

    __trackingStarted = true
	__killmoveStarted = false

    Debug.Trace("EVERDAMNED: GARKAIN: Race swap done; starting tracking and effects.")
	
	; TODO: vampire rings and trinkets
	
	;if PlayerActor.IsEquipped(beastRing as form)
	;	pDLC1nVampireRingBeast.SetValue(1 as Float)
	;endIf
	;if PlayerActor.IsEquipped(eruditeRing as form)
	;	pDLC1nVampireRingErudite.SetValue(1 as Float)
	;endIf
	;if PlayerActor.IsEquipped(batNecklace as form)
	;	pDLC1nVampireNecklaceBats.SetValue(1 as Float)
	;endIf
	;if PlayerActor.IsEquipped(gargNecklace as form)
	;	pDLC1nVampireNecklaceGargoyle.SetValue(1 as Float)
	;endIf 
    
	Actor PlayerActor = Game.GetPlayer()
	
	kDefObjMan.SetForm("RIVR", ED_VampireGarkainBeastRace)
	kDefObjMan.SetForm("RIVS", ED_VampirePowers_GarkainBeast_Powers_List)

    Game.GetPlayer().UnequipAll()
    ;Game.GetPlayer().EquipItem(WolfSkinFXArmor, False, True)
	
	PlayerActor.DispelSpell(SCS_VampireSpells_Vanilla_Power_Spell_Obfuscate)
	
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
	
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage1)
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage2)
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage3)
	PlayerActor.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_SunDamage_Stage4)
	PlayerActor.AddSpell(SCS_Abilities_VampireLord_Spell_Ab_VampireLordSunDamage, false)
	PlayerActor.DispelSpell(ED_VampirePowers_GarkainBeast_Change)
	PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_Revert, false)

    ; unequip magic
    Spell left = Game.GetPlayer().GetEquippedSpell(0)
    Spell right = Game.GetPlayer().GetEquippedSpell(1)
    Spell power = Game.GetPlayer().GetEquippedSpell(2)
    Shout voice = Game.GetPlayer().GetEquippedShout()
    if (left != None)
        PlayerActor.UnequipSpell(left, 0)
    endif
    if (right != None)
        PlayerActor.UnequipSpell(right, 1)
    endif
    if (power != None)
        PlayerActor.UnequipSpell(power, 2)
    else
;         Debug.Trace("EVERDAMNED: GARKAIN:No power equipped.")
    endif
    if (voice != None)
        PlayerActor.UnequipShout(voice)
    else
;         Debug.Trace("EVERDAMNED: GARKAIN:No shout equipped.")
    endif



    ; and some rad claws
    int playerLevel = PlayerActor.GetLevel()
    if     (playerLevel <= 10)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl10_Ab, false)
    elseif (playerLevel <= 15)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl15_Ab, false)
    elseif (playerLevel <= 20)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl20_Ab, false)
    elseif (playerLevel <= 25)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl25_Ab, false)
    elseif (playerLevel <= 30)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl30_Ab, false)
    elseif (playerLevel <= 35)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl35_Ab, false)
    elseif (playerLevel <= 40)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl40_Ab, false)
    elseif (playerLevel <= 45)
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl45_Ab, false)
    else
        PlayerActor.AddSpell(ED_VampirePowers_GarkainBeast_lvl50Plus_Ab, false)
    endif



;     Debug.Trace("EVERDAMNED: GARKAIN:Current day -- " + currentTime)
;     Debug.Trace("EVERDAMNED: GARKAIN:Player will turn back at day " + regressTime)

    ; increment stats
    ;Game.IncrementStat("Werewolf Transformations")

    ; set us up to check when we turn back
    ;RegisterForUpdate(5)
	
	; to catch Brutalize execution, because not all button activation do actually play the animation
	RegisterForAnimationEvent(PlayerActor, "KillMoveStart")
	RegisterForAnimationEvent(PlayerActor, "SoundPlay.NPCWerewolfFeedingKill")
	
    SetStage(10) ; we're done with the transformation handling
EndFunction

; called from stage 11
Function Feed(Actor victim)
;     Debug.Trace("EVERDAMNED: GARKAIN:start newShiftTime = " + GameTimeDaysToRealTimeSeconds(PlayerWerewolfShiftBackTime.GetValue()) + ", __feedExtensionTime = " + GameTimeDaysToRealTimeSeconds(__feedExtensionTime))
    
;     Debug.Trace("EVERDAMNED: GARKAIN:default newShiftTime = " + GameTimeDaysToRealTimeSeconds(newShiftTime) + ", __feedExtensionTime = " + GameTimeDaysToRealTimeSeconds(__feedExtensionTime))
    Debug.Trace("EVERDAMNED: GARKAIN: FEEEEEEEED")
    Game.GetPlayer().PlayIdle(SpecialFeeding)
    
    ;This is for adding a spell that simulates bleeding
    BleedingFXSpell.Cast(victim,victim)
	Debug.Notification("This is FEED func from quest!")
    
	;PlayerWerewolfFeedMessage.Show()
	;FeedBoost.Cast(Game.GetPlayer())
	; victim.SetActorValue("Variable08", 100)

    SetStage(10)
EndFunction

function Revert()

	Debug.Trace("EVERDAMNED: GARKAIN: Garkain quest REVERT got called.")
	
	if game.QueryStat("NumVampirePerks") as Float >= DLC1VampireMaxPerks.value
		game.AddAchievement(58)
	endIf
	self.UnregisterForUpdate()
	self.SetStage(100)
endFunction

; called from stage 20
Function WarnPlayer()
    Debug.Trace("EVERDAMNED: GARKAIN: Player about to transform back.")
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
	
	Actor PlayerActor = Game.GetPlayer()
	
	; screen effect
    ;WerewolfChange.Apply()
    ;WerewolfIMODSound.Play(PlayerActor)
	 
	PlayerActor.GetActorBase().SetInvulnerable(true)
	PlayerActor.SetGhost(true)
    Game.SetInCharGen(true, true, false)
	

    UnRegisterForAnimationEvent(PlayerActor, "KillMoveStart")
    UnRegisterForUpdate() ; just in case

    if (Game.GetPlayer().IsDead())
        Debug.Trace("EVERDAMNED: GARKAIN: Player is dead; bailing out.")
        return
    endif
	
	VampireChange.Apply(1.00000)
	VampireIMODSound.Play(PlayerActor as objectreference)
	;DLC1VampireChangeBackFXS.Play(PlayerActor as objectreference, 5.0000)
	
	;;; REMOVE SPELLS
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl10_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl15_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl20_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl25_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl30_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl35_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl40_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl45_Ab)
	playerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_lvl50Plus_Ab)
	PlayerActor.DispelSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N_Proc)
	;PlayerActor.RemoveSpell(ED_VampirePowers_GarkainBeast_Revert)
	;PlayerActor.DispelSpell(ED_VampirePowers_GarkainBeast_Revert)
    ;Game.GetPlayer().RemoveItem(WolfSkinFXArmor, 1, True)

    ; make sure your health is reasonable before turning you back
    float currHealth = Game.GetPlayer().GetAV("health")
    if (currHealth <= 101)
        Debug.Trace("EVERDAMNED: GARKAIN: Player's health is only " + currHealth + "; restoring.")
        Game.GetPlayer().RestoreAV("health", 101 - currHealth)
    endif

    ; change you back
	DLC1VampireTrackingQuest vts = (DLC1TrackingQuest as DLC1VampireTrackingQuest)
	Race originalRace = vts.PlayerRace
    Debug.Trace("EVERDAMNED: GARKAIN: Setting race " + originalRace + " on " + PlayerActor)
	utility.Wait(3)
    PlayerActor.SetRace(originalRace)
	
	PlayerVampireQuest.VampireProgression(PlayerActor, PlayerVampireQuest.VampireStatus)
	;DLC1VampireChangeBackFXS.Stop(PlayerActor as objectreference)
	;DLC1VampireChangeBack02FXS.Play(PlayerActor as objectreference, 0.100000)
	
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
	
	Actor playerRef = Game.GetPlayer()
	
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
    if (asEventName == "KillMoveStart")
		;debug.Notification("Triggered KillMoveStart animation event!")
		__killmoveStarted = true
		
		; so that if there is no followup for some reason we invalidate
		RegisterForSingleUpdate(10)
	elseif (asEventName == "SoundPlay.NPCWerewolfFeedingKill")
		if !__killmoveStarted
			return
		endif
		;debug.Notification("Now we know its the right one!")
		__killmoveStarted = false
		utility.wait(2)
		UnregisterForUpdate()
		ED_Mechanics_GarkainBeast_EatenCloak.Cast((akSource as Actor), (akSource as Actor))
		ED_Mechanics_GarkainBeast_CombatFeed.Cast((akSource as Actor), (akSource as Actor))
		PlayerVampireQuest.VampireFeed()
    endif
EndEvent

Event OnUpdate()
	__killmoveStarted = false
EndEvent

Spell Property ED_Mechanics_GarkainBeast_CombatFeed Auto
Spell Property ED_Mechanics_GarkainBeast_EatenCloak Auto
