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

function HandleFeed(actor FeedTarget)

	debug.Trace("Everdamned DEBUG:  Feed Manager recieved Drain call on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	;TODO: change for bystander quest
	;call for help
	FeedTarget.SendAssaultAlarm()
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget)
	
	;psychic vampire check
	ED_Mechanics_PsychicVampire_Spell.Cast(playerRef, FeedTarget)
	
	;age for 2h
	ED_Mechanics_Main_Quest.GainAgeExpirience(2.0)
	
	;TODO: Vamp XP

	;Blue Blood
	actorbase TargetBase = FeedTarget.GetActorBase()
	Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
	if Index >= 0
		; removing from tracking
		ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
		ED_BlueBlood_Quest.ProcessVIP(TargetBase)
	endIf
	
endfunction

function HandleDrain(actor FeedTarget, bool isDiablerie = false)
	debug.Trace("Everdamned DEBUG: Feed Manager recieved Drain call on target " + FeedTarget)
	
	; tell OAR that ist jump feed killmove
	ED_Mechanics_Global_FeedType.SetValue(1.0)
	;start actual feed animation
	
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	;TODO: change for bystander quest
	;call for help
	FeedTarget.SendAssaultAlarm()
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx, maybe should bake into animation?
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	;adjust status bloodpool etc
	;PlayerVampireQuest.VampireFeed()
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.5)
	
	;psychic vampire check
	;should not apply at combat drain
	ED_Mechanics_PsychicVampire_Spell.Cast(playerRef, FeedTarget)
	
	;TODO: restore attributes according to VL perk POSSIBLY
	debug.Trace("Everdamned DEBUG NOT IMPLEMENTED: Attribute restore on feed")
	
	;age for 1 day, default amount for regular drain
	ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
	
	;TODO: Vamp XP
	
	;start hemomancy studies tracker and giff blood seed
	if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
		ED_Mechanics_Hemomancy_Quest.start()
	endif
	
	;TODO: diablerie 
	
	;Blue Blood
	actorbase TargetBase = FeedTarget.GetActorBase()
	Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
	if Index >= 0
		; removing from tracking
		ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
		ED_BlueBlood_Quest.ProcessVIP(TargetBase)
	endIf
endfunction

function HandleCombatDrain(actor FeedTarget, bool isDiablerie = false)
	debug.Trace("Everdamned DEBUG: Player combat drains target " + FeedTarget)
	
	aFeedTarget = FeedTarget

	debug.Trace("Everdamned DEBUG: Feed Manager goes to CombatDrain state, waiting for FeedManagerCallback call from alias script")
	GoToState("CombatDrain")
	
endfunction

function HandleDialogueFeed(actor FeedTarget)
	debug.Trace("Everdamned DEBUG: Player feeds on target " + FeedTarget)
	
	; tell OAR that ist vanilla feed animation
	ED_Mechanics_Global_FeedType.SetValue(0.0)
	
	;start actual feed animation
	PlayerRef.StartVampireFeed(FeedTarget)
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	;no assault alarm
	
	; for vampire converting sidequest
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;sfx controlled by dialogue fragments
	;sfx, maybe should bake into animation?
	;ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)

	
	;adjust status bloodpool etc
	PlayerVampireQuest.EatThisActor(FeedTarget, 0.3)
	
	;psychic vampire check
	ED_Mechanics_PsychicVampire_Spell.Cast(playerRef, FeedTarget)
	
	;age for 3h
	ED_Mechanics_Main_Quest.GainAgeExpirience(3.0)
	
	;TODO: Vamp XP

	;Blue Blood
	actorbase TargetBase = FeedTarget.GetActorBase()
	Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
	if Index >= 0
		; removing from tracking
		ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
		ED_BlueBlood_Quest.ProcessVIP(TargetBase)
	endIf
endfunction

state CombatDrain
	;handles should do nothing till state is released
	function HandleDialogueFeed(actor FeedTarget)
	endfunction
	function HandleCombatDrain(actor FeedTarget, bool isDiablerie = false)
	endfunction
	function HandleDrain(actor FeedTarget, bool isDiablerie = false)
	endfunction
	function HandleFeed(actor FeedTarget)
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
			
			;call for help
			aFeedTarget.SendAssaultAlarm()
			
			; for vampire converting sidequest
			if aFeedTarget.IsInFaction(DLC1PotentialVampireFaction) && aFeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
				DLC1VampireTurn.PlayerBitesMe(aFeedTarget)
			endif
			
			;sfx, maybe should bake into animation?
			ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(aFeedTarget as objectreference)
	
			;adjust status bloodpool etc
			PlayerVampireQuest.EatThisActor(aFeedTarget, 0.5)
			
			;psychic vampire check
			;should not apply at combat drain
			;ED_Mechanics_PsychicVampire_Spell.Cast(playerRef, aFeedTarget)
			
			;TODO: restore attributes according to VL perk POSSIBLY
			debug.Trace("Everdamned DEBUG NOT IMPLEMENTED: Attribute restore on feed")
			
			;age for 1 day, default amount for regular drain
			ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
			
			;TODO: Vamp XP
			
			;start hemomancy studies tracker and giff blood seed
			if !(ED_Mechanics_Hemomancy_Quest.IsStageDone(0))
				ED_Mechanics_Hemomancy_Quest.start()
			endif
			;TODO: maybe advance hemomancy with drains?
			;maybe require use of hemomancy skills and then drain will advance?
			
			;Blue Blood
			actorbase TargetBase = aFeedTarget.GetActorBase()
			Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
			if Index >= 0
				; removing from tracking
				ED_Mechanics_BlueBlood_Track_FormList.RemoveAddedForm(TargetBase as form)
				ED_BlueBlood_Quest.ProcessVIP(TargetBase)
			endIf
			
			
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
spell property ED_Mechanics_PsychicVampire_Spell auto
quest property ED_Mechanics_Hemomancy_Quest auto
globalvariable property ED_Mechanics_Global_FeedType auto

playerVampireQuestScript property PlayerVampireQuest auto
dlc1vampireturnscript property DLC1VampireTurn auto
ed_mainquest_script property ED_Mechanics_Main_Quest auto
ED_BlueBlood_Quest_Script property ED_BlueBlood_Quest auto
