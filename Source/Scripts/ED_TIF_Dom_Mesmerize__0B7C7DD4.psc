;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_TIF_Dom_Mesmerize__0B7C7DD4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor currentTarget = ED_Target.GetReference() as actor
if currentTarget
	Int i = 0
	int __size = ED_Mechanics_Dominate_SceneControllers_FormList.GetSize()
	while i < __size
		currentTarget.DispelSpell(ED_Mechanics_Dominate_SceneControllers_FormList.GetAt(i) as spell)
		i += 1
	endWhile
endIf
ED_Target.ForceRefTo(akSpeaker)

objectreference __activator = akSpeaker.PlaceAtMe(FXEmptyActivator)

;float zOffset  = __activator.GetHeadingAngle(akSpeaker)
;__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activator.GetAngleZ() + zOffset)

while !(__activator.Is3DLoaded())
	debug.Trace("Everdamned DEBUG: FXEmptyActivator 3d is not yet loaded!")
	utility.wait(0.1)
endwhile

float __activatorAngleZ = __activator.GetAngleZ()
__activator.MoveTo(akSpeaker, 10.0*math.sin(__activatorAngleZ), 10.0*math.cos(__activatorAngleZ), 50.0)
__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activatorAngleZ + 180.0)


ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell.RemoteCast(__activator, playerRef, akSpeaker)
__activator.Delete()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

actor property playerRef Auto

referencealias property ED_Target auto

SPELL Property ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell  Auto

formlist property ED_Mechanics_Dominate_SceneControllers_FormList auto


Activator Property FXEmptyActivator  Auto  
