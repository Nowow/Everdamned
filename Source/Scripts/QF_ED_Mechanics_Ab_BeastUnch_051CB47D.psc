;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname QF_ED_Mechanics_Ab_BeastUnch_051CB47D Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE ED_BeastUnchained_Quest_Script
Quest __temp = self as Quest
ED_BeastUnchained_Quest_Script kmyQuest = __temp as ED_BeastUnchained_Quest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE ED_BeastUnchained_Quest_Script
Quest __temp = self as Quest
ED_BeastUnchained_Quest_Script kmyQuest = __temp as ED_BeastUnchained_Quest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.TransformAverted()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_BeastUnchained_Quest_Script
Quest __temp = self as Quest
ED_BeastUnchained_Quest_Script kmyQuest = __temp as ED_BeastUnchained_Quest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetupTracking()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_BeastUnchained_Quest_Script
Quest __temp = self as Quest
ED_BeastUnchained_Quest_Script kmyQuest = __temp as ED_BeastUnchained_Quest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.TransformImmenent()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE ED_BeastUnchained_Quest_Script
Quest __temp = self as Quest
ED_BeastUnchained_Quest_Script kmyQuest = __temp as ED_BeastUnchained_Quest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.DoTransform()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
