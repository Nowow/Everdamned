;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname ED_FeedDialogue_SedFailPostprocess Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_Mechanics_FeedDialogue_Cooldown3d_Spell.Cast(akSpeaker, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Spell Property ED_Mechanics_FeedDialogue_Cooldown3d_Spell Auto

Idle Property ResetRoot  Auto 

actor property playerRef auto

Activator Property ED_Misc_Activator_FeedDialogueFailLines  Auto  
