;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_ED_Mechanics_Quest_RoyalG_062E02A0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Attacker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Attacker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_RoyalGuardianQuest_Script
Quest __temp = self as Quest
ED_RoyalGuardianQuest_Script kmyQuest = __temp as ED_RoyalGuardianQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.FindNearestAttackerAndSicDog()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE ED_RoyalGuardianQuest_Script
Quest __temp = self as Quest
ED_RoyalGuardianQuest_Script kmyQuest = __temp as ED_RoyalGuardianQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.GetRidOfDog()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
