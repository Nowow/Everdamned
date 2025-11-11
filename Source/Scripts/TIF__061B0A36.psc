;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__061B0A36 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ThisTopicFinished = true
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
playerRef.PlayIdle(ED_Idle_Seduction_PlayerSequenceEnd)
utility.wait(1.5)
if !ThisTopicFinished && akSpeaker.IsInDialogueWithPlayer()
	input.TapKey(input.GetMappedKey("Activate"))
endif

;int __timeout
;bool __continue
;__continue = akSpeaker.IsInDialogueWithPlayer()
;while __continue && __timeout < 100
;	input.TapKey(input.GetMappedKey("Activate"))
;	__continue = akSpeaker.IsInDialogueWithPlayer()
;	__timeout = __timeout + 1
;	utility.wait(0.1)
;endwhile
;debug.Trace("Everdamned DEBUG: Timeout: "  + __timeout)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Bool Property ThisTopicFinished  Auto  

actor property playerRef auto

Idle Property ED_Idle_Seduction_PlayerSequenceEnd  Auto  
