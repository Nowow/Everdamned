;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PRKF_ED_Mechanics_Perk_Blood_040B87E4 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
akActor.PlayIdleWithTarget(pa_WereWolf_CutWrist, akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property pa_WereWolf_CutWrist  Auto  
