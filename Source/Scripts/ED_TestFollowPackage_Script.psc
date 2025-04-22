;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname ED_TestFollowPackage_Script Extends Package Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: Test pacakge CHANGED")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: Test pacakge ENDED")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(Actor akActor)
;BEGIN CODE
debug.trace("Everdamned DEBUG: Test pacakge STARTED")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property IdleMesmerize  Auto  

Idle Property IdleMesmerizeStop  Auto  
