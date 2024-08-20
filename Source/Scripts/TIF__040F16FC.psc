;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__040F16FC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().PlayIdle(ED_Idle_Seduction_OpenEnd)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.RemoveFromFaction(ED_Mechanics_FeedDialogue_Intimidated_Fac)
akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Fail_Fac, 1)
akSpeaker.SendAssaultAlarm()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Fail_Fac  Auto  

Faction Property ED_Mechanics_FeedDialogue_Intimidated_Fac  Auto  

Idle Property ED_Idle_Seduction_OpenEnd  Auto  
