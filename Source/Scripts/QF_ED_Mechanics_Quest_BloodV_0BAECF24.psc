;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_ED_Mechanics_Quest_BloodV_0BAECF24 Extends Quest Hidden

;BEGIN ALIAS PROPERTY TheOrb
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TheOrb Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TheHazard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TheHazard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_BloodVortexQuest_Script
Quest __temp = self as Quest
ED_BloodVortexQuest_Script kmyQuest = __temp as ED_BloodVortexQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.Startup()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_BloodVortexQuest_Script
Quest __temp = self as Quest
ED_BloodVortexQuest_Script kmyQuest = __temp as ED_BloodVortexQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.IncrementActorsDied()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE ED_BloodVortexQuest_Script
Quest __temp = self as Quest
ED_BloodVortexQuest_Script kmyQuest = __temp as ED_BloodVortexQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
