;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname TIF__040A236A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell.Cast(akSpeaker, akSpeaker)
ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell.Cast(PlayerRef, PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as Ed_FeedDialogue_Script).CalculateScoreAndDiffuculty(PlayerRef, akSpeakerRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef  Auto  

SPELL Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell  Auto  
