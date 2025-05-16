Scriptname ED_NecroticFleshSlow_Script extends ActiveMagicEffect  


bool __isSprintOK
Event OnEffectStart(Actor akTarget, Actor akCaster)
	__isSprintOK = akTarget.GetAnimationVariableBool("bSprintOK")
		
	akTarget.SetAnimationVariableBool("bSprintOK", false)
	input.TapKey(input.GetMappedKey("Sprint"))
	
Endevent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.SetAnimationVariableBool("bSprintOK", __isSprintOK)
Endevent

