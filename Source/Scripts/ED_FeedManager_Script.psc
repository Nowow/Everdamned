Scriptname ED_FeedManager_Script extends Quest  


actor property aFeedTarget auto

String property BiteStart = "BiteStart" auto
String property GarkainFeedSounds = "SoundPlay.NPCWerewolfFeedingKill" auto
;String property FeedTrigger = "ed_FeedAnimationPlayed" auto
String property BreathSounds = "ed_breathSounds" auto
string property SocialFeedSatiation = "ed_socialfeedsatiation" auto
string property SocialFeedFinished = "ed_socialfeedfinished" auto
string property FeedAnimKillVictim = "ed_feedkm_killvictim" auto

;float property CombatFeedFallbackUpdateDelay = 10.0 auto

;---------- helper functions ---------------

function SharedDrainEffects()
	
	; vamp exp
	CustomSkills.AdvanceSkill("EverdamnedMain", math.pow(ED_Mechanics_SkillTree_Level_Global.GetValue(), 2.0) + 200.0 )
	
	; VL perks
	DLC1VampireBloodPoints.Mod(3.0)
	if DLC1VampireTotalPerksEarned.value < DLC1VampireMaxPerks.value
		ED_Mechanics_Message_LifebloodDrained.Show()
		if DLC1VampireBloodPoints.value >= DLC1VampireNextPerk.value
			
			DLC1VampireBloodPoints.Mod(-DLC1VampireNextPerk.value)
			DLC1VampirePerkPoints.Mod(1.0)
			DLC1VampireTotalPerksEarned.Mod(1.0)
			DLC1VampireNextPerk.Mod(1.0)
			DLC1VampirePerkEarned.Show()
			
		endIf
	endIf

	playerRef.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100 as Float)
			
endfunction


sound function ChooseBreathSound(actor Victim)
	; race/gender specific sfx
	; can move to Victim SFX spell
	sound __result = ED_Mechanics_FeedDialogue_BreathFemaleKhajiit_SoundM 
	bool isFemale
	race speakerRace
	actorbase __actorBase = Victim.GetActorBase()
	isFemale = __actorBase.GetSex() == 1
	speakerRace = __actorBase.GetRace()

	if (speakerRace == KhajiitRace || speakerRace == KhajiitRaceVampire)

		if isFemale == true
			__result = ED_Mechanics_FeedDialogue_BreathFemaleKhajiit_SoundM
		else
			__result = ED_Mechanics_FeedDialogue_BreathMaleKhajiit_SoundM
		endif 

	elseif (speakerRace == OrcRace || speakerRace == OrcRaceVampire)

		if isFemale == true
			__result = ED_Mechanics_FeedDialogue_BreathFemaleOrc_SoundM
		else
			__result = ED_Mechanics_FeedDialogue_BreathMaleOrc_SoundM
		endif
		
	else
		
		if isFemale == true
			__result = ED_Mechanics_FeedDialogue_BreathFemale_SoundM
		else
			__result = ED_Mechanics_FeedDialogue_BreathMale_SoundM
		endif

	endif
	
	return __result
endfunction

;----------------------------------------

Function RegisterFeedEvents()
	if PlayerIsVampire.value == 1
		
		debug.Trace("Everdamned DEBUG: Feed Manager recieved RegisterFeedEvents() call while vampire")
		race playerRace = playerRef.GetRace()
		
		if playerRace == DLC1VampireBeastRace
			RegisterForAnimationEvent(playerRef, BiteStart)
			debug.Trace("Everdamned DEBUG: Feed Manager registred BiteStart event for Vampire Lord")
		elseif playerRace == VampireGarkainBeastRace
			RegisterForAnimationEvent(playerRef, GarkainFeedSounds)
			debug.Trace("Everdamned DEBUG: Feed Manager registred chomp event for Garkain")
		else
			debug.Trace("Everdamned DEBUG: Feed Manager registred chomp event for Mortal")
			;RegisterForAnimationEvent(playerRef, FeedTrigger)
			RegisterForAnimationEvent(playerRef, BreathSounds)
			RegisterForAnimationEvent(playerRef, SocialFeedSatiation)
			RegisterForAnimationEvent(playerRef, SocialFeedFinished)
			RegisterForAnimationEvent(playerRef, FeedAnimKillVictim)
			
		endif

	endif
EndFunction

