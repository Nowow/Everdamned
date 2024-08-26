;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0410A30D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
debug.Trace("Flee with Assault Topic reached")

actor playerRef = Game.GetPlayer()
if playerRef.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Player had Anim Trigger ME")
	playerRef.PlayIdle(ResetRoot)
endif

if akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Speaker had Anim Trigger ME")
	akSpeaker.PlayIdle(ResetRoot)
endif

ED_FeedDialogue_Target.ForceRefTo(akSpeaker)
ED_Mechanics_FeedDialogue_Flee_Scene.Start()
utility.wait(1.5)
akSpeaker.SendAssaultAlarm()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property ResetRoot  Auto  

Scene Property ED_Mechanics_FeedDialogue_Flee_Scene  Auto  

ReferenceAlias Property ED_FeedDialogue_Target  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto  
