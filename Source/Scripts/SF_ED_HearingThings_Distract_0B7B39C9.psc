;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ED_HearingThings_Distract_0B7B39C9 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Hearing Things scene ended")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
actor __sceneTarget = SceneTargetAlias.GetReference() as actor
ED_Mechanics_VampiresCommandImmunity_Spell.Cast(__sceneTarget, __sceneTarget)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property SceneTargetAlias  Auto  

SPELL Property ED_Mechanics_VampiresCommandImmunity_Spell  Auto
