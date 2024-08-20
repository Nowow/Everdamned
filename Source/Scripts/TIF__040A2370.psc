;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__040A2370 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;debug.trace(";adding to dialogue Fail faction with rank 0 that means a temporary block for dialogue")
akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Fail_Fac, 0)
ED_Mechanics_FeedDialogue_Cooldown3d_Spell.Cast(akSpeaker, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Fail_Fac  Auto  

SPELL Property ED_Mechanics_FeedDialogue_Cooldown3d_Spell  Auto  
