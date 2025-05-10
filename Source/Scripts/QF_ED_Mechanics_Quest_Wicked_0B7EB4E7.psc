;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_ED_Mechanics_Quest_Wicked_0B7EB4E7 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
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
