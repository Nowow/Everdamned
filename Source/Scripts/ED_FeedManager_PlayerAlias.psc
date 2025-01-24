Scriptname ED_FeedManager_PlayerAlias extends ReferenceAlias  


bool property bFeedAnimRequiredForSuccess auto

Event OnInit()
	Debug.Trace("Everdamned DEBUG: Feed Manager player alias initialized")
endevent

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned INFO: Feed Manager player alias OnPlayerLoadGame() called ")
	(GetOwningQuest() as ED_FeedManager_Script).RegisterFeedEvents()
EndEvent

Event OnRaceSwitchComplete()
 	Debug.Trace("Everdamned INFO: Feed Manager player alias OnRaceSwitchComplete() called ")
	(GetOwningQuest() as ED_FeedManager_Script).RegisterFeedEvents()
EndEvent

actor _killTarget
Event OnVampireFeed(actor akTarget)
	; event gets called after StartVampireFeed regardless of whether did the animation actually play
	debug.Trace("Everdamned DEBUG: Feed Manager player alias caught OnVampireFeed event on target " + akTarget)
	
	; to check if player in animation here use playerRef.GetPlayerControls(), works with no utility.wait()
	
	if bFeedAnimRequiredForSuccess == true
		debug.Trace("Everdamned DEBUG: bFeedAnimRequiredForSuccess is true in this feed on" + akTarget)
		if playerRef.GetPlayerControls() == false
			debug.Trace("Everdamned DEBUG: playerRef.GetPlayerControls() is true, means player did play the anim, proceeding with feed effects")
			Game.ForceThirdPerson()
			return
			
	;		_killTarget = akTarget
	;		RegisterForAnimationEvent(playerRef, "KillMoveEnd")
		else
			debug.Trace("Everdamned DEBUG: but playerRef.GetPlayerControls() is false, anim didnt play, do nothing")
			return
		endif
	else
		debug.Trace("Everdamned DEBUG: bFeedAnimRequiredForSuccess is false, proceed with feed things regardless")
		
	endif
	
	
	
endevent

;Event OnAnimationEvent(ObjectReference akSource, string asEventName)
;	if _killTarget 
;		playerRef.pushactoraway(_killTarget, 30.0)
;		_killTarget.kill(playerRef)
;		_killTarget = none
;	endif
	
;endevent

ED_FeedManager_Script property ED_FeedManager_Quest auto

actor property playerRef auto
