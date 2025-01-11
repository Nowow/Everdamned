Scriptname ED_ChillingFlamesOfUndeath_Script extends activemagiceffect  

Actor _target
actor _caster

spell property ED_VampireSpellsVL_ChillingFlamesofUndeath_Proc_Spell auto

event oneffectstart(actor akTarget, actor akCaster)
	_caster = akCaster
	_target = akTarget
endevent

Event ondying(actor akKiller)
	ED_VampireSpellsVL_ChillingFlamesofUndeath_Proc_Spell.Cast(_caster, _target)
endevent
