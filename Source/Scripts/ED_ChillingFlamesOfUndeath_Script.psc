Scriptname ED_ChillingFlamesOfUndeath_Script extends activemagiceffect  

Actor _target
actor _caster
spell property reanimate auto

event oneffectstart(actor akTarget, actor akCaster)
	_caster = akCaster
	_target = akTarget
endevent

Event ondying(actor akKiller)
	utility.wait(utility.RandomFloat(2.5, 4.0))
	reanimate.cast(_caster, _target)
endevent