; probably unneeded because game automatically unregisters on race change
function UnRegisterFeedEvents()
	debug.Trace("Everdamned DEBUG: Feed Manager recieved UnRegisterFeedEvents() call")
	race playerRace = playerRef.GetRace()
	
	if playerRace == DLC1VampireBeastRace
		UnRegisterForAnimationEvent(playerRef, BiteStart)
		debug.Trace("Everdamned DEBUG: Feed Manager UnRegistred BiteStart event for Vampire Lord")
	elseif playerRace == VampireGarkainBeastRace
		UnRegisterForAnimationEvent(playerRef, GarkainFeedSounds)
		debug.Trace("Everdamned DEBUG: Feed Manager UnRegistred chomp event for Garkain")
	else
	;	UnRegisterForAnimationEvent(playerRef, FeedTrigger)
	;	UnRegisterForAnimationEvent(playerRef, BleedoutFinisherRustle)
	;	UnRegisterForAnimationEvent(playerRef, BloodgushImpact)
	;	UnRegisterForAnimationEvent(playerRef, FeedDoubletap)
	
		UnRegisterForAnimationEvent(playerRef, BreathSounds)
		UnRegisterForAnimationEvent(playerRef, SocialFeedSatiation)
		UnRegisterForAnimationEvent(playerRef, SocialFeedFinished)
		UnRegisterForAnimationEvent(playerRef, FeedAnimKillVictim)
	
		debug.Trace("Everdamned DEBUG: Feed Manager UnRegistred feed event for mortal race")
	endif
endfunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)

	if asEventName == FeedAnimKillVictim
		; not using KillActor animevent because
		; if not a paired anim it does not blame player for kill
		; and also to control things before killing
		
		; ghost and restrained states are controlled
		; ED_BeingVampire_VampireFeed_VictimMark_Spell
		; .Kill() works through ghost
		aFeedTarget.Kill(playerRef)
		
		debug.Trace("Everdamned DEBUG: Feed Manager caught FeedAnimKillVictim event!")
	
	;its sfx, but here so i dont have to propagate victim race to alias script
	;and timing is not critical so thread locks are not an issue
	elseif asEventName == BreathSounds
	
		BreathSoundsToPlayOnTrigger.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught Breath event!")
		
	elseif asEventName == BiteStart || asEventName == GarkainFeedSounds
		debug.Trace("Everdamned DEBUG: Feed Manager caught Beast Bite event")
		HandleBeastBite()
	
	elseif asEventName == SocialFeedSatiation
		aFeedTarget.DamageActorValue("ED_HpDrainedTimer", aFeedTarget.GetBaseActorValue("ED_HpDrainedTimer") * 0.7)
		PlayerVampireQuest.EatThisActor(aFeedTarget, 0.35)
		debug.Trace("Everdamned DEBUG: Feed Manager caught SocialFeedSatiation event, processed target: " + aFeedTarget)\

	elseif asEventName == SocialFeedFinished
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = aFeedTarget)
		SendModEvent("feedDialogue_SocialFeedFinished")
		debug.Trace("Everdamned DEBUG: Feed Manager caught SocialFeedFinished event, Bystander quest started")

	endif
endevent

bool __killmoveStarted
function HandleBeastBite()
	
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Beast Bite call")
	
	if __killmoveStarted
		return
	endif
	__killmoveStarted = true
	
	ED_Mechanics_DrainAttributeRestore_Spell.Cast(playerRef)
	
	;retrieving actor
	;latent function, would wait for quest to start and fill the alias
	; TODO: check for quest not being started already, although that is unexpected behavior
	ED_Mechanics_Quest_BeastFeedVictimFinder.Start()
	actor FeedTarget = ED_FeedVictim.GetReference() as actor
	debug.Trace("Everdamned DEBUG: Feed Manager got actor " + FeedTarget + " captured by ED_Mechanics_Quest_BeastFeedVictimFinder")
	ED_Mechanics_Quest_BeastFeedVictimFinder.Stop()
	
	ED_FeralBeast_ApplyHasBeenEaten_Trigger_Spell.Cast(playerRef, FeedTarget)

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	
	
	;diablerie
	if FeedTarget.HasKeyword(Vampire)
		float __ageMult = math.pow((FeedTarget.GetLevel() / playerRef.GetLevel()), 1.5)
		debug.Trace("Everdamned INFO: Feed Manager detects diablerie, aging with mult: " + __ageMult)
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * __ageMult)
		
		if playerRef.HasPerk(ED_PerkTreeVL_Amaranth_Perk)
			ED_VampirePowers_Amaranth_Spell.Cast(playerRef)
			ED_VampirePowers_Amaranth_Disintegrate_Spell.Cast(playerRef, FeedTarget)
		endif
	else
		;age for 1 day, default amount for regular drain
		float baseDrainValue = FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") 
		float currentDrainPercent = FeedTarget.GetActorValue("ED_HpDrainedTimer") / baseDrainValue
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * currentDrainPercent)
	endif
	
	SharedDrainEffects()

	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif ED_Mechanics_Hemomancy_Quest.IsActive()
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	endif
	__killmoveStarted = false
	
