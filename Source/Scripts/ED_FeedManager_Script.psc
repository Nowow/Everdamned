Scriptname ED_FeedManager_Script extends Quest  


actor property aFeedTarget auto

String property BiteStart = "BiteStart" auto
String property GarkainFeedSounds = "SoundPlay.NPCWerewolfFeedingKill" auto
;String property FeedTrigger = "ed_FeedAnimationPlayed" auto
String property BreathSounds = "ed_breathSounds" auto
string property SocialFeedSatiation = "ed_socialfeedsatiation" auto
string property SocialFeedFinished = "ed_socialfeedfinished" auto
string property FeedAnimKillVictim = "ed_feedkm_killvictim" auto
string property FeedAnimFinished = "ed_feedkm_finished" auto
String property SheatheWepons = "ed_sheatheweapons" auto
String property ResetCam = "ed_feedkm_resetcam" auto

;float property CombatFeedFallbackUpdateDelay = 10.0 auto

;---------- helper functions ---------------

function SharedDrainEffects()
	
	; vamp exp
	CustomSkills.AdvanceSkill("EverdamnedMain", math.pow(ED_Mechanics_SkillTree_Level_Global.GetValue(), 2.0) + 200.0 )
	
	; VL perks
	if playerRef.HasPerk(ED_PerkTreeVL_FountainOfLife_Perk)
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
	endif

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
			RegisterForAnimationEvent(playerRef, FeedAnimFinished)
			RegisterForAnimationEvent(playerRef, SheatheWepons)
			RegisterForAnimationEvent(playerRef, ResetCam)
			
			
		endif

	endif
	
	EstablishNextStaggerDrainType()
	
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
		UnRegisterForAnimationEvent(playerRef, FeedAnimFinished)
		UnRegisterForAnimationEvent(playerRef, SheatheWepons)
		UnRegisterForAnimationEvent(playerRef, ResetCam)
	
		debug.Trace("Everdamned DEBUG: Feed Manager UnRegistred feed event for mortal race")
	endif
endfunction

weapon LeftWeaponIfAny
armor ShieldIfAny
weapon RightWeaponIfAny
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
	
	elseif asEventName == FeedAnimFinished
		if __needReequip
			__needReequip = false
			utility.wait(0.2) ; so anim is totally complete
			playerRef.EquipItemEx(RightWeaponIfAny, 1)
			playerRef.EquipItemEx(LeftWeaponIfAny, 2)
			playerRef.EquipItemEx(ShieldIfAny, 2)
			;playerRef.DrawWeapon()
			debug.SendAnimationEvent(playerRef, "WeapEquip")
			;debug.SendAnimationEvent(playerRef, "MagicForceEquipLeft")
			;debug.SendAnimationEvent(playerRef, "MagicForceEquipRight")
			Game.SetPlayerAIDriven(false)
			RightWeaponIfAny = none
			LeftWeaponIfAny = none
			ShieldIfAny = none
		endif
		Game.SetPlayerAIDriven(false)
		debug.Trace("Everdamned DEBUG: Feed Manager caught FeedAnimFinished event!")
	;its sfx, but here so i dont have to propagate victim race to alias script
	;and timing is not critical so thread locks are not an issue
	elseif asEventName == SheatheWepons
		LeftWeaponIfAny = playerRef.GetEquippedWeapon(true)
		if !LeftWeaponIfAny
			ShieldIfAny = playerRef.GetEquippedShield()
		endif
		RightWeaponIfAny = playerRef.GetEquippedWeapon(false)
		playerRef.UnequipItemEx(LeftWeaponIfAny, 1)
		playerRef.UnequipItemEx(ShieldIfAny, 1)
		playerRef.UnequipItemEx(RightWeaponIfAny, 2)
		
		debug.Trace("Everdamned DEBUG: Feed Manager caught SheatheWepons event")
		
	elseif asEventName == ResetCam
	
		Game.SetCameraTarget(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught ResetCam event")
		
	elseif asEventName == BreathSounds
	
		BreathSoundsToPlayOnTrigger.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught Breath event!")
		
	elseif asEventName == BiteStart || asEventName == GarkainFeedSounds
		debug.Trace("Everdamned DEBUG: Feed Manager caught Beast Bite event")
		HandleBeastBite()
	
	elseif asEventName == SocialFeedSatiation
		aFeedTarget.DamageActorValue("ED_HpDrainedTimer", aFeedTarget.GetBaseActorValue("ED_HpDrainedTimer") * 0.7)
		int __seducedRank = aFeedTarget.GetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac)
		if __seducedRank < 0
			__seducedRank = 0
		endif
		float __shareToEat = 0.30 + __seducedRank*0.1
		if aFeedTarget.IsInFaction(PlayerMarriedFaction)
			__shareToEat = 0.50
		endif
		PlayerVampireQuest.EatThisActor(aFeedTarget, __shareToEat)
		debug.Trace("Everdamned DEBUG: Feed Manager caught SocialFeedSatiation event, processed target: " + aFeedTarget)\

	elseif asEventName == SocialFeedFinished
		bool __bystanderQuestStarted = ED_Mechanics_Keyword_BystanderStart.SendStoryEventAndWait(akRef1 = aFeedTarget)
		;SendModEvent("feedDialogue_SocialFeedFinished")
		debug.Trace("Everdamned DEBUG: Feed Manager caught SocialFeedFinished event, Bystander quest started")
		debug.Trace("Everdamned DEBUG: Feed Manager Bystander quest started: " + __bystanderQuestStarted)

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
		ED_Mechanics_Message_Diablerie.Show()
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
	elseif !(ED_Mechanics_Hemomancy_Quest.IsStageDone(100))
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
	elseif !(ED_Mechanics_Hemomancy_Quest.IsStageDone(100))
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(80)
	endif
	
