Scriptname ED_FeedManager_Script extends Quest  

actor property aFeedTarget auto
bool property bFeedAnimRequiredForSuccess auto


Function RegisterFeedEvents()
	if PlayerIsVampire.value == 1
		debug.Trace("Everdamned DEBUG: RegisterFeedEvents() called for vampire")
		race playerRace = playerRef.GetRace()
		; TODO: why not DLC1VampireBeastRace?
		if (playerRace != VampireGarkainBeastRace) && (playerRace != DLC1VampireBeastRace)
			Debug.Trace("Everdamned INFO: Registred player for feed animation events")
			unRegisterForAnimationEvent(playerRef, "SoundPlay.NPCVampireLordFeed")
			utility.wait(1)
			RegisterForAnimationEvent(playerRef, "SoundPlay.NPCVampireLordFeed")
		endif
	endif
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	; TODO: change to some specific custom animevent to differentiate from regular feed and killmove
	;if asEventName == "SoundPlay.NPCVampireLordFeed"
	;	PlayerVampireQuest.VampireFeed() 544D0F
	;endif
endevent

; done
function HandleFeedThrall(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Feed Thrall call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	;no call for help
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.2)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(2.0)
	
	;TODO: Vamp XP

	;Blue Blood
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
	
endfunction

;TODO: trigger hemomancy progression, diablerie, restore stats
function HandleDrainThrall(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Thrall call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	;no call for help
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)
	
	if playerRef.HasPerk(ED_PerkTreeVL_FountainOfLife_Perk)
		playerRef.RestoreActorValue("Health", 9999.0)
		playerRef.RestoreActorValue("Magicka", 9999.0)
		playerRef.RestoreActorValue("Stamina", 9999.0)
	endif

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
	
	; kill, redo for killmove
	FeedTarget.KillSilent(playerRef)
	
	;start hemomancy studies tracker and giff blood seed
	; TODO: deal with stopped quest because of hemomancy all learned
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	else
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.AdvanceHemomancy()
	endif
	
	;TODO: Vamp XP

	;Blue Blood
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
	
endfunction

; done
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
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(2.0)
	
	;TODO: Vamp XP

	;Blue Blood
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
	
endfunction

; TODO: trigger hemomancy progression, diablerie, restore stats
function HandleDrainMesmerized(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Mesmerized call on target " + FeedTarget)
	
	; tell OAR that ist jump feed killmove
	ED_Mechanics_Global_FeedType.SetValue(1.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
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
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	; fountain of life restore stats
	if playerRef.HasPerk(ED_PerkTreeVL_FountainOfLife_Perk)
		playerRef.RestoreActorValue("Health", 9999.0)
		playerRef.RestoreActorValue("Magicka", 9999.0)
		playerRef.RestoreActorValue("Stamina", 9999.0)
	endif

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)

	; kill, redo for killmove
	; silent because detection handled by bystander quest
	FeedTarget.KillSilent(playerRef)
	
	;diablerie and aging
	if FeedTarget.HasKeyword(Vampire)
		float __ageMult = FeedTarget.GetLevel() / playerRef.GetLevel()
		debug.Trace("Everdamned INFO: Feed Manager detects diablerie, aging with mult: " + __ageMult)
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * __ageMult)
		
		if playerRef.HasPerk(ED_PerkTreeVL_Amaranth_Perk)
			ED_VampirePowers_Amaranth_Spell.Cast(playerRef)
			ED_VampirePowers_Amaranth_Disintegrate_Spell.Cast(playerRef, FeedTarget)
		endif
	else
		;age for 1 day, default amount for regular drain
		ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
	endif
	
	;TODO: Vamp XP
	
	;start hemomancy studies tracker and giff blood seed
	; TODO: deal with stopped quest because of hemomancy all learned
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	else
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.AdvanceHemomancy()
	endif
	
	;Blue Blood
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
endfunction

