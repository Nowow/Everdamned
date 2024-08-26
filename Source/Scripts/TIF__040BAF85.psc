;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__040BAF85 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor akSpeakerA = akSpeakerRef as Actor
akSpeakerA.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 2)
debug.notification("Victim added to seduced fac")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
utility.wait(3)
debug.sendAnimationEvent(akSpeakerRef, "ed_seduction_flirt_playfulStart")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto

Idle Property ED_Idle_Seduction_PlayfulEnd  Auto  