endfunction

function HandleFeedThrall(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Feed Thrall call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	
	bool __isVL = playerRef.GetRace() == DLC1VampireBeastRace
	if __isVL
		; currently unreachable because need to make bite animation without kill event
		float headingAngle = FeedTarget.GetHeadingAngle(playerRef) 
		bool __front = headingAngle >= -90.0 && headingAngle <= 90.0
		if __front
			playerRef.PlayIdleWithTarget(VampireLordLeftPairedFeedFront, FeedTarget)
		else
			playerRef.PlayIdleWithTarget(VampireLordLeftPairedFeedBack, FeedTarget)
		endif
	else
		PlayerRef.StartVampireFeed(FeedTarget)
	endif
	
	; for vampire converting sidequest
	if (DLC1VQ03VampireDexion && DLC1VQ03VampireDexion.GetActorReference() == FeedTarget) || (FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False)
		debug.Trace("Everdamned DEBUG: Dexion is bitten!!!")
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
		;psychic vampire check
		ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
endfunction

function HandleDrainThrall(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Thrall call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	bool __isVL = playerRef.GetRace() == DLC1VampireBeastRace
	if __isVL
		float headingAngle = FeedTarget.GetHeadingAngle(playerRef) 
		bool __front = headingAngle >= -90.0 && headingAngle <= 90.0
		if __front
			playerRef.PlayIdleWithTarget(VampireLordLeftPairedFeedFront, FeedTarget)
		else
			playerRef.PlayIdleWithTarget(VampireLordLeftPairedFeedBack, FeedTarget)
		endif
	else
		PlayerRef.StartVampireFeed(FeedTarget)
	endif
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
	elseif !(ED_Mechanics_Hemomancy_Quest.IsStageDone(100))
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
	;PlayerRef.StartVampireFeed(FeedTarget)
	
	playerRef.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, FeedTarget)
		
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else  ;call for help
	
		;at 10 light half meter radius = 35 units
		;at 70+ light 30 meters 2000 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 500.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 1000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 300.0 + (46.535*math.pow(2.718,0.041*(__lightLevel - 10.0)) - 50.0)
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
	; but it seems to alert everyone around
	;PlayerRef.StartVampireFeed(FeedTarget)
	
	bool __isVL = playerRef.GetRace() == DLC1VampireBeastRace
	if __isVL
		float headingAngle = FeedTarget.GetHeadingAngle(playerRef) 
		bool __front = headingAngle >= -90.0 && headingAngle <= 90.0
		if __front
			playerRef.PlayIdleWithTarget(VampireLordLeftPairedFeedFront, FeedTarget)
		else
			playerRef.PlayIdleWithTarget(VampireLordLeftPairedFeedBack, FeedTarget)
		endif
	else
		PlayerRef.StartVampireFeed(FeedTarget)
	endif
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		;at 10 light half meter radius = 35 units
		;at 70+ light 30 meters 2000 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 500.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 1000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 300.0 + (46.535*math.pow(2.718,0.041*(__lightLevel - 10.0)) - 50.0)
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
		ED_Mechanics_Message_Diablerie.Show()
	else
		float baseDrainValue = FeedTarget.GetBaseActorValue("ED_HpDrainedTimer") 
		float currentDrainPercent = FeedTarget.GetActorValue("ED_HpDrainedTimer") / baseDrainValue
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * currentDrainPercent)
	endif
	
	SharedDrainEffects()
	
	;hemomancy
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	elseif !(ED_Mechanics_Hemomancy_Quest.IsStageDone(100))
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
	
	float playerZ = playerRef.GetPositionZ()
	float targetZ = FeedTarget.GetPositionZ()
	
	bool __shouldCorrect = math.abs(playerZ - targetZ) >= 5.0
	if __shouldCorrect
		if playerZ > targetZ
			FeedTarget.SetPosition(FeedTarget.GetPositionX(), FeedTarget.GetPositionY(), playerRef.GetPositionZ())
		else
			playerRef.SetPosition(playerRef.GetPositionX(), playerRef.GetPositionY(), FeedTarget.GetPositionZ())
		endif
	endif
	;utility.wait(0.01)
	FeedTarget.SetAngle(FeedTarget.GetAngleX(), FeedTarget.GetAngleY(), FeedTarget.GetAngleZ() + zOffset)
	
	
	bool __animPlayed = playerRef.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, FeedTarget)
	utility.wait(0.1)
	bool __playerIsSynced = playerRef.GetAnimationVariableBool("bIsSynced")
	bool __victimIsSynced = FeedTarget.GetAnimationVariableBool("bIsSynced")
	
	debug.Trace("Everdamned DEBUG: player bIsSynced: " + __playerIsSynced)
	debug.Trace("Everdamned DEBUG: victim bIsSynced: " + __victimIsSynced)
	
	if __playerIsSynced && __victimIsSynced
	else
		debug.Trace("Everdamned WARNING: Feed Manager does not detect paired social feed playing, using backup solo anims")
		debug.Notification("EVD DEBUG: backup FEED anims")
		
		float backupAnimationVictimOffsetSocial = 50.0  ;  check

		float playerAngleZsin = math.sin(playerRef.GetAngleZ())
		float playerAngleZcos = math.cos(playerRef.GetAngleZ())
		float targetX = playerRef.GetPositionX() + backupAnimationVictimOffsetSocial*playerAngleZsin
		float targetY = playerRef.GetPositionY() + backupAnimationVictimOffsetSocial*playerAngleZcos
		
		FeedTarget.TranslateTo(targetX, targetY, playerRef.GetPositionZ() + 5.0,\
								playerRef.GetAngleX(), playerRef.GetAngleY(), playerRef.GetAngleZ() - 180.0,\
								700.0)
		
		ED_Mechanics_Spell_SetDontMove.Cast(FeedTarget, FeedTarget)
		
		; dont know if needed
		playerRef.PlayIdle(ResetRoot)
		FeedTarget.PlayIdle(ResetRoot)

		playerRef.PlayIdle(ED_Idle_FeedKM_Solo_Player_Social)
		FeedTarget.PlayIdle(ED_Idle_FeedKM_Solo_Victim_Social)
	endif
	
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
			;ED_Mechanics_Global_VampireFeedBystanderRadius.value = LowRadius + (24.663*math.pow(2.718,0.04*(__lightLevel - 10.0)) - 25.0)
			; using linear here because dotn feel like redoing math just for the exponent
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = LowRadius + ((HighRadius - LowRadius)/60.0)*(__lightLevel - 10.0) 
			
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
	
	;age for 8h
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
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 100.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 1000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 100.0 + (83.763*math.pow(2.718,0.0408*(__lightLevel - 10.0)) - 70.0)
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
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 100.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 1000.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 100.0 + (83.763*math.pow(2.718,0.0408*(__lightLevel - 10.0)) - 70.0)
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
	elseif !(ED_Mechanics_Hemomancy_Quest.IsStageDone(100))
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
		ED_Mechanics_Message_Diablerie.Show()
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
	elseif !(ED_Mechanics_Hemomancy_Quest.IsStageDone(100))
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


