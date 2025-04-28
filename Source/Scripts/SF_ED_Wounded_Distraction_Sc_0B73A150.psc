;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ED_Wounded_Distraction_Sc_0B73A150 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
actor __sceneTarget = SceneTargetAlias.GetReference() as actor
ED_Mechanics_VampiresCommandImmunity_Spell.Cast(__sceneTarget, __sceneTarget)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property SceneTargetAlias  Auto  

SPELL Property ED_Mechanics_VampiresCommandImmunity_Spell  Auto  
