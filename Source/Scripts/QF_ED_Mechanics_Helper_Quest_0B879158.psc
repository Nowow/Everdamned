;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname QF_ED_Mechanics_Helper_Quest_0B879158 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
(Alias_ED_Player as ED_BloodCostDeducter_Script).GoToState("UnearthlyWill")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
actor playerRef = Game.GetPlayer()
playerRef.AddSpell(ED_Mechanics_Spell_InstinctiveCharmToggle)
playerRef.AddSpell(ED_Mechanics_Spell_InstinctiveCharmAb, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Game.GetPlayer().AddSpell(ED_Mechanics_UnlockDisplayAb_Potence, false)
ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Game.GetPlayer().AddSpell(ED_VampirePowers_Ab_Presence_Spell, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ED_HotKeys_Script property ED_Mechanics_HotKeys_Quest auto

spell Property ED_VampirePowers_Ab_Presence_Spell  Auto  

SPELL Property ED_Mechanics_UnlockDisplayAb_Potence  Auto  

SPELL Property ED_Mechanics_Spell_InstinctiveCharmToggle  Auto  

SPELL Property ED_Mechanics_Spell_InstinctiveCharmAb  Auto  
