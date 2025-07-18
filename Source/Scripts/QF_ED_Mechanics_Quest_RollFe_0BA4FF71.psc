;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_ED_Mechanics_Quest_RollFe_0BA4FF71 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Seduced
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Seduced Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_Seducer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Seducer Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_FeedDialogue_Script
Quest __temp = self as Quest
ED_FeedDialogue_Script kmyQuest = __temp as ED_FeedDialogue_Script
;END AUTOCAST
;BEGIN CODE
debug.Trace("Everdamned DEBUG: ROLL QUEST START FRAGMENT!")
kmyQuest.DoTheThing()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
