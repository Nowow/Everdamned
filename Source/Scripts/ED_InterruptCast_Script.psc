Scriptname ED_InterruptCast_Script extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	
	Target.InterruptCast()
	RegisterForAnimationEvent(Target, "BeginCastLeft")
	debug.Trace("Everdamned DEBUG: interrupt sent to " + Target)
endevent

event OnAnimationEvent(ObjectReference akSource, string asEventName)
	MAGFail.Play(akSource)
	akSource.InterruptCast()
endevent

sound property MAGFail auto
