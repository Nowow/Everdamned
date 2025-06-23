;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_ED_Mechanics_Hemomancy_Qu_054ACEEE Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
ED_HemomancyStudies_Script.AdvanceHemomancy()
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

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(Alias_ED_Player.GetReference() as actor).AddPerk(ED_PerkTree_BloodMagic_10_Hemomancy_Perk)
message.ResetHelpMessage("ed_hemomancy_first_drain")
ED_Mechanics_Message_HemomancyFirstDrain.ShowAsHelpMessage("ed_hemomancy_first_drain", 5.0, 1.0, 1)
ED_HemomancyStudies_Script.StartLearningHemomancy()
SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ED_HemomancyStudies_Quest property ED_HemomancyStudies_Script auto

SPELL Property ED_VampireSpells_BloodSeed_Spell  Auto  

Perk Property ED_PerkTree_BloodMagic_10_Hemomancy_Perk  Auto  

Message Property ED_Mechanics_Message_HemomancyFirstDrain  Auto  