int __animSetting
int __whichAnim  ; default 0, ground feed
float property backupAnimationVictimOffset = 52.0 auto
float property havokForcetoApply = 52.0 auto
idle property backupPlayerSoloIdleToPlay auto
idle property backupVictimSoloIdleToPlay auto
idle property pairedIdleToPlay auto

function EstablishNextStaggerDrainType()
	__animSetting = ED_Mechanics_Global_MCM_CombatDrainAnim.GetValue() as int
	debug.Trace("Everdamned DEBUG: Setting global: " + __animSetting)
	if __animSetting == 3
		__whichAnim = utility.randomint(0, 1)
	elseif __animSetting == 2
		if playerRef.GetActorBase().GetSex() == 0
			__whichAnim = 1  ; jump feed
			debug.Trace("Everdamned DEBUG: Setting 2, type now: " + __whichAnim)

		else
			__whichAnim = 0  ; ground feed
			debug.Trace("Everdamned DEBUG: Setting 2, type now: " + __whichAnim)
		endif
	else
		if playerRef.GetActorBase().GetSex() == 0
			__whichAnim = 0  ; ground feed
			debug.Trace("Everdamned DEBUG: Setting !2, type now: " + __whichAnim)
			
		else
			__whichAnim = 1  ; jump feed
			debug.Trace("Everdamned DEBUG: Setting !2, type now: " + __whichAnim)
		endif
	endif
	

	if __whichAnim == 0
		pairedIdleToPlay = ED_Idle_FeedKM_Paired_GroundFeed
		;backupPlayerSoloIdleToPlay = ED_Idle_FeedKM_Solo_Player_Ground
		;backupVictimSoloIdleToPlay = ED_Idle_FeedKM_Solo_Victim_Ground
		backupAnimationVictimOffset = 52.0
		ED_Mechanics_Global_CombatFeedType.SetValue(0.0)
		;ED_Mechanics_Global_FeedType.SetValue(2.0)
		debug.Trace("Everdamned DEBUG: Ground feed!")
	else
		pairedIdleToPlay = ED_Idle_FeedKM_Paired_JumpFeed
		;backupPlayerSoloIdleToPlay = ED_Idle_FeedKM_Solo_Player_Jumpfeed
		;backupVictimSoloIdleToPlay = ED_Idle_FeedKM_Solo_Victim_Jumpfeed
		backupAnimationVictimOffset = 65.0
		ED_Mechanics_Global_CombatFeedType.SetValue(1.0)
		;ED_Mechanics_Global_FeedType.SetValue(4.0)
		debug.Trace("Everdamned DEBUG: Jump feed!")
	endif