endfunction

function HandleBloodWine()
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Blood Wine call")
	
	PlayerVampireQuest.DineAlone()
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
	
	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif ED_Mechanics_Hemomancy_Quest.IsActive()
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
endfunction

function HandleFeedThrall(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Feed Thrall call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	;adjust status bloodpool etc
	FeedTarget.DamageActorValue("ED_HpDrainedTimer", FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") * 0.4)
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.2)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(2.0)
	
	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		; blue blood stops only on vampire cure?
		; todo: blue blood stop
		;psychic vampire check
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
endfunction

function HandleDrainThrall(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Thrall call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)

	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)
	
	ED_Mechanics_DrainAttributeRestore_Spell.Cast(playerRef)

	; adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	; age
	float baseDrainValue = FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") 
	float currentDrainPercent = FeedTarget.GetActorValue("ED_HpDrainedTimer") / baseDrainValue
	ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * currentDrainPercent)
	
	; kill, redo for killmove
	FeedTarget.KillSilent(playerRef)
	
	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif ED_Mechanics_Hemomancy_Quest.IsActive()
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
	SharedDrainEffects()
	
	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif

endfunction

function HandleFeedMesmerized(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Mesmerize Feed call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	;TODO: mark target as fed upon, when decided how that should impact feeding
		
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else  ;call for help
	
		;at 10 light half meter radius = 35 units
		;at 70+ light 30 meters 2000 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 2000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0 + (300.0*math.pow(2.718,0.0335*(__lightLevel - 10.0)) - 310.0)
		endif
		if playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = ED_Mechanics_Global_VampireFeedBystanderRadius.value / 3.0
			debug.Trace("Everdamned DEBUG: Feed Manager detected Masquerade perk, cutting radius by a third")
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		DLC1VampireFeedStartTime.SetValue(utility.GetCurrentGameTime())
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	;adjust status bloodpool etc
	FeedTarget.DamageActorValue("ED_HpDrainedTimer", FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") * 0.4)
	PlayerVampireQuest.EatThisActor(FeedTarget)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(2.0)

	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check	
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
endfunction

function HandleDrainMesmerized(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Mesmerized call on target " + FeedTarget)
	
	; regular feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		;at 10 light half meter radius = 35 units
		;at 70+ light 30 meters 2000 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 2000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0 + (300.0*math.pow(2.718,0.0335*(__lightLevel - 10.0)) - 310.0)
		endif
		if playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = ED_Mechanics_Global_VampireFeedBystanderRadius.value / 3.0
			debug.Trace("Everdamned DEBUG: Feed Manager detected Masquerade perk, cutting radius by a third")
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		DLC1VampireFeedStartTime.SetValue(utility.GetCurrentGameTime())
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	ED_Mechanics_DrainAttributeRestore_Spell.Cast(playerRef)

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	; kill, redo for killmove
	; silent because detection handled by bystander quest
	FeedTarget.KillSilent(playerRef)
	
	;diablerie and aging
	if FeedTarget.HasKeyword(Vampire)
		float __ageMult = math.pow((FeedTarget.GetLevel() / playerRef.GetLevel()), 1.5)
		debug.Trace("Everdamned INFO: Feed Manager detects diablerie, aging with mult: " + __ageMult)
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * __ageMult)
		
		if playerRef.HasPerk(ED_PerkTreeVL_Amaranth_Perk)
			ED_VampirePowers_Amaranth_Spell.Cast(playerRef)
			ED_VampirePowers_Amaranth_Disintegrate_Spell.Cast(playerRef, FeedTarget)
		endif
	else
		float baseDrainValue = FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") 
		float currentDrainPercent = FeedTarget.GetActorValue("ED_HpDrainedTimer") / baseDrainValue
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * currentDrainPercent)
	endif
	
	SharedDrainEffects()
	
	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif ED_Mechanics_Hemomancy_Quest.IsActive()
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check	
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
endfunction

sound BreathSoundsToPlayOnTrigger
function HandleDialogueSeduction(actor FeedTarget, float LowRadius = 35.0, float HighRadius = 300.0)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Dialogue Seduction call on target " + FeedTarget)
	
	
	ED_Mechanics_Global_FeedType.SetValue(3.0)
	
	BreathSoundsToPlayOnTrigger = ChooseBreathSound(FeedTarget)
	
	;start actual feed animation
	; can use StartVampireFeed because we actually want to sheathe if yet havent
	; but may be buggy, maybe revert to playidlewithtarget(IdleVampireStandingFeedFront_Loose)
	
	; UPD: using paired anim because StartVampireFeed provokes attack response?
	;PlayerRef.StartVampireFeed(FeedTarget)
	
	float zOffset = FeedTarget.GetHeadingAngle(playerRef)
	FeedTarget.SetAngle(FeedTarget.GetAngleX(), FeedTarget.GetAngleY(), FeedTarget.GetAngleZ() + zOffset)
	playerRef.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, FeedTarget)
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		debug.Trace("Everdamned INFO: Feed Manager got these boundaries for dialogue Seduction handling; lower: " + LowRadius + ", higher: " + HighRadius)
	
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = LowRadius
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = HighRadius
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = LowRadius + (24.663*math.pow(2.718,0.04*(__lightLevel - 10.0)) - 25.0)
		endif
		if playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = ED_Mechanics_Global_VampireFeedBystanderRadius.value / 3.0
			debug.Trace("Everdamned DEBUG: Feed Manager detected Masquerade perk, cutting radius by a third")
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		DLC1VampireFeedStartTime.SetValue(utility.GetCurrentGameTime())
		
	endif
	
	;adjust status bloodpool etc
	;damage bloodpool available on target
	; MOVED TO animation event
	aFeedTarget = FeedTarget
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(8.0)

	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check	
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
endfunction

