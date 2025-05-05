;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_ED_Mechanics_Quest_Mesmer_0B70772B Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Target
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Target Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Mesmerized quest started!!!!!!")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_MesmerizeQuest_Script
Quest __temp = self as Quest
ED_MesmerizeQuest_Script kmyQuest = __temp as ED_MesmerizeQuest_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.DispelSeductionOnShutdown()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
