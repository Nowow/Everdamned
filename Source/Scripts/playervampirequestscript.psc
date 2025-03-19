scriptName PlayerVampireQuestScript extends Quest conditional


Float property ED_HungerChance auto
Float property ED_HungerChanceSlower auto
Float property LastFeedTime auto
Float property FeedTimer auto

Int property VampireStatus auto conditional

ED_BloodPoolManager_Script Property ED_BloodPoolManager_Quest Auto
ED_FeedManager_Script Property ED_FeedManager_Quest Auto
ED_MainQuest_Script Property ED_MainQuest Auto
ED_HotKeys_Script property ED_Mechanics_Hotkeys_Quest auto


function OnUpdateGameTime()

    ED_BloodPoolManager_Quest.AtProcessBonus()
    FeedTimer = (GameDaysPassed.value - LastFeedTime) * 24.0100 / ED_Mechanics_Global_DelayBetweenStages.GetValue()
	
	; using keyword instead of !playerRef.HasMagicEffect(DLC1VampireChangeEffect) && !playerRef.HasMagicEffect(DLC1VampireChangeFXEffect)
    if game.IsMovementControlsEnabled() && game.IsFightingControlsEnabled() && playerRef.GetCombatState() == 0 && playerRef.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_BlockHungerAdvance)
        Float Chance
        if playerRef.HasSpell(ED_BeingVampire_Ab_HungerDelay_Spell as form)
            Chance = ED_HungerChance
        else
            Chance = ED_HungerChanceSlower
        endIf
        if utility.RandomFloat(0.000000, 1.00000) < Chance
            ; TODO: think if you need to show help message for the first time
            ;SCS_Help_HungerStage2.ShowAsHelpMessage("SCS_HungerStage2Event", 5.00000, 0 as Float, 1)
            self.Devolve(false)
        endIf
    endIf
endFunction


; this function exists because dont want to change VampireFeed() interface to avoid compatibility issues
float __defaultHPtoBeEaten = 100.0 ; for compatibility, a default amount for feeds that do not know feed target
float __hpToBeEaten
float __hpCacheVal
function SetHPtoBeEaten(float newValue, bool force = false)
    
    ;checking new value is bigger then old
    ;idea is that Blood Pool Manager can disregard smaller values if they happen to come uprocessed before bigger ones appear
    if force || newValue >= __hpToBeEaten
        __hpToBeEaten = newValue
    endif
endfunction

float function GetHPtoBeEaten()
    __hpCacheVal = __hpToBeEaten
    __hpToBeEaten = 0.0
    return __hpCacheVal
endfunction


function EatThisActor(actor Target, float shareHPToDigest = 0.2)
    debug.Trace("Everdamned DEBUG: actor to be eaten at " + shareHPToDigest*100.0 + "% of base hp")
    SetHPtoBeEaten(Target.getbaseav("health") * shareHPToDigest)
    ED_BloodPoolManager_Quest.SetBonusAfterFeed()
    VampireFeed()
endFunction

function VampireFeed()

    VampireTransformDecreaseISMD.applyCrossFade(2.00000)
    utility.Wait(2.00000)
    imagespacemodifier.removeCrossFade(1.00000)
    game.IncrementStat("Necks Bitten", 1)
    ED_Mechanics_Message_VampireFeed.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
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
        debug.Trace("Everdamned INFO: You become hated due to stage 4")
        Player.AddtoFaction(VampirePCFaction)
        Int i = 0
        while i < DLC1VampireHateFactions.GetSize()
            (DLC1VampireHateFactions.GetAt(i) as faction).SetPlayerEnemy(true)
            i += 1
        endWhile
    endIf
    
endFunction

function VampireFeedBed()

    playerRef.PlayIdle(VampireFeedingBedRight)
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
    
    Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage1_Spell)
    Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage2_Spell)
    Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage3_Spell)
    Player.RemoveSpell(ED_BeingVampire_Ab_Status_Stage4_Spell)
	
	Player.RemoveSpell(ED_BeingVampire_Ab_TrespassingCurse_Spell)
    Player.RemoveSpell(ED_BeingVampire_Ab_MoonlitWaters_Spell)
    Player.RemoveSpell(ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight)
	
	; vanilla spells
	Player.RemoveSpell(ED_BeingVampire_Vanilla_VampiricDrain)
	Player.RemoveSpell(ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell)
    Player.RemoveSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell)
    
	Player.DispelSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell)
	Player.DispelSpell(ED_VampirePowers_Pw_Obfuscate_Spell)
	
	; TODO: ED main quest should handle removing all other mod perks and abilities

    if !CureRace
        Player.SetRace(NordRace)
    else
        Player.SetRace(CureRace)
    endIf
    PlayerIsVampire.SetValue(0 as Float)
    
    ; TODO: remove it from here because it is part of race?
    
	; TODO: stopping quests 
    ED_Mechanics_Hotkeys_Quest.stop()
	
