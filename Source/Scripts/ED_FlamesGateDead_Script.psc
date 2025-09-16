Scriptname ED_FlamesGateDead_Script extends activemagiceffect  

actor _target
event oneffectstart(actor akTarget, actor akCaster)
	_target = akTarget
	debug.Trace("Everdamned DEBUG: Dead Gate started")
	akTarget.DamageActorValue("ED_FlamesProc", 1.0)
	RegisterForSingleUpdate(0.9)
endevent

event OnUpdate()
	_target.DamageActorValue("ED_FlamesProc", 1.0)
	RegisterForSingleUpdate(0.9)
	debug.Trace("Everdamned DEBUG: Dead Gate updated")
endevent