function HandleDialogueIntimidation(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Dialogue Intimidation call on target " + FeedTarget)
	
	; vanilla anim
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		;at 10 light half meter radius = 35 units
		;at 70+ light 30 meters 600 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 600.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0 + (52.584*math.pow(2.718,0.0406*(__lightLevel - 10.0)) - 55.0)
		endif
		if playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = ED_Mechanics_Global_VampireFeedBystanderRadius.value / 3.0
			debug.Trace("Everdamned DEBUG: Feed Manager detected Masquerade perk, cutting radius by a third")
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		DLC1VampireFeedStartTime.SetValue(utility.GetCurrentGameTime())
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;adjust status bloodpool etc
	FeedTarget.DamageActorValue("ED_HpDrainedTimer", FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") * 0.4)
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.2)
	
	;age for 3h
	ED_Mechanics_Main_Quest.GainAgeExpirience(2.0)
	
	;TODO: Vamp XP


	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check	
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
endfunction

function HandleFeedSleep(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Feed Sleep call on target " + FeedTarget)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		;at 10 light half meter radius = 150 units
		;at 70+ light 30 meters 2000 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 150.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 2000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 150.0 + (172.18*math.pow(2.718,0.0408*(__lightLevel - 10.0)) - 179.0)
		endif
		if playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = ED_Mechanics_Global_VampireFeedBystanderRadius.value / 3.0
			debug.Trace("Everdamned DEBUG: Feed Manager detected Masquerade perk, cutting radius by a third")
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		DLC1VampireFeedStartTime.SetValue(utility.GetCurrentGameTime())
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;adjust status bloodpool etc
	FeedTarget.DamageActorValue("ED_HpDrainedTimer", FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") * 0.6)
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.3)
	
	;age
	ED_Mechanics_Main_Quest.GainAgeExpirience(4.0)
	

	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
	
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check	
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	if !(FeedTarget.IsInFaction(ED_Mechanics_DreamVisited_Fac)) && playerRef.HasPerk(ED_PerkTree_Deception_65_DreamVisitor_Perk)
		int currentRelationship = FeedTarget.GetRelationshipRank(playerRef)
		FeedTarget
		if currentRelationship >= 0
			ED_Art_Shader_DreamVisitor.Play(FeedTarget, 10.0)
			FeedTarget.SetRelationshipRank(playerRef, currentRelationship + 1)
			FeedTarget.AddToFaction(ED_Mechanics_DreamVisited_Fac)
			ED_Mechanics_Message_DreamVisitor_RelationshipIncreased.Show()
		endif
	endif
	
endfunction

function HandleDrainSleep(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Sleep call on target " + FeedTarget)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		;at 10 light half meter radius = 150 units
		;at 70+ light 30 meters 2000 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 150.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 2000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 150.0 + (172.18*math.pow(2.718,0.0408*(__lightLevel - 10.0)) - 179.0)
		endif
		if playerRef.HasSpell(ED_VampirePowers_Ab_Masquerade_Spell)
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = ED_Mechanics_Global_VampireFeedBystanderRadius.value / 3.0
			debug.Trace("Everdamned DEBUG: Feed Manager detected Masquerade perk, cutting radius by a third")
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		DLC1VampireFeedStartTime.SetValue(utility.GetCurrentGameTime())
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	ED_Mechanics_DrainAttributeRestore_Spell.Cast(playerRef)

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	
	;age for 1 day, default amount for regular drain
	float baseDrainValue = FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") 
	float currentDrainPercent = FeedTarget.GetActorValue("ED_HpDrainedTimer") / baseDrainValue
	ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * currentDrainPercent)

	; kill, redo for killmove
	; silent because detection handled by bystander quest
	FeedTarget.KillSilent(playerRef)
	
	SharedDrainEffects()
	
	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif ED_Mechanics_Hemomancy_Quest.IsActive()
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
	
	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStopped())
		; startup stage 10
		ED_BlueBlood_Quest_quest.Start()
	endif
			
	if FeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + FeedTarget)
		actorbase TargetBase = FeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	else
		;psychic vampire check	
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
endfunction


