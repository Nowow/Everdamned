;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname PRKF_ED_Mechanics_Perk_Activ_0BE53CC3 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
akTargetRef.placeatme(ED_Art_Activator_ColdFlameBanishFX)
(akTargetRef as actor).kill(akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_Mechanics_Quest_RoyalGuardian.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(akTargetRef as actor).kill(akActor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Activator Property ED_Art_Activator_ColdFlameBanishFX  Auto  

Quest Property ED_Mechanics_Quest_RoyalGuardian  Auto  
