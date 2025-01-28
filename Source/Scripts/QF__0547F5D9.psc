;/ Decompiled by Champollion V1.0.1
Source   : QF_SCS_FeedManager_Quest_030FAB6F.psc
Modified : 2018-01-30 15:20:20
Compiled : 2018-01-30 15:20:22
User     : Maximilian
Computer : MARUNAE
/;
scriptName QF_SCS_FeedManager_Quest_030FAB6F extends Quest hidden

;-- Properties --------------------------------------
referencealias property Alias_SCS_StrongFeed_09 auto
referencealias property Alias_SCS_StrongFeed_08 auto
referencealias property Alias_SCS_StrongFeed_05 auto
referencealias property Alias_SCS_StrongFeed_12 auto
referencealias property Alias_SCS_StrongFeed_02 auto
referencealias property Alias_SCS_StrongFeed_04 auto
referencealias property Alias_SCS_StrongFeed_01 auto
referencealias property Alias_SCS_StrongFeed_06 auto
referencealias property Alias_SCS_StrongFeed_10 auto
referencealias property Alias_SCS_StrongFeed_03 auto
referencealias property Alias_SCS_StrongFeed_11 auto
referencealias property Alias_SCS_StrongFeed_07 auto
referencealias property Alias_SCS_StrongFeed_00 auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function Fragment_0()

	Quest __temp = self as Quest
	scs_feedmanager_quest kmyQuest = __temp as scs_feedmanager_quest
	self.SetObjectiveDisplayed(10, true, false)
	kmyQuest.InitFeedList()
endFunction

function Fragment_2()

	self.SetObjectiveCompleted(10, true)
	self.CompleteQuest()
endFunction
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname QF__0547F5D9 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_StrongFeed_12
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_12 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_08 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_00
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_00 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_11
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_11 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_06 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_07 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_StrongFeed_10
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_StrongFeed_10 Auto
;END ALIAS PROPERTY

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
