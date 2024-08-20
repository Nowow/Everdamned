;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__040BAF80 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor akSpeakerA = akSpeakerRef as Actor
akSpeakerA.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 0)
debug.notification("Victim added to seduced fac")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

SPELL Property ED_VampireAbilities_Seduction_VictimVFX_Spell  Auto  