; TODO: conditions
function HandleDialogueSeduction(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Dialogue Seduction call on target " + FeedTarget)
	
	; TODO: add and use social feeding animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	else
	
		; 2 factors
		; IF social feeding is allowed
		; IF social feeding triggers alarm check
		; TODO: both should be checked not here, in seduction dialogue
	
		;LocTypeDwelling - allow IF CONDITION with bystander check
		
		;LocTypeHouse - not trespassing/high relationship, allow with bystander check
		;LocTypeInn - no check allow
		
		;LocTypeCastle
		;LocTypeGuild

		; TODO: work out conditions for bystander check
		;getdetected
		;getlos
		
		
		;at 10 light half meter radius = 35 units
		;at 70+ light 30 meters 600 unit
		float __lightLevel = PlayerRef.GetLightLevel()
		if __lightLevel <= 10.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0
		elseif __lightLevel >= 70.0
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 300.0
		else
			ED_Mechanics_Global_VampireFeedBystanderRadius.value = 35.0 + (24.663*math.pow(2.718,0.04*(__lightLevel - 10.0)) - 25.0)
		endif
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx controlled by dialogue fragments
	;sfx, maybe should bake into animation?
	;ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	
	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.35)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(8.0)
	
	;TODO: Vamp XP

	;Blue Blood
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
endfunction

function HandleDialogueIntimidation(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Dialogue Intimidation call on target " + FeedTarget)
	
	; vanilla anim
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
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
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx controlled by dialogue fragments
	;sfx, maybe should bake into animation?
	;ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	
	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.2)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 3h
	ED_Mechanics_Main_Quest.GainAgeExpirience(8.0)
	
	;TODO: Vamp XP

	;Blue Blood
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
endfunction

function HandleFeedSleep(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Feed Sleep call on target " + FeedTarget)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
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
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx controlled by dialogue fragments
	;sfx, maybe should bake into animation?
	;ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	
	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.3)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 3h
	ED_Mechanics_Main_Quest.GainAgeExpirience(4.0)
	
	;TODO: Vamp XP

	;Blue Blood
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
endfunction

; TODO: trigger hemomancy progression, restore stats
function HandleDrainSleep(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain Sleep call on target " + FeedTarget)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
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
		debug.Trace("Everdamned DEBUG: Feed Manager launched Bystander quest, radius: " + ED_Mechanics_Global_VampireFeedBystanderRadius.value)
		ED_Mechanics_Keyword_BystanderStart.SendStoryEvent(akRef1 = FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)
	
	;TODO: restore attributes according to VL perk POSSIBLY
	debug.Trace("Everdamned DEBUG NOT IMPLEMENTED: Attribute restore on feed")

	if playerRef.HasPerk(ED_PerkTreeVL_FountainOfLife_Perk)
		playerRef.RestoreActorValue("Health", 9999.0)
		playerRef.RestoreActorValue("Magicka", 9999.0)
		playerRef.RestoreActorValue("Stamina", 9999.0)
	endif

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	;psychic vampire check
	ED_Mechanics_Keyword_PsychicVampireStart.SendStoryEvent(akRef1 = FeedTarget)
	
	;age for 1 day, default amount for regular drain
	ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)

	; kill, redo for killmove
	; silent because detection handled by bystander quest
	FeedTarget.KillSilent(playerRef)
	
	;TODO: Vamp XP
	
	;start hemomancy studies tracker and giff blood seed
	; TODO: deal with stopped quest because of hemomancy all learned
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	else
		; we ate, we try to learn new spells
		ED_Mechanics_Hemomancy_Quest.AdvanceHemomancy()
	endif
	
	;Blue Blood
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
	
	
	
	
endfunction

