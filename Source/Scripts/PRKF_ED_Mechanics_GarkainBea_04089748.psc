;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
Scriptname PRKF_ED_Mechanics_GarkainBea_04089748 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
debug.trace("EVERDAMNED: GARKAIN: PIKACHU, BRUTALIZE!")
akActor.PlayIdleWithTarget(WerewolfKillmove, akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property WerewolfKillmove Auto