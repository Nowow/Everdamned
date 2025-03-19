;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_ED_Mechanics_Quest_BeastF_055E1C86 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_FeedVictim
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_FeedVictim Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;NetImmerse.SetNodeScale((Alias_ED_FeedVictim.GetReference() as actor), "NPC Head [Head]", 3.0, false)
;stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