; TODO: trigger hemomancy progression, diablerie, restore stats
function HandleCombatDrain(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Player combat drains target " + FeedTarget)
	
	aFeedTarget = FeedTarget

	debug.Trace("Everdamned DEBUG: Feed Manager goes to CombatDrain state, waiting for FeedManagerCallback call from alias script")
	GoToState("CombatDrain")
	
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
	function HandleDialogueSeduction(actor FeedTarget)
	endfunction
	function HandleDialogueIntimidation(actor FeedTarget)
	endfunction
	function HandleFeedSleep(actor FeedTarget)
	endfunction
	function HandleDrainSleep(actor FeedTarget)
	endfunction
	function HandleCombatDrain(actor FeedTarget)
	endfunction
	
	event OnBeginState()
		debug.Trace("Everdamned DEBUG: Feed Manager entered CombatDrain state, bFeedAnimRequiredForSuccess = true")
		; tell OAR that ist jump feed killmove
		ED_Mechanics_Global_FeedType.SetValue(1.0)
		
		bFeedAnimRequiredForSuccess = true
		debug.Trace("Everdamned DEBUG: Feed Manager starts Vampire Feed with aFeedTarget")
		PlayerRef.StartVampireFeed(aFeedTarget)
		;TODO: add a failsafe, like RegisterForSingleUpdate(5.0)
	
	endevent
	event OnEndState()
		aFeedTarget = none
		bFeedAnimRequiredForSuccess = false
		debug.Trace("Everdamned DEBUG: Feed Manager exited CombatDrain state, bFeedAnimRequiredForSuccess = false")
	endevent

	function FeedManagerCallback(bool checkResult)
		if checkResult
			debug.Trace("Everdamned DEBUG: Feed Manager callback was called in CombatDrain state, feed anim WAS played, proceed")
			
			;TODO: mark target as fed upon, when decided how that should impact feeding
			
			; for vampire converting sidequest
			if aFeedTarget.IsInFaction(DLC1PotentialVampireFaction) && aFeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
				DLC1VampireTurn.PlayerBitesMe(aFeedTarget)
			endif
			
			;sfx, maybe should bake into animation?
			ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(aFeedTarget as objectreference)
			
			if playerRef.HasPerk(ED_PerkTreeVL_FountainOfLife_Perk)
				playerRef.RestoreActorValue("Health", 9999.0)
				playerRef.RestoreActorValue("Magicka", 9999.0)
				playerRef.RestoreActorValue("Stamina", 9999.0)
			endif
	
			;adjust status bloodpool etc
			PlayerVampireQuest.EatThisActor(aFeedTarget, 0.5)
			
			;diablerie
			if aFeedTarget.HasKeyword(Vampire)
				float __ageMult = aFeedTarget.GetLevel() / playerRef.GetLevel()
				debug.Trace("Everdamned INFO: Feed Manager detects diablerie, aging with mult: " + __ageMult)
				ED_Mechanics_Main_Quest.GainAgeExpirience(24.0 * __ageMult)
				
				if playerRef.HasPerk(ED_PerkTreeVL_Amaranth_Perk)
					ED_VampirePowers_Amaranth_Spell.Cast(playerRef)
					ED_VampirePowers_Amaranth_Disintegrate_Spell.Cast(playerRef, aFeedTarget)
				endif
			else
				;age for 1 day, default amount for regular drain
				ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
			endif
			
			;TODO: Vamp XP
			
			;start hemomancy studies tracker and giff blood seed
			; TODO: deal with stopped quest because of hemomancy all learned
			if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
				ED_Mechanics_Hemomancy_Quest.start()
			else
				; we ate, we try to learn new spells
				ED_Mechanics_Hemomancy_Quest.AdvanceHemomancy()
			endif
			
			;Blue Blood
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
			
			
		else
			debug.Trace("Everdamned DEBUG: Feed Manager callback was called in CombatDrain state, feed anim WAS NOT played, do nothing")
		endif
		GoToState("")
	endfunction
endstate

; necessary to define same function in non default state
function FeedManagerCallback(bool checkResult)
	debug.Trace("Everdamned DEBUG: Feed Manager callback was called in Empty state, probably a timeouted callback from player alias on this quest")
endfunction


actor property playerRef auto
Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto
faction Property DLC1PotentialVampireFaction auto
Faction Property DLC1PlayerTurnedVampire auto	
GlobalVariable Property PlayerIsVampire  Auto
sound property ED_Art_Sound_NPCHumanVampireFeed_Marker auto
formlist property ED_Mechanics_BlueBlood_Track_FormList auto
quest property ED_Mechanics_Hemomancy_Quest auto
globalvariable property ED_Mechanics_Global_FeedType auto
globalvariable property ED_Mechanics_Global_VampireFeedBystanderRadius auto

perk property ED_PerkTreeVL_FountainOfLife_Perk auto
perk property ED_PerkTreeVL_Amaranth_Perk auto

spell property ED_Mechanics_PsychicVampire_Spell auto
spell property ED_VampirePowers_Amaranth_Spell auto
spell property ED_VampirePowers_Amaranth_Disintegrate_Spell auto

keyword property ED_Mechanics_Keyword_BystanderStart auto
keyword property ED_Mechanics_Keyword_PsychicVampireStart auto
keyword property ED_Mechanics_Keyword_BlueBlood_VIP auto
keyword property Vampire auto

playerVampireQuestScript property PlayerVampireQuest auto
dlc1vampireturnscript property DLC1VampireTurn auto
ed_mainquest_script property ED_Mechanics_Main_Quest auto
ED_BlueBlood_Quest_Script property ED_BlueBlood_Quest auto
