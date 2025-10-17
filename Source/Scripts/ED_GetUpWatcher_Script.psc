Scriptname ED_GetUpWatcher_Script extends ActiveMagicEffect  

actor _target
Event OnEffectStart(Actor Target, Actor Caster)
	_target = Target
	RegisterForAnimationEvent(Target, "GetUp")
	RegisterForAnimationEvent(Target, "GetUpStart")
	debug.Trace("Everdamned DEBUG: Get Up watcher registed!")
endevent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	debug.SendAnimationEvent(_target, "Ragdoll")
	debug.Trace("Everdamned DEBUG: Got get up event! " + asEventName)
	;utility.wait(0.1)
	
endevent

Event OnEffectFinish(Actor Target, Actor Caster)

	debug.Trace("Everdamned DEBUG: Get Up watcher finished!")
endevent
