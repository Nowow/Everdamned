Scriptname ED_HearingThings_Script extends activemagiceffect  


bool __finishing
actor __target

objectreference __aimTarget
objectreference __castingSource


Event OnEffectStart(Actor Target, Actor Caster)
	__target = Target
	RegisterForSingleUpdate(utility.randomfloat(2.0,5.0))
	
EndEvent

event OnUpdate()
	if !__finishing
		
		;debug.Trace("Everdamned DEBUG: Hearing Things update")
		;__target.placeatme(ED_Misc_Activator_ThrowVoiceSource)
		
		__aimTarget = __target.placeatme(FXEmptyActivator)
		__castingSource = __target.placeatme(FXEmptyActivator)
	
		float __height = __target.GetHeight() + 20
		;debug.Trace("Everdamned DEBUG: Hearing Things height is: " + __height)
		
		__castingSource.moveto(__target, 0, 0, __height)
		__aimTarget.moveto(__target, utility.randomint(-100, 100) as float, utility.randomint(-100, 100) as float, __height)
		ED_Mechanics_VoiceThrowAimed_Spell.RemoteCast(__castingSource, playerRef, __aimTarget)
		
		__castingSource.Delete()
		__aimTarget.Delete()
		__castingSource = None
		__aimTarget = None
		
		RegisterForSingleUpdate(utility.randomfloat(2.0,5.0))

	endif

endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	__finishing = true
EndEvent

actor property playerRef auto
;activator property ED_Misc_Activator_ThrowVoiceSource auto
activator property FXEmptyActivator auto
spell property ED_Mechanics_VoiceThrowAimed_Spell auto
