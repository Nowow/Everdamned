;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF_ED_Mechanics_Quest_Undyin_0BEC83EF Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_UndyingServant1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_UndyingServant1 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_UndyingLoyaltyQuest_Script
Quest __temp = self as Quest
ED_UndyingLoyaltyQuest_Script kmyQuest = __temp as ED_UndyingLoyaltyQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.ConsistencyCheck()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
