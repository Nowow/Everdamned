;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 35
Scriptname ED_Perk_VLDevour Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: VL devours from front, paired idle called, rest should be caught with Feed Manager")
akActor.PlayIdleWithTarget(VampireLordLeftPairedFeedFront, akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: VL devours from back, paired idle called, rest should be caught with Feed Manager")
akActor.PlayIdleWithTarget(VampireLordLeftPairedFeedBack, akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: VL devours from back, paired idle called, rest should be caught with Feed Manager")
akActor.PlayIdleWithTarget(VampireLordLeftPairedFeedBack, akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: VL devours from front, paired idle called, rest should be caught with Feed Manager")
akActor.PlayIdleWithTarget(VampireLordLeftPairedFeedFront, akTargetRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property VampireLordLeftPairedFeedFront Auto
Idle Property VampireLordLeftPairedFeedBack Auto