function HandleCombatDrain(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Player combat drains target " + FeedTarget)
	
	aFeedTarget = FeedTarget
	
	GoToState("CombatDrain")
	
endfunction


function ApplyCombatFeedEffects()

	debug.Trace("Everdamned DEBUG: Feed trigger animevent was caught, processing")
	
	; for vampire converting sidequest
	if aFeedTarget.IsInFaction(DLC1PotentialVampireFaction) && aFeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(aFeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	;sfx baked in animation/managed through animevents
	
	ED_Mechanics_DrainAttributeRestore_Spell.Cast(playerRef)
	
	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(aFeedTarget, 0.5)
	
	;diablerie
	if aFeedTarget.HasKeyword(Vampire)
		float __ageMult = math.pow((aFeedTarget.GetLevel() / playerRef.GetLevel()), 1.5)
		debug.Trace("Everdamned INFO: Feed Manager detects diablerie, aging with mult: " + __ageMult)
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * __ageMult)
		
		if playerRef.HasPerk(ED_PerkTreeVL_Amaranth_Perk)
			ED_VampirePowers_Amaranth_Spell.Cast(playerRef)
			ED_VampirePowers_Amaranth_Disintegrate_Spell.Cast(playerRef, aFeedTarget)
		endif
	else
		;age for 1 day, default amount for regular drain
		float baseDrainValue = aFeedTarget.GetBaseActorValue("ED_HpDrainedTimer") 
		float currentDrainPercent = aFeedTarget.GetActorValue("ED_HpDrainedTimer") / baseDrainValue
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * currentDrainPercent)
	endif
	
	SharedDrainEffects()

	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif ED_Mechanics_Hemomancy_Quest.IsActive()
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
	;Blue Blood
	if !(ED_BlueBlood_Quest_quest.IsStageDone(10))
		ED_BlueBlood_Quest_quest.SetCurrentStageID(10)
	endif
	
	if aFeedTarget.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		debug.Trace("Everdamned INFO: Feed Manager notifies that player just fed on Blue Blood VIP " + aFeedTarget)
		actorbase TargetBase = aFeedTarget.GetActorBase()
		Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
		if Index >= 0
			; removing from tracking
			debug.Trace("Everdamned INFO: And it was in the track list, processing")
			ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
			ED_BlueBlood_Quest.ProcessVIP(TargetBase)
		endIf
	endif	
	
	GoToState("")
	
endfunction


