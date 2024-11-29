Scriptname ED_BloodVortexAlias_Script extends ReferenceAlias  

int property ActorsDied auto
int property VictimsNeededToTransform auto

function IncrementActorsDied()
	;single threaded because not external call
	ActorsDied = ActorsDied + 1
	if ActorsDied >= VictimsNeededToTransform
		debug.Trace("Everdamned DEBUG: Blood Vortex is transforming")
		TransformToProfanedSun()
	endif
endfunction

function FillVortex(objectreference _vortex)
	ActorsDied = 0
	self.ForceRefTo(_vortex)	
endfunction

function TransformToProfanedSun()
	objectreference _vortexT = self.GetReference()
	self.Clear()
	ED_VampireSpells_ProfanedSun_Spell.Cast(self.GetReference(), playerRef)
	_vortexT.disable(true)
	_vortexT.Delete()
endfunction

function TerminateVortex(objectreference _vortexToTerminate)
	_currentVortex = self.GetReference()
	if _currentVortex && _currentVortex == _vortexToTerminate
		debug.Trace("Everdamned DEBUG: Blood Vortex lifetime has came to an end without transformation, terminating")
		_currentVortex.disable(true)
		_currentVortex.Delete()
	else
		debug.Trace("Everdamned DEBUG: Blood Vortex lifetime has came to an end, but it had either transformed or gone missing before magic effect expired")
	endif
	
endfunction

actor property playerRef auto
spell property ED_VampireSpells_ProfanedSun_Spell auto