endFunction

function VampireFeedBedRoll()

    playerRef.PlayIdle(VampireFeedingBedrollRight)
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
	
	; TODO: start quests
	
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
    utility.Wait(1.00000)
	
	; TODO: start quests
    ED_Mechanics_Hotkeys_Quest.start()
	ED_MainQuest.GainAgeExpirience(0.0)
	
    ED_FeedManager_Quest.RegisterFeedEvents()
    
    game.EnablePlayerControls(true, true, true, true, true, true, true, true, 0)
    if VC01.GetStageDone(200) == 1 as Bool
        VC01.SetStage(25)
    endIf
	
endFunction

Bool function Devolve(Bool abForceDevolve, bool dropToLowest = false)

    if (FeedTimer >= 3.0 || abForceDevolve == true) && (VampireStatus == 3 || dropToLowest == true)
        VampireFeedReady.SetValue(3 as Float)
        if ED_Mechanics_Global_DisableHate.GetValue() == 0 as Float && !playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell as form)
            ED_Mechanics_Message_VampireProgression_Stage4.Show()
        else
            ED_Mechanics_Message_VampireProgression_Stage4_Masquerade.Show()
        endIf
        VampireStatus = 4
        self.VampireProgression(playerRef, 4)
		
		; leaving updates for ProcessBonuses()
        ;self.UnregisterforUpdateGameTime()
    elseIf (FeedTimer >= 2.0 || abForceDevolve == true) && VampireStatus == 2
        if abForceDevolve
            LastFeedTime -= 1 as Float
        endIf
        VampireFeedReady.SetValue(2 as Float)
        ED_Mechanics_Message_VampireProgression_Stage3.Show()
        VampireStatus = 3
        self.VampireProgression(playerRef, 3)
    elseIf (FeedTimer >= 1.0 || abForceDevolve == true) && VampireStatus == 1
        if abForceDevolve
            LastFeedTime -= 1 as Float
        endIf
        VampireFeedReady.SetValue(1 as Float)
        ED_Mechanics_Message_VampireProgression_Stage2.Show()
        VampireStatus = 2
        self.VampireProgression(playerRef, 2)
    endIf
endFunction

; VampireStage gets new stage, but property is still an old stage and is set after VampireProgression completes
; Done so you can distinguish when VampireProgression is called to actually change stage
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
        
        Player.RemoveSpell(ED_Mechanics_Ab_ChainedBeast_Spell)
        
        if VampireStatus != VampireStage
            debug.Trace("Everdamned DEBUG: Vamprire Progression is called to actually change stage")
            ED_BloodPoolManager_Quest.AtStageOrAgeChange()
        endif
        
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
        
        Player.RemoveSpell(ED_Mechanics_Ab_ChainedBeast_Spell)
        
        if VampireStatus != VampireStage
            debug.Trace("Everdamned DEBUG: Vamprire Progression is called to actually change stage")
            ED_BloodPoolManager_Quest.AtStageOrAgeChange()
        endif
        
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
        
        Player.RemoveSpell(ED_Mechanics_Ab_ChainedBeast_Spell)
        
        if VampireStatus != VampireStage
            debug.Trace("Everdamned DEBUG: Vamprire Progression is called to actually change stage")
            ED_BloodPoolManager_Quest.AtStageOrAgeChange()
        endif
        
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
        ; others
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
        
        if Player.HasPerk(ED_Mechanics_Ab_ChainedBeast_Perk)
            Player.AddSpell(ED_Mechanics_Ab_ChainedBeast_Spell)
        endif
        
        if VampireStatus != VampireStage
            debug.Trace("Everdamned DEBUG: Vamprire Progression is called to actually change stage")
            ED_BloodPoolManager_Quest.AtStageOrAgeChange()
        endif
        
        ; now a perk
        ;Player.AddSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage1, false)

        ;Player.AddSpell(ED_VampirePowers_Pw_VampiresWill_Spell, false)     
        ;Player.AddSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2, false)
        ;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage2N)
        ;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage3)
        ;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage4)
        ;if !Player.HasSpell(SCS_Abilities_Reward_Spell_UltimatePredator_Ab as form)
        ;   Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodIsPower)
        ;   Player.RemoveSpell(ED_VampirePowers_Pw_Obfuscate_Spell)
        ;   Player.RemoveSpell(SCS_VampireSpells_Vanilla_Power_Spell_Flaywind)
        ;endIf
        
        ;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_VampiresCommand2, true)
        ;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_Nightwalk2, true)
        ;Player.AddSpell(SCS_VampireSpells_Vanilla_Power_Spell_BloodCauldron, true)
        
        
        ;Player.RemoveSpell(SCS_Abilities_Vanilla_Spell_Ab_ReverseProgression_Stage5)
        
    endIf
    
    ;giving back permanent passives
    ;idk why the unplug-plug but...
    utility.Wait(1.50000)
    Player.AddSpell(ED_BeingVampire_Ab_MoonlitWaters_Spell, false)
    Player.AddSpell(ED_BeingVampire_Ab_TrespassingCurse_Spell, false)