endfunction
		
bool __needReequip
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
		
		; for OAR conditions and controls ghost and unconcious flags
		; also sets ghost and restrained
		
		__needReequip = true
		ED_BeingVampire_VampireFeed_VictimMark_Spell.Cast(playerRef, aFeedTarget)
		ED_BeingVampire_VampireFeed_PlayerMark_Spell.Cast(playerRef, playerRef)
		
		Game.SetPlayerAIDriven(true)
		;playerRef.SheatheWeapon()
		
		; tell OAR the animation type
		if aFeedTarget.IsBleedingOut()
			; bleedout km
			debug.Trace("Everdamned DEBUG: Feed Manager determined target IS bleeding out")
			ED_Mechanics_Global_FeedType.SetValue(1.0)
			pairedIdleToPlay = ED_Idle_FeedKM_Paired_BleedoutFeed
			;backupPlayerSoloIdleToPlay = ED_Idle_FeedKM_Solo_Player_Bleedout
			;backupVictimSoloIdleToPlay = ED_Idle_FeedKM_Solo_Victim_Bleedout
			backupAnimationVictimOffset = 60.0
		else ;stagger 
			;jump feed / ground feed
			debug.Trace("Everdamned DEBUG: Feed Manager determined target is NOT bleeding out, therefore staggered")
			ED_Mechanics_Global_FeedType.SetValue(2.0)
			; type and settings are predetermined in EstablishNextStaggerDrainType()
			
		endif
		
		debug.Trace("Everdamned DEBUG: Feed Manager commands combat feeding animation")
		
		; using IdleVampireStandingFeedFront_Loose because it 
		; does not make player immune and doesnt break because of weapons 
		; StartVampireFeed forces player to sheathe
		; paired_HugA doesnt but breaks if started with unsheather weap
		; any real killmove makes player immune to damage
		
		;bool timeWasSlowed = ED_SKSEnativebindings.DispelAllSlowTimeEffects()
		ED_SKSEnativebindings.DispelAllSlowTimeEffects()
		ED_Mechanics_Spell_TimeDilationCleaner.Cast(playerRef)
		; to let slow
		;utility.wait(0.1)
		
		;ED_Art_Imod_FeedBlur.Apply()
		
		float zOffset = aFeedTarget.GetHeadingAngle(playerRef)
		aFeedTarget.SetAngle(aFeedTarget.GetAngleX(), aFeedTarget.GetAngleY(), aFeedTarget.GetAngleZ() + zOffset)
		
		if aFeedTarget.IsEnabled()
			Game.SetCameraTarget(aFeedTarget)
		endif
		
		bool __animPlayed = playerRef.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, aFeedTarget)
		;bool __animPlayed = playerRef.PlayIdleWithTarget(pairedIdleToPlay, aFeedTarget)
		
		
		bool __playerIsSynced = playerRef.GetAnimationVariableBool("bIsSynced")
		bool __victimIsSynced = aFeedTarget.GetAnimationVariableBool("bIsSynced")
		
		debug.Trace("Everdamned DEBUG: player bIsSynced: " + __playerIsSynced)
		debug.Trace("Everdamned DEBUG: victim bIsSynced: " + __victimIsSynced)
		
		if __playerIsSynced && __victimIsSynced
			; first try success
			ApplyCombatFeedEffects()
			return
		endif
		
		; second try, after adjusting
		
		
	
		float playerZ = playerRef.GetPositionZ()
		float targetZ = aFeedTarget.GetPositionZ()
		
		if playerZ > targetZ
			aFeedTarget.SetPosition(aFeedTarget.GetPositionX(), aFeedTarget.GetPositionY(), playerRef.GetPositionZ())
		else
			playerRef.SetPosition(playerRef.GetPositionX(), playerRef.GetPositionY(), aFeedTarget.GetPositionZ())
		endif
				
		__animPlayed = playerRef.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, aFeedTarget)
		;__animPlayed = playerRef.PlayIdleWithTarget(pairedIdleToPlay, aFeedTarget)
		
		__playerIsSynced = playerRef.GetAnimationVariableBool("bIsSynced")
		__victimIsSynced = aFeedTarget.GetAnimationVariableBool("bIsSynced")
		
		debug.Trace("Everdamned DEBUG: player bIsSynced: " + __playerIsSynced)
		debug.Trace("Everdamned DEBUG: victim bIsSynced: " + __victimIsSynced)

		
		if __playerIsSynced && __victimIsSynced
			ApplyCombatFeedEffects()
			return
		endif
		
		utility.wait(0.2)
		Game.SetCameraTarget(playerRef)
		debug.SendAnimationEvent(playerRef, "staggerStart")
		aFeedTarget.DispelSpell(ED_BeingVampire_VampireFeed_VictimMark_Spell)
		debug.SendAnimationEvent(aFeedTarget, "staggerStart")
		ED_Mechanics_Message_CombatFeedGripSlipped.Show()
		GoToState("")
		
		return ; not trying third time
		
		
		; third attempt, solo anims
		debug.Trace("Everdamned WARNING: Feed Manager does not detect paired feed km playing, using backup solo anims")
		debug.Notification("EVD DEBUG: backup FEED anims")
		;playerRef.UnequipItemEx(playerRef.GetEquippedWeapon(false), 1)
		;playerRef.UnequipItemEx(playerRef.GetEquippedWeapon(true), 2)

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

		playerRef.PlayIdle(IdleReadElderScroll) ; IdleReadElderScroll because it doesnt break when weapons/magic are equipped
		aFeedTarget.PlayIdle(IdleReadElderScroll)
		ApplyCombatFeedEffects()
	
	endevent
	event OnEndState()
		debug.Trace("Everdamned DEBUG: Feed Manager exited CombatDrain state, calculating next combat drain anim type")
		
		;debug.Notification("AI driven OFF")
		; re-equipping necessary because otherwise player cant swing
		; unless reequips manually
		
		;MagicForceEquipRight/Left
		if __needReequip
			__needReequip = false
			utility.wait(0.2) ; so anim is totally complete
			playerRef.EquipItemEx(RightWeaponIfAny, 1)
			playerRef.EquipItemEx(LeftWeaponIfAny, 2)
			playerRef.EquipItemEx(ShieldIfAny, 2)
			;playerRef.DrawWeapon()
			debug.SendAnimationEvent(playerRef, "WeapEquip")
			RightWeaponIfAny = none
			LeftWeaponIfAny = none
			ShieldIfAny = none
		endif
		Game.SetCameraTarget(playerRef)
		Game.SetPlayerAIDriven(false)
		EstablishNextStaggerDrainType()
		
	endevent
	
