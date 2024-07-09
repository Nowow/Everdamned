Scriptname ED_PlayerVampireGarkainChangeScript extends Quest


VisualEffect property FeedBloodVFX auto
{Visual Effect on Wolf for Feeding Blood}

Race Property ED_VampireGarkainBeastRace auto
Perk Property PlayerWerewolfFeed auto

Faction Property PlayerWerewolfFaction auto
Faction Property WerewolfFaction auto

Message Property PlayerWerewolfExpirationWarning auto
Message Property PlayerWerewolfFeedMessage auto

ImageSpaceModifier Property WerewolfWarn auto
ImageSpaceModifier Property WerewolfChange auto

Sound Property WerewolfIMODSound auto
Idle Property WerewolfTransformBack auto
Idle Property SpecialFeeding auto

Spell Property PlayerWerewolfLvl10AndBelowAbility auto
Spell Property PlayerWerewolfLvl15AndBelowAbility auto
Spell Property PlayerWerewolfLvl20AndBelowAbility auto
Spell Property PlayerWerewolfLvl25AndBelowAbility auto
Spell Property PlayerWerewolfLvl30AndBelowAbility auto
Spell Property PlayerWerewolfLvl35AndBelowAbility auto
Spell Property PlayerWerewolfLvl40AndBelowAbility auto
Spell Property PlayerWerewolfLvl45AndBelowAbility auto
Spell Property PlayerWerewolfLvl50AndOverAbility auto

Spell Property FeedBoost auto
Spell property BleedingFXSpell auto
{This Spell is for making the target of feeding bleed.}

Armor Property WolfSkinFXArmor auto

Quest Property DLC1TrackingQuest auto

bool Property Untimed auto

FormList Property CrimeFactions auto

bool __tryingToShiftBack = false
bool __shiftingBack = false
bool __shuttingDown = false
bool __trackingStarted = false


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

    Debug.Trace("EVERDAMNED: GARKAIN: Race swap done; starting tracking and effects.")
    

    Game.GetPlayer().UnequipAll()
    Game.GetPlayer().EquipItem(WolfSkinFXArmor, False, True)

    ;Add Blood Effects
    ;FeedBloodVFX.Play(Game.GetPlayer())

    ; make everyone hate you
    Game.GetPlayer().SetAttackActorOnSight(true)

    ; alert anyone nearby that they should now know the player is a werewolf
    Game.SendWereWolfTransformation()

    Game.GetPlayer().AddToFaction(PlayerWerewolfFaction)
    Game.GetPlayer().AddToFaction(WerewolfFaction)
    int cfIndex = 0
    while (cfIndex < CrimeFactions.GetSize())
;         Debug.Trace("EVERDAMNED: GARKAIN:Setting enemy flag on " + CrimeFactions.GetAt(cfIndex))
        (CrimeFactions.GetAt(cfIndex) as Faction).SetPlayerEnemy()
        cfIndex += 1
    endwhile

    ; but they also don't know that it's you
    Game.SetPlayerReportCrime(false)



    ; unequip magic
    Spell left = Game.GetPlayer().GetEquippedSpell(0)
    Spell right = Game.GetPlayer().GetEquippedSpell(1)
    Spell power = Game.GetPlayer().GetEquippedSpell(2)
    Shout voice = Game.GetPlayer().GetEquippedShout()
    if (left != None)
        Game.GetPlayer().UnequipSpell(left, 0)
    endif
    if (right != None)
        Game.GetPlayer().UnequipSpell(right, 1)
    endif
    if (power != None)
        ; some players are overly clever and sneak a power equip between casting
        ;  beast form and when we rejigger them there. this will teach them.
;         Debug.Trace("EVERDAMNED: GARKAIN:" + power + " was equipped; removing.")
        Game.GetPlayer().UnequipSpell(power, 2)
    else
;         Debug.Trace("EVERDAMNED: GARKAIN:No power equipped.")
    endif
    if (voice != None)
        ; same deal here, but for shouts
;         Debug.Trace("EVERDAMNED: GARKAIN:" + voice + " was equipped; removing.")
        Game.GetPlayer().UnequipShout(voice)
    else
;         Debug.Trace("EVERDAMNED: GARKAIN:No shout equipped.")
    endif



    ; and some rad claws
	
	Game.GetPlayer().AddSpell(PlayerWerewolfLvl50AndOverAbility, false)
	
    ;int playerLevel = Game.GetPlayer().GetLevel()
    ;if     (playerLevel <= 10)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl10AndBelowAbility, false)
    ;elseif (playerLevel <= 15)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl15AndBelowAbility, false)
    ;elseif (playerLevel <= 20)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl20AndBelowAbility, false)
    ;elseif (playerLevel <= 25)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl25AndBelowAbility, false)
    ;elseif (playerLevel <= 30)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl30AndBelowAbility, false)
    ;elseif (playerLevel <= 35)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl35AndBelowAbility, false)
    ;elseif (playerLevel <= 40)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl40AndBelowAbility, false)
    ;elseif (playerLevel <= 45)
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl45AndBelowAbility, false)
    ;else
    ;    Game.GetPlayer().AddSpell(PlayerWerewolfLvl50AndOverAbility, false)
    ;endif



;     Debug.Trace("EVERDAMNED: GARKAIN:Current day -- " + currentTime)
;     Debug.Trace("EVERDAMNED: GARKAIN:Player will turn back at day " + regressTime)

    ; increment stats
    ;Game.IncrementStat("Werewolf Transformations")

    ; set us up to check when we turn back
    ;RegisterForUpdate(5)

    SetStage(10) ; we're done with the transformation handling
