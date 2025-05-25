;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ED_Mechanics_BlueBlood_Qu_0547F5D9 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_StrongFeed_08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_08 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_11
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_11 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_06 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_12
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_12 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_10
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_10 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_00
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_00 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_07 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_01 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_BlueBlood_Quest_Script
Quest __temp = self as Quest
ED_BlueBlood_Quest_Script kmyQuest = __temp as ED_BlueBlood_Quest_Script
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(10, true)
CompleteQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_BlueBlood_Quest_Script
Quest __temp = self as Quest
ED_BlueBlood_Quest_Script kmyQuest = __temp as ED_BlueBlood_Quest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.InitFeedList()
SetObjectiveDisplayed(10, true, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