endstate


ReferenceAlias Property DLC1VQ03VampireDexion auto

Idle Property VampireLordLeftPairedFeedFront Auto
Idle Property VampireLordLeftPairedFeedBack Auto
idle property IdleVampireStandingFeedFront_Loose auto
idle property IdleHandCut auto
idle property IdleReadElderScroll auto
idle property ED_Idle_FeedKM_Solo_Player_Ground auto
idle property ED_Idle_FeedKM_Solo_Player_Bleedout auto
idle property ED_Idle_FeedKM_Solo_Player_Jumpfeed auto
idle property ED_Idle_FeedKM_Solo_Player_Social auto
idle property ED_Idle_FeedKM_Solo_Victim_Social auto
idle property ED_Idle_FeedKM_Solo_Victim_Bleedout auto
idle property ED_Idle_FeedKM_Solo_Victim_Ground auto
idle property ED_Idle_FeedKM_Solo_Victim_Jumpfeed auto
idle property ED_Idle_FeedKM_Paired_BleedoutFeed auto
idle property ED_Idle_FeedKM_Paired_GroundFeed auto
idle property ED_Idle_FeedKM_Paired_JumpFeed auto
imagespacemodifier property ED_Art_Imod_FeedBlur auto

idle property ResetRoot auto
spell property ED_BeingVampire_VampireFeed_VictimMark_Spell auto
spell property ED_BeingVampire_VampireFeed_PlayerMark_Spell auto
spell property ED_Misc_DisarmFF_Spell auto
spell property ED_Mechanics_Spell_SetDontMove auto

