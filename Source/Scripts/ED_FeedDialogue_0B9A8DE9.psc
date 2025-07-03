;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_FeedDialogue_0B9A8DE9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_Mechanics_FeedDialogue_ExpressionSmile_Spell.Cast(akSpeaker)
ED_Mechanics_FeedDialogue_VictimSFX_Spell.Cast(akSpeaker)
;Scs_Blood_Marker_Auspex.Play(akSpeakerRef)
;utility.wait(0.5)
;DLC1EclipseCastImod.Apply(2.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ImageSpaceModifier Property DLC1EclipseCastImod  Auto  

Sound Property SCS_Blood_Marker_Auspex  Auto  

SPELL Property ED_Mechanics_FeedDialogue_ExpressionSmile_Spell  Auto  

SPELL Property ED_Mechanics_FeedDialogue_VictimSFX_Spell  Auto  
