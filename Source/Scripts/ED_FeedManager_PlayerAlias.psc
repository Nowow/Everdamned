Scriptname ED_FeedManager_PlayerAlias extends ReferenceAlias  

Event OnInit()
	Debug.Trace("Everdamned DEBUG: Feed Manager player alias initialized")
endevent

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned INFO: Feed Manager player alias OnPlayerLoadGame() called ")
	ED_FeedManager_Quest.RegisterFeedEvents()
EndEvent

Event OnRaceSwitchComplete()
 	Debug.Trace("Everdamned INFO: Feed Manager player alias OnRaceSwitchComplete() called ")
	ED_FeedManager_Quest.RegisterFeedEvents()
EndEvent

actor _killTarget
Event OnVampireFeed(actor akTarget)
	; event gets called after StartVampireFeed regardless of whether did the animation actually play
	debug.Trace("Everdamned DEBUG: Feed Manager player alias caught OnVampireFeed event on target " + akTarget)
	
	; to check if player in animation here use playerRef.GetPlayerControls(), works with no utility.wait()
	
	if playerRef.GetPlayerControls() == false
		Game.ForceThirdPerson()
;		_killTarget = akTarget
;		RegisterForAnimationEvent(playerRef, "KillMoveEnd")
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
