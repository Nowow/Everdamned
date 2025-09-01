;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ED_Mechanics_Quest_Necrot_0BD4C860 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_NecroticFleshQuest_Script
Quest __temp = self as Quest
ED_NecroticFleshQuest_Script kmyQuest = __temp as ED_NecroticFleshQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.OnShutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE ED_NecroticFleshQuest_Script
Quest __temp = self as Quest
ED_NecroticFleshQuest_Script kmyQuest = __temp as ED_NecroticFleshQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.OnStartup()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
