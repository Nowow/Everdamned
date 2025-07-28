Scriptname ED_BleedoutOn0HP_Script extends activemagiceffect  

actor _target
actor _caster

Event OnEffectStart(Actor Target, Actor Caster)
	debug.Trace("Everdamned DEBUG: AAAAAAAAAA")
	_target = Target
	_caster = Caster
	
	_caster.PushActorAway(_target, -0.5)
	
	RegisterForSingleUpdate(0.5)
	;Target.PlayIdle(BleedoutStart)
	
endevent

event OnUpdate()
	if _target.IsDead()
		return
	endif
	_caster.PushActorAway(_target, -0.5)
	RegisterForSingleUpdate(0.5)
endevent

