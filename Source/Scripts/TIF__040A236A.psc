;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname TIF__040A236A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker = akSpeakerRef as Actor
if akSpeaker.GetSitState() == 3
	debug.notification("Actor is sitting!")
	;FeedVictimRefAlias.ForceRefTo(akSpeakerRef)
	;FeedVictimRefAlias.TryToEvaluatePackage()


	;akSpeaker.PlayIdle(IdleFurnitureExit)
	;akSpeaker.EvaluatePackage()
	;debug.SendAnimationEvent(akSpeakerRef, "GetUp")
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property IdleFurnitureExit  Auto  

Alias Property FeedSpeakerAlias  Auto  

ReferenceAlias Property FeedVictimRefAlias  Auto  
