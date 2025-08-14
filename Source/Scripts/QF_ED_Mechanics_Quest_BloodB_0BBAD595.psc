;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_ED_Mechanics_Quest_BloodB_0BBAD595 Extends Quest Hidden

;BEGIN ALIAS PROPERTY BoilTarget
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BoilTarget Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EssentialHolder
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EssentialHolder Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_BloodBoilQuest_Script
Quest __temp = self as Quest
ED_BloodBoilQuest_Script kmyQuest = __temp as ED_BloodBoilQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE ED_BloodBoilQuest_Script
Quest __temp = self as Quest
ED_BloodBoilQuest_Script kmyQuest = __temp as ED_BloodBoilQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.Setup()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