spell property ED_FeralBeast_ApplyHasBeenEaten_Trigger_Spell auto
Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto
faction Property DLC1PotentialVampireFaction auto
Faction Property DLC1PlayerTurnedVampire auto
faction Property ED_Mechanics_FeedDialogue_Seduced_Fac auto
faction Property PlayerMarriedFaction auto
globalvariable property DLC1VampireFeedStartTime auto
GlobalVariable Property PlayerIsVampire  Auto
sound property ED_Art_Sound_NPCHumanVampireFeed_Marker auto
formlist property ED_Mechanics_BlueBlood_Track_FormList auto
faction property ED_Mechanics_DreamVisited_Fac auto
effectshader property ED_Art_Shader_DreamVisitor auto

message property ED_Mechanics_Message_DreamVisitor_RelationshipIncreased auto
message property DLC1VampirePerkEarned auto
message property DLC1BloodPointsMsg auto
message property ED_Mechanics_Message_CombatFeedFailed auto
message property ED_Mechanics_Message_Diablerie auto
message property ED_Mechanics_Message_CombatFeedGripSlipped auto

globalvariable property ED_Mechanics_Global_MCM_CombatDrainAnim auto
globalvariable property ED_Mechanics_Global_FeedType auto
globalvariable property ED_Mechanics_Global_CombatFeedType auto
globalvariable property ED_Mechanics_Global_VampireFeedBystanderRadius auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto
globalvariable property DLC1VampireBloodPoints auto
globalvariable property DLC1VampirePerkPoints auto
globalvariable property DLC1VampireTotalPerksEarned auto
globalvariable property DLC1VampireNextPerk auto
globalvariable property DLC1VampireMaxPerks auto

perk property ED_PerkTreeVL_Amaranth_Perk auto
perk property ED_PerkTree_Deception_65_DreamVisitor_Perk auto
perk property ED_PerkTreeVL_FountainOfLife_Perk auto

spell property ED_VampirePowers_Amaranth_Spell auto
spell property ED_VampirePowers_Amaranth_Disintegrate_Spell auto
spell property ED_VampirePowers_Ab_Masquerade_Spell auto
spell property ED_Mechanics_DrainAttributeRestore_Spell auto
spell property ED_Mechanics_Spell_TimeDilationCleaner auto
spell property ED_Mechanics_Spell_CheckIfInPairedAnimation auto
magiceffect property ED_Mechanics_Spell_CheckIfInPairedAnimation_Effect auto

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