EndFunction

; called from stage 11
Function Feed(Actor victim)
;     Debug.Trace("EVERDAMNED: GARKAIN:start newShiftTime = " + GameTimeDaysToRealTimeSeconds(PlayerWerewolfShiftBackTime.GetValue()) + ", __feedExtensionTime = " + GameTimeDaysToRealTimeSeconds(__feedExtensionTime))
    
;     Debug.Trace("EVERDAMNED: GARKAIN:default newShiftTime = " + GameTimeDaysToRealTimeSeconds(newShiftTime) + ", __feedExtensionTime = " + GameTimeDaysToRealTimeSeconds(__feedExtensionTime))
    
    Game.GetPlayer().PlayIdle(SpecialFeeding)
    
    ;This is for adding a spell that simulates bleeding
    BleedingFXSpell.Cast(victim,victim)
    
	PlayerWerewolfFeedMessage.Show()
	FeedBoost.Cast(Game.GetPlayer())
	; victim.SetActorValue("Variable08", 100)

    SetStage(10)
EndFunction


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

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    if (asEventName == "TransformToHuman")
        ActuallyShiftBackIfNecessary()
    endif
EndEvent

Function ActuallyShiftBackIfNecessary()
    if (__shiftingBack)
        return
    endif

    __shiftingBack = true

    Debug.Trace("EVERDAMNED: GARKAIN: Player returning to normal.")

    Game.SetInCharGen(true, true, false)

    UnRegisterForAnimationEvent(Game.GetPlayer(), "TransformToHuman")
    UnRegisterForUpdate() ; just in case

    if (Game.GetPlayer().IsDead())
        Debug.Trace("EVERDAMNED: GARKAIN: Player is dead; bailing out.")
        return
    endif

    ;Remove Blood Effects
    ;FeedBloodVFX.Stop(Game.GetPlayer())

    ; imod
    WerewolfChange.Apply()
    WerewolfIMODSound.Play(Game.GetPlayer())

    ; make sure the transition armor is gone. We RemoveItem here, because the SetRace stored all equipped items
    ; at that time, and we equip this armor prior to setting the player to a beast race. When we switch back,
    ; if this were still in the player's inventory it would be re-equipped.
    Game.GetPlayer().RemoveItem(WolfSkinFXArmor, 1, True)

    ; clear out perks/abilities
    ;  (don't need to do this anymore since it's on from gamestart)
    ; Game.GetPlayer().RemovePerk(PlayerWerewolfFeed)

    ; make sure your health is reasonable before turning you back
    ; Game.GetPlayer().GetActorBase().SetInvulnerable(true)
    Game.GetPlayer().SetGhost()
    float currHealth = Game.GetPlayer().GetAV("health")
    if (currHealth <= 101)
        Debug.Trace("EVERDAMNED: GARKAIN: Player's health is only " + currHealth + "; restoring.")
        Game.GetPlayer().RestoreAV("health", 101 - currHealth)
    endif

    ; change you back
	
	DLC1VampireTrackingQuest vts = (DLC1TrackingQuest as DLC1VampireTrackingQuest)
	Race originalRace = vts.PlayerRace
	Actor playerRef = Game.GetPlayer()
	
    Debug.Trace("EVERDAMNED: GARKAIN: Setting race " + originalRace + " on " + playerRef)
    playerRef.SetRace(originalRace)
     ; release the player controls
;     Debug.Trace("EVERDAMNED: GARKAIN:Restoring camera controls")
    Game.EnablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abLooking = false, abSneaking = false, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 1)
    Game.ShowFirstPersonGeometry(true)

    ; no more howling for you
    ;playerRef.UnequipShout(CurrentHowl)
    ;playerRef.RemoveShout(CurrentHowl)

    ; or those claws
    ;playerRef.RemoveSpell(PlayerWerewolfLvl10AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl15AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl20AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl25AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl30AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl35AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl40AndBelowAbility)
    ;playerRef.RemoveSpell(PlayerWerewolfLvl45AndBelowAbility)
    playerRef.RemoveSpell(PlayerWerewolfLvl50AndOverAbility)

    ; gimme back mah stuff
    ; LycanStash.RemoveAllItems(Game.GetPlayer())

    ; people don't hate you no more
    playerRef.SetAttackActorOnSight(false)
    playerRef.RemoveFromFaction(PlayerWerewolfFaction)
    playerRef.RemoveFromFaction(WerewolfFaction)
    int cfIndex = 0
    while (cfIndex < CrimeFactions.GetSize())
;         Debug.Trace("EVERDAMNED: GARKAIN:Removing enemy flag from " + CrimeFactions.GetAt(cfIndex))
        (CrimeFactions.GetAt(cfIndex) as Faction).SetPlayerEnemy(false)
        cfIndex += 1
    endwhile

    ; and you're now recognized
    Game.SetPlayerReportCrime(true)

    ; alert anyone nearby that they should now know the player is a werewolf
    Game.SendWereWolfTransformation()

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

    playerRef.GetActorBase().SetInvulnerable(false)
    playerRef.SetGhost(false)

    Game.SetBeastForm(False)
    Game.EnableFastTravel(True)

    Game.SetInCharGen(false, false, false)

    Stop()
EndFunction
