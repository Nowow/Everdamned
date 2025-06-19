Scriptname ED_FeedManager_PlayerAlias extends ReferenceAlias  


String property BleedoutFinisherRustle = "ed_playsound_bleedoutrustle" auto
String property BloodgushImpact = "ed_impact_bloodgush" auto
String property FeedDoubletap = "ed_playsound_feeddoubletap" auto
String property SheatheWepons = "ed_sheatheweapons" auto

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned INFO: Feed Manager player alias OnPlayerLoadGame() called ")
	
	ED_FeedManager_Script FeedManager = GetOwningQuest() as ED_FeedManager_Script
	
	; feed km processing for VL and garkain
	FeedManager.RegisterFeedEvents()
	
	; feed km processing for mortal feed killmoves, separate to be separate thread
	if FeedManager.PlayerIsVampire.value == 1
		
		race playerRace = playerRef.GetRace()
		
		; using for custom feed anim sound events		
		RegisterForAnimationEvent(playerRef, BleedoutFinisherRustle)
		RegisterForAnimationEvent(playerRef, BloodgushImpact)
		RegisterForAnimationEvent(playerRef, FeedDoubletap)
		RegisterForAnimationEvent(playerRef, SheatheWepons)
		

	endif
EndEvent

Event OnRaceSwitchComplete()
 	Debug.Trace("Everdamned INFO: Feed Manager player alias OnRaceSwitchComplete() called ")
	
	ED_FeedManager_Script FeedManager = GetOwningQuest() as ED_FeedManager_Script
	
	; feed km processing for VL and garkain
	FeedManager.RegisterFeedEvents()
	
	; feed km processing for mortal feed killmoves, separate to be separate thread
	if FeedManager.PlayerIsVampire.value == 1
		
		race playerRace = playerRef.GetRace()
		
		; using for custom feed anim sound events		
		RegisterForAnimationEvent(playerRef, BleedoutFinisherRustle)
		RegisterForAnimationEvent(playerRef, BloodgushImpact)
		RegisterForAnimationEvent(playerRef, FeedDoubletap)

	endif
	
EndEvent


;  handles animations baked in .hkx, for sfx and other stuff directly related to playing animation
Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if asEventName == BloodgushImpact
			
		ED_Art_Spell_MouthMuzzleFlash.Cast(playerRef)
		utility.wait(0.3)
		Game.TriggerScreenBlood(100)
		
		debug.Trace("Everdamned DEBUG: Feed Manager caught BloodgushImpact event")
	
	elseif asEventName == BleedoutFinisherRustle
		ED_Art_SoundM_BleedoutFinishRustle.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught BleedoutFinisherRustle event")
	
	elseif asEventName == FeedDoubletap
		ED_Art_SoundM_FeedDoubletapJumping.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught FeedDoubletap event")
	
	elseif asEventName == SheatheWepons
		
		playerRef.UnequipItemEx(playerRef.GetEquippedWeapon(false), 1)
		playerRef.UnequipItemEx(playerRef.GetEquippedWeapon(true), 2)
		
	endif
endevent


;Event OnVampireFeed(actor akTarget)
	; event gets called after StartVampireFeed regardless of whether did the animation actually play
;	debug.Trace("Everdamned DEBUG: Feed Manager player alias caught OnVampireFeed event on target " + akTarget)
	
	; to check if player in animation here use playerRef.GetPlayerControls(), works with no utility.wait()
	
	; bFeedAnimRequiredForSuccess controlled via ED_FeedManager_Quest script states
;	if ED_FeedManager_Quest.bFeedAnimRequiredForSuccess == true
;		debug.Trace("Everdamned DEBUG: bFeedAnimRequiredForSuccess is true in this feed on" + akTarget)
;		if playerRef.GetPlayerControls() == false
;			debug.Trace("Everdamned DEBUG: playerRef.GetPlayerControls() is true, means player did play the anim, proceeding with feed effects")
;			Game.ForceThirdPerson()
;			ED_FeedManager_Quest.FeedManagerCallback(true)
;			return
			
	;		_killTarget = akTarget
	;		RegisterForAnimationEvent(playerRef, "KillMoveEnd")
;		else
;			debug.Trace("Everdamned DEBUG: but playerRef.GetPlayerControls() is false, anim didnt play, do nothing")
;			ED_FeedManager_Quest.FeedManagerCallback(false)
;			return
;		endif
;	else
;		debug.Trace("Everdamned DEBUG: bFeedAnimRequiredForSuccess is false, proceed with feed things regardless")
;	endif
	
;endevent


ED_FeedManager_Script property ED_FeedManager_Quest auto

sound property ED_Art_SoundM_FeedDoubletapJumping auto
sound property ED_Art_SoundM_BleedoutFinishRustle auto
spell property ED_Art_Spell_MouthMuzzleFlash auto

actor property playerRef auto
