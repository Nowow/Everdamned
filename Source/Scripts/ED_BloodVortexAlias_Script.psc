Scriptname ED_BloodVortexAlias_Script extends ReferenceAlias  

int property ActorsDied auto
int property VictimsNeededToTransform auto

float property BirthX auto
float property BirthY auto
float property BirthZ auto

objectreference property TransformingVortex auto

function IncrementActorsDied()
	;single threaded because not external call
	debug.Trace("Everdamned DEBUG: Blood Vortex IncrementActorsDied() called")
	ActorsDied = ActorsDied + 1
	if ActorsDied >= VictimsNeededToTransform
		debug.Trace("Everdamned DEBUG: Blood Vortex is transforming")
		TransformToProfanedSun()
	endif
endfunction

function FillVortex(objectreference _vortex)
	ActorsDied = 0
	objectreference _currentVortex = self.getreference()
	self.ForceRefTo(_vortex)
	if _currentVortex && !(_currentVortex.IsDeleted())
		debug.Trace("Everdamned ERROR: FillVortex called while referene was still filled, terminating previous vortex")
		_currentVortex.disable(true)
		_currentVortex.Delete()
	endif
endfunction

function TransformToProfanedSun()
	TransformingVortex = self.GetReference()
	objectreference _vt = TransformingVortex
	self.Clear()
	ED_VampireSpells_ProfanedSun_Spell.Cast(playerRef)
	_vt.disable(true)
	utility.wait(2.0)
	_vt.Delete()
	_vt = none
endfunction

function TerminateVortex(objectreference _vortexToTerminate)
	objectreference _currentVortex = self.GetReference()
	if _currentVortex && _currentVortex == _vortexToTerminate
		debug.Trace("Everdamned DEBUG: Blood Vortex lifetime has came to an end without transformation, terminating")
		self.clear()
		_currentVortex.disable(true)
		_currentVortex.Delete()
	else
		debug.Trace("Everdamned DEBUG: Blood Vortex lifetime has came to an end, but it had either transformed or gone missing before magic effect expired")
	endif
	
endfunction

actor property playerRef auto
spell property ED_VampireSpells_ProfanedSun_Spell auto
