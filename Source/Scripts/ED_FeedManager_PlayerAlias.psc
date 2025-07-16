Scriptname ED_FeedManager_PlayerAlias extends ReferenceAlias  


String property BleedoutFinisherRustle = "ed_playsound_bleedoutrustle" auto
String property BloodgushImpact = "ed_impact_bloodgush" auto
String property BloodgushImpactShort = "ed_impact_bloodgushshort" auto
String property FeedDoubletap = "ed_playsound_feeddoubletap" auto
String property SocialFeedBite = "ed_socialfeedbite" auto
string property FeedSatiation = "ed_feedsatiation" auto

String property SheatheWepons = "ed_sheatheweapons" auto


function RegisterFeedSFXEvents()
	RegisterForAnimationEvent(playerRef, BleedoutFinisherRustle)
	RegisterForAnimationEvent(playerRef, BloodgushImpact)
	RegisterForAnimationEvent(playerRef, BloodgushImpactShort)
	RegisterForAnimationEvent(playerRef, FeedDoubletap)
	RegisterForAnimationEvent(playerRef, SocialFeedBite)
	RegisterForAnimationEvent(playerRef, SheatheWepons)
	RegisterForAnimationEvent(playerRef, FeedSatiation)
endfunction

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned INFO: Feed Manager player alias OnPlayerLoadGame() called ")
	
	ED_FeedManager_Script FeedManager = GetOwningQuest() as ED_FeedManager_Script
	
	; feed km processing for VL and garkain
	FeedManager.RegisterFeedEvents()
	
	; feed km processing for mortal feed killmoves, separate to be separate thread
	
	race playerRace = playerRef.GetRace()
	if FeedManager.PlayerIsVampire.value == 1 && playerRace != VampireGarkainBeastRace && playerRace != DLC1VampireBeastRace
		
		; using for custom feed anim sound events		
		RegisterFeedSFXEvents()

	endif
EndEvent

Event OnRaceSwitchComplete()
 	Debug.Trace("Everdamned INFO: Feed Manager player alias OnRaceSwitchComplete() called ")
	
	ED_FeedManager_Script FeedManager = GetOwningQuest() as ED_FeedManager_Script
	
	; feed km processing for VL and garkain
	FeedManager.RegisterFeedEvents()
	
	; feed km processing for mortal feed killmoves, separate to be separate thread
	race playerRace = playerRef.GetRace()
	if FeedManager.PlayerIsVampire.value == 1 && playerRace != VampireGarkainBeastRace && playerRace != DLC1VampireBeastRace
		
		; using for custom feed anim sound events		
		RegisterFeedSFXEvents()

	endif
	
EndEvent


;  handles animations baked in .hkx, for sfx and other stuff directly related to playing animation
Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if asEventName == BloodgushImpact
			
		ED_Art_Spell_MouthMuzzleFlash.Cast(playerRef)
		utility.wait(0.3)
		Game.TriggerScreenBlood(100)
		
		debug.Trace("Everdamned DEBUG: Feed Manager caught BloodgushImpact event")
		
	elseif asEventName == BloodgushImpactShort
		ED_Art_Spell_MouthMuzzleFlashShort.Cast(playerRef)
		
		debug.Trace("Everdamned DEBUG: Feed Manager caught BloodgushImpactShort event")
		
	elseif asEventName == FeedDoubletap
		ED_Art_SoundM_FeedDoubletapJumping.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught FeedDoubletap event")
		
	elseif asEventName == SocialFeedBite
		ED_Art_SoundM_SocialFeedBite.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught SocialFeedBite event")
	
	elseif asEventName == FeedSatiation
		ED_Art_SoundM_FeedSatiation.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught FeedSatiation event")
	
	elseif asEventName == BleedoutFinisherRustle
		ED_Art_SoundM_BleedoutFinishRustle.Play(playerRef)
		debug.Trace("Everdamned DEBUG: Feed Manager caught BleedoutFinisherRustle event")
	
	elseif asEventName == SheatheWepons
		
		playerRef.UnequipItemEx(playerRef.GetEquippedWeapon(false), 1)
		playerRef.UnequipItemEx(playerRef.GetEquippedWeapon(true), 2)
		debug.Trace("Everdamned DEBUG: Feed Manager caught SheatheWepons event")
	
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
sound property ED_Art_SoundM_SocialFeedBite auto
sound property ED_Art_SoundM_FeedSatiation auto

spell property ED_Art_Spell_MouthMuzzleFlash auto
spell property ED_Art_Spell_MouthMuzzleFlashShort auto

Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto

actor property playerRef auto
