;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0410F242 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
debug.Trace("Cleanup Topic reached, no assault")

actor playerRef = Game.GetPlayer()
if playerRef.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Player had Anim Trigger ME")
	playerRef.PlayIdle(ResetRoot)
endif

if akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Speaker had Anim Trigger ME")
	akSpeaker.PlayIdle(ResetRoot)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property ResetRoot  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto  
