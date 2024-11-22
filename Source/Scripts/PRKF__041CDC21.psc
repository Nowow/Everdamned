;/ Decompiled by Champollion V1.0.1
Source   : PRKF_SCS_Mechanics_Perk_Vamp_0301E41B.psc
Modified : 2018-02-17 19:31:36
Compiled : 2018-02-17 19:31:39
User     : Maximilian
Computer : MARUNAE
/;
scriptName PRKF_SCS_Mechanics_Perk_Vamp_0301E41B extends Perk hidden

;-- Properties --------------------------------------
scs_feedmanager_quest property FeedManager auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_38(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, false, false, true, false, false, false)
endFunction

function Fragment_248(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, false, true, false, true, false, true)
endFunction

function Fragment_237(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, true, false, false, false, true, false)
endFunction

; Skipped compiler generated GetState

function Fragment_228(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, false, false, false, false, false, false)
endFunction

function Fragment_0(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, false, true, false, false, false, false)
endFunction

; Skipped compiler generated GotoState

function Fragment_2(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, false, false, false, false, false, false)
endFunction

function Fragment_56(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, true, true, false, false, false, false)
endFunction

function Fragment_60(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, true, false, true, false, false, false)
endFunction

function Fragment_58(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, true, false, false, false, false, false)
endFunction

function Fragment_235(ObjectReference akTargetRef, Actor akActor)

	FeedManager.ProcessFeed(akTargetRef as Actor, false, false, false, false, true, false)
endFunction
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname PRKF__041CDC21 Extends Perk Hidden

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
