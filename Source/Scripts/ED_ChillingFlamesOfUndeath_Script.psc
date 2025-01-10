Scriptname ED_ChillingFlamesOfUndeath_Script extends activemagiceffect  

Actor _target
actor _caster
spell property ED_ColdFlame_ConjureAtronach_Spell auto
effectshader property ED_Art_Shader_ColdFlameBodyPyreDisintegrate2 auto
effectshader property ED_Art_Shader_ColdFlameAtronachFlameDeath auto

event oneffectstart(actor akTarget, actor akCaster)
	_caster = akCaster
	_target = akTarget
endevent

Event ondying(actor akKiller)
	ED_Art_Shader_ColdFlameAtronachFlameDeath.Play(_target)
	utility.wait(utility.RandomFloat(3.0, 5.0))
	ED_Art_Shader_ColdFlameBodyPyreDisintegrate2.Play(_target)
	utility.wait(2.0)
	_target.SetCriticalStage(_target.CritStage_DisintegrateStart)
	_caster.DoCombatSpellApply(ED_ColdFlame_ConjureAtronach_Spell, _target)
	_target.SetCriticalStage(_target.CritStage_DisintegrateEnd)

endevent