state CombatDrain
	;handles should do nothing till state is released
	function HandleFeedThrall(actor FeedTarget)
	endfunction
	function HandleDrainThrall(actor FeedTarget)
	endfunction
	function HandleFeedMesmerized(actor FeedTarget)
	endfunction
	function HandleDrainMesmerized(actor FeedTarget)
	endfunction
	function HandleDialogueSeduction(actor FeedTarget, float LowRadius = 35.0, float HighRadius = 300.0)
	endfunction
	function HandleDialogueIntimidation(actor FeedTarget)
	endfunction
	function HandleFeedSleep(actor FeedTarget)
	endfunction
	function HandleDrainSleep(actor FeedTarget)
	endfunction
	function HandleCombatDrain(actor FeedTarget)
	endfunction
	function HandleBeastBite()
	endfunction
	
	event OnBeginState()
		debug.Trace("Everdamned DEBUG: Feed Manager entered CombatDrain state")
		
		idle backupPlayerSoloIdleToPlay
		float backupAnimationVictimOffset
		
		; for OAR conditions and controls ghost and unconcious flags
		; also sets ghost and restrained
		ED_BeingVampire_VampireFeed_VictimMark_Spell.Cast(playerRef, aFeedTarget)
		
		; tell OAR the animation type
		if aFeedTarget.IsBleedingOut()
			; bleedout km
			debug.Trace("Everdamned DEBUG: Feed Manager determined target IS bleeding out")
			ED_Mechanics_Global_FeedType.SetValue(1.0)
			backupPlayerSoloIdleToPlay = ED_Idle_FeedKM_Solo_Player_Bleedout
			backupAnimationVictimOffset = 60.0
		else ;stagger 
			;jump feed / ground feed
			debug.Trace("Everdamned DEBUG: Feed Manager determined target is NOT bleeding out, therefore staggered")
			
			
			if playerRef.GetActorBase().GetSex() == 0
				backupPlayerSoloIdleToPlay = ED_Idle_FeedKM_Solo_Player_Ground
				backupAnimationVictimOffset = 52.0
				ED_Mechanics_Global_FeedType.SetValue(2.0)
			else
				backupPlayerSoloIdleToPlay = ED_Idle_FeedKM_Solo_Player_Jumpfeed
				backupAnimationVictimOffset = 65.0
				ED_Mechanics_Global_FeedType.SetValue(4.0)
			endif
		endif
		
		float zOffset = aFeedTarget.GetHeadingAngle(playerRef)
		aFeedTarget.SetAngle(aFeedTarget.GetAngleX(), aFeedTarget.GetAngleY(), aFeedTarget.GetAngleZ() + zOffset)
		
		debug.Trace("Everdamned DEBUG: Feed Manager commands combat feeding animation")
		
		; using IdleVampireStandingFeedFront_Loose because it 
		; does not make player immune and doesnt break because of weapons 
		; StartVampireFeed forces player to sheathe
		; paired_HugA doesnt but breaks if started with unsheather weap
		; any real killmove makes player immune to damage
		
		bool timeWasSlowed = ED_SKSEnativebindings.DispelAllSlowTimeEffects()
		if timeWasSlowed
			debug.Trace("Everdamned DEBUG: Feed Manager DISPELLED SLOW TIME EFFECT")
		endif
		
		;ED_SKSEnativebindings.SetTimeSlowdown(0.0, 0.0)
		
		bool __animPlayed = playerRef.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, aFeedTarget)
		
		bool __playerIsSynced = playerRef.GetAnimationVariableBool("bIsSynced")
		bool __victimIsSynced = aFeedTarget.GetAnimationVariableBool("bIsSynced")
		
		debug.Trace("Everdamned DEBUG: bIsSynced: " + __animPlayed)
		
		if __playerIsSynced && __victimIsSynced
			ApplyCombatFeedEffects()
		else
			debug.Trace("Everdamned WARNING: Feed Manager does not detect paired feed km playing, using backup solo anims")
			debug.Notification("EVD DEBUG: backup FEED anims")

			float playerAngleZsin = math.sin(playerRef.GetAngleZ())
			float playerAngleZcos = math.cos(playerRef.GetAngleZ())
			float targetX = playerRef.GetPositionX() + backupAnimationVictimOffset*playerAngleZsin
			float targetY = playerRef.GetPositionY() + backupAnimationVictimOffset*playerAngleZcos
			
			aFeedTarget.TranslateTo(targetX, targetY, playerRef.GetPositionZ(),\
									playerRef.GetAngleX(), playerRef.GetAngleY(), playerRef.GetAngleZ() - 180.0,\
									700.0)
			
			; dont know if needed
			playerRef.PlayIdle(ResetRoot)
			aFeedTarget.PlayIdle(ResetRoot)

			playerRef.PlayIdle(backupPlayerSoloIdleToPlay)
			aFeedTarget.PlayIdle(IdleHandCut)
			ApplyCombatFeedEffects()
		;else
		;	ED_Mechanics_Message_CombatFeedFailed.Show()
		;	debug.Trace("Everdamned DEBUG: Combat Feed attempt failed")
		;	GoToState("")
		endif
	
	endevent
	event OnEndState()
		debug.Trace("Everdamned DEBUG: Feed Manager exited CombatDrain state")
	endevent
	
