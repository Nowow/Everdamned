;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_ED_Mechanics_Quest_Wicked_0B7EB4E7 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetCurrentStageID(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_WickedWindTargetingQuest_Script
Quest __temp = self as Quest
ED_WickedWindTargetingQuest_Script kmyQuest = __temp as ED_WickedWindTargetingQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartPolling()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
