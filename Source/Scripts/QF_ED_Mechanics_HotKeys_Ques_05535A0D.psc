;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_ED_Mechanics_HotKeys_Ques_05535A0D Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE ED_HotKeys_Script
Quest __temp = self as Quest
ED_HotKeys_Script kmyQuest = __temp as ED_HotKeys_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.UnRegisterHotkeys()
debug.Trace("Everdamned INFO: Hotkey quest just ended!")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_HotKeys_Script
Quest __temp = self as Quest
ED_HotKeys_Script kmyQuest = __temp as ED_HotKeys_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.RegisterHotkeys()
debug.Trace("Everdamned INFO: Hotkey quest just started!")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