endstate



idle property IdleVampireStandingFeedFront_Loose auto
idle property IdleHandCut auto
idle property ED_Idle_FeedKM_Solo_Player_Ground auto
idle property ED_Idle_FeedKM_Solo_Player_Bleedout auto
idle property ED_Idle_FeedKM_Solo_Player_Jumpfeed auto
idle property ResetRoot auto
spell property ED_BeingVampire_VampireFeed_VictimMark_Spell auto

spell property ED_FeralBeast_ApplyHasBeenEaten_Trigger_Spell auto
Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto
faction Property DLC1PotentialVampireFaction auto
Faction Property DLC1PlayerTurnedVampire auto	
globalvariable property DLC1VampireFeedStartTime auto
GlobalVariable Property PlayerIsVampire  Auto
sound property ED_Art_Sound_NPCHumanVampireFeed_Marker auto
formlist property ED_Mechanics_BlueBlood_Track_FormList auto
faction property ED_Mechanics_DreamVisited_Fac auto
effectshader property ED_Art_Shader_DreamVisitor auto

message property ED_Mechanics_Message_DreamVisitor_RelationshipIncreased auto
message property DLC1VampirePerkEarned auto
message property ED_Mechanics_Message_LifebloodDrained auto
message property ED_Mechanics_Message_CombatFeedFailed auto

globalvariable property ED_Mechanics_Global_FeedType auto
globalvariable property ED_Mechanics_Global_VampireFeedBystanderRadius auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto
globalvariable property DLC1VampireBloodPoints auto
globalvariable property DLC1VampirePerkPoints auto
globalvariable property DLC1VampireTotalPerksEarned auto
globalvariable property DLC1VampireNextPerk auto
globalvariable property DLC1VampireMaxPerks auto

perk property ED_PerkTreeVL_Amaranth_Perk auto
perk property ED_PerkTree_Deception_65_DreamVisitor_Perk auto

spell property ED_VampirePowers_Amaranth_Spell auto
spell property ED_VampirePowers_Amaranth_Disintegrate_Spell auto
spell property ED_VampirePowers_Ab_Masquerade_Spell auto
spell property ED_Mechanics_DrainAttributeRestore_Spell auto

keyword property ED_Mechanics_Keyword_BystanderStart auto
keyword property ED_Mechanics_Keyword_PsychicVampireStart auto
keyword property ED_Mechanics_Keyword_BlueBlood_VIP auto
keyword property Vampire auto

quest property ED_Mechanics_Hemomancy_Quest auto
quest property ED_BlueBlood_Quest_quest auto
quest property ED_Mechanics_Quest_BeastFeedVictimFinder auto

referencealias property ED_FeedVictim auto

playerVampireQuestScript property PlayerVampireQuest auto
dlc1vampireturnscript property DLC1VampireTurn auto
ed_mainquest_script property ED_Mechanics_Main_Quest auto
ED_BlueBlood_Quest_Script property ED_BlueBlood_Quest auto

Sound Property ED_Mechanics_FeedDialogue_BreathFemale_SoundM  Auto
Sound Property ED_Mechanics_FeedDialogue_BreathFemaleKhajiit_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathFemaleOrc_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathMale_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathMaleKhajiit_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathMaleOrc_SoundM  Auto
Race Property KhajiitRace Auto 
Race Property KhajiitRaceVampire Auto 
Race Property OrcRace Auto 
Race Property OrcRaceVampire Auto

actor property playerRef auto