endFunction


; ----------------------------------------------------
; ----- Everdamned helper funcs

function DropToBloodstarved()
	debug.Trace("Everdamned INFO: Player is forced to hunger stage 4")
	
	; force devolve, drop to lowest
	Devolve(true, true)
	
endfunction

message property ED_Mechanics_Message_VampireFeed auto
message property ED_Mechanics_Message_RaceBroken auto
message property ED_Mechanics_Message_VampireProgression_Stage2 auto
message property ED_Mechanics_Message_VampireProgression_Stage4 auto
message property ED_Mechanics_Message_VampireProgression_Stage4_Masquerade auto
message property ED_Mechanics_Message_VampireProgression_Stage3 auto

globalvariable property ED_Mechanics_Global_DisableHate auto
globalvariable property ED_Mechanics_Global_DelayBetweenStages auto
globalvariable property PlayerIsVampire auto
globalvariable property VampireFeedReady auto
globalvariable property GameDaysPassed auto
globalvariable property ED_VampireAge auto

keyword property ED_Mechanics_Keyword_BlockHungerAdvance auto

spell property ED_BeingVampire_Ab_HungerDelay_Spell auto
spell property ED_BeingVampire_Ab_MoonlitWaters_Spell auto
spell property ED_BeingVampire_Ab_Stalker_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage1_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage2_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage3_Spell auto
spell property ED_BeingVampire_Ab_Status_Stage4_Spell auto
spell property ED_BeingVampire_Ab_TrespassingCurse_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_ResistFrost_Stage4_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_WeaknessToFire_Stage4_Spell auto
spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell auto
spell property ED_BeingVampire_Vanilla_VampiricDrain auto
spell property ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell auto
spell property ED_Mechanics_Ab_ChainedBeast_Spell auto
spell property ED_VampirePowers_Ab_Masquerade_Spell auto
spell property ED_VampirePowers_Pw_Obfuscate_Spell auto
spell property ED_VampirePowers_Pw_VampiresWill_Spell auto

spell property DiseasePorphyricHemophelia auto
spell property DLC1VampireChange auto
spell property VampireCureDisease auto

formlist property CrimeFactions auto
formlist property DLC1CrimeFactions auto
formlist property DLC1VampireHateFactions auto
formlist property ED_RacesVampire auto
formlist property ED_Races auto

perk property ED_Mechanics_Ab_ChainedBeast_Perk auto
effectshader property VampireChangeFX auto
static property XMarker auto
Quest property VC01 auto
faction property VampirePCFaction auto
sound property MagVampireTransform01 auto
idle property VampireFeedingBedrollRight auto
idle property VampireFeedingBedRight auto
imagespacemodifier property VampireTransformIncreaseISMD auto
imagespacemodifier property VampireTransformDecreaseISMD auto
magiceffect property DLC1VampireChangeFXEffect auto
magiceffect property DLC1VampireChangeEffect auto
race property NordRaceVampire auto
race property NordRace auto
race property CureRace auto

actor property playerRef auto
