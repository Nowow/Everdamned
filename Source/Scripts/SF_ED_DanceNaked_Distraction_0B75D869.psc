;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SF_ED_DanceNaked_Distraction_0B75D869 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
actor __sceneTarget = SceneTargetAlias.GetReference() as actor
ED_Mechanics_VampiresCommandImmunity_Spell.Cast(__sceneTarget, __sceneTarget)

int bodySlot = 0x00000004
armor bodyArmor = __sceneTarget.GetWornForm(bodySlot) as armor
debug.Trace("Everdamne DEBUG: Armor piece got from Maniacal Laughterer: " + bodyArmor)
ED_Mechanics_FormList_DanceNakedArmorCache.AddForm(bodyArmor)
__sceneTarget.UnequipItem(bodyArmor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Naked Dance Scene ended!!")
actor __sceneTarget = SceneTargetAlias.GetReference() as actor

Form bodyArmor = ED_Mechanics_FormList_DanceNakedArmorCache.GetAt(0)
ED_Mechanics_FormList_DanceNakedArmorCache.Revert()
debug.Trace("Everdamne DEBUG: Armor piece got from Armor Cache: " + bodyArmor)

If (bodyArmor && !(__sceneTarget.IsDead()) && __sceneTarget.GetItemCount(bodyArmor) >= 1)
	__sceneTarget.EquipItem(bodyArmor, false, false)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property SceneTargetAlias  Auto  

SPELL Property ED_Mechanics_VampiresCommandImmunity_Spell  Auto

FormList Property ED_Mechanics_FormList_DanceNakedArmorCache  Auto  

ReferenceAlias Property ED_ArmorCache  Auto  
