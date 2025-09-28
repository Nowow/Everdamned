;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF_ED_Mechanics_TentacleSear_0601B7EA Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_TentacleAnchor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_TentacleAnchor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_Victim
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Victim Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_Tentacle
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Tentacle Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE ED_BloodTentacleHit_Script
Quest __temp = self as Quest
ED_BloodTentacleHit_Script kmyQuest = __temp as ED_BloodTentacleHit_Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.Slap()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
