;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname QF__050732C0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.PrepShift()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.InitialShift()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
; normal wolfing around
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
; back to non-beast form

kmyQuest.ShiftBack()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
;babby drank juice, reverting when out of combat
kmyQuest.ShiftBackWhenOutOfCombat()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
; timer almost out

kmyQuest.WarnPlayer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE ED_PlayerVampireGarkainChangeScript
Quest __temp = self as Quest
ED_PlayerVampireGarkainChangeScript kmyQuest = __temp as ED_PlayerVampireGarkainChangeScript
;END AUTOCAST
;BEGIN CODE
; FEED

;kmyQuest.Feed()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
