;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ED_Mechanics_Hemomancy_Qu_054ACEEE Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(Alias_ED_Player.GetReference() as actor).AddSpell(ED_VampireSpells_BloodSeed_Spell)
ED_HemomancyStudies_Script.StartLearningHemomancy()
SetStage(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;waiting to learn all of hemomancy
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;all hemomancy learned
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ED_HemomancyStudies_Quest property ED_HemomancyStudies_Script auto

SPELL Property ED_VampireSpells_BloodSeed_Spell  Auto  
