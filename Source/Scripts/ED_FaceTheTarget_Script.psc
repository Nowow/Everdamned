Scriptname ED_FaceTheTarget_Script extends activemagiceffect  

actor _target
actor _caster
event OnEffectStart(Actor Target, Actor Caster)
	debug.Trace("Everdamned DEBUG: Face The Target effect started! On: " + Target)
	_target = Target
	_caster = Caster
	
	float headingAngle = _target.GetHeadingAngle(_caster)
	debug.Trace("Everdamned DEBUG: Face The Target heading angle: " + headingAngle)
	
	if headingAngle < -135.0
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnLeft180")
		debug.Trace("Everdamned DEBUG: Face The Target LEFT 180")
	elseif headingAngle >= -135.0 && headingAngle <= -60.0
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnLeft90")
		debug.Trace("Everdamned DEBUG: Face The Target LEFT 90")
	elseif headingAngle <= 60.0 && headingAngle >= 135.0
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnRight90")
		debug.Trace("Everdamned DEBUG: Face The Target RIGHT 90")
	else
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnRight180")
		debug.Trace("Everdamned DEBUG: Face The Target RIGHT 180")
	endif
	
	RegisterForSingleUpdate(4.0)
		
endevent

event OnUpdate()
	if !_target
		return
	endif
	
	float headingAngle = _target.GetHeadingAngle(_caster)
	debug.Trace("Everdamned DEBUG: Face The Target heading angle: " + headingAngle)
	
	if headingAngle < -135.0
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnLeft180")
		debug.Trace("Everdamned DEBUG: Face The Target LEFT 180")
	elseif headingAngle >= -135.0 && headingAngle <= -60.0
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnLeft90")
		debug.Trace("Everdamned DEBUG: Face The Target LEFT 90")
	elseif headingAngle <= 60.0 && headingAngle >= 135.0
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnRight90")
		debug.Trace("Everdamned DEBUG: Face The Target RIGHT 90")
	else
		_target.PlayIdle(ResetRoot)
		debug.SendAnimationEvent(_target, "NPC_TurnRight180")
		debug.Trace("Everdamned DEBUG: Face The Target RIGHT 180")
	endif
	
	RegisterForSingleUpdate(4.0)
	
endevent

event OnEffectFinish(Actor Target, Actor Caster)
	_target = None
endevent
idle property ResetRoot auto
