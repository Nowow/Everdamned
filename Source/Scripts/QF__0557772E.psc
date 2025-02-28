;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname QF__0557772E Extends Quest Hidden

;BEGIN ALIAS PROPERTY Bystander3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander7
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander7 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander8
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander8 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bystander6
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bystander6 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Victim
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Victim Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE ED_FeedBystander_Script
Quest __temp = self as Quest
ED_FeedBystander_Script kmyQuest = __temp as ED_FeedBystander_Script
;END AUTOCAST
;BEGIN CODE
; debug.trace("DLC1VampireFeedBystander startup stage 1, will call CheckBystandersSendAlarmAndStopQuest()")
kmyquest.CheckBystandersSendAlarmAndStopQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


