Scriptname ED_ChillingFlamesOfUndeath_Script extends activemagiceffect  

Actor _target
actor _caster

bool __doneDid
event oneffectstart(actor akTarget, actor akCaster)
	
	
	if akTarget.IsDead() && !__doneDid
		__doneDid = true
		debug.Trace("Everdamned DEBUG: Flames of Coldharbour proc script started!")
		ED_VampireSpellsVL_ChillingFlamesofUndeath_Proc_Spell.Cast(akCaster, akTarget)
		
		dispel()
	else
		_caster = akCaster
		_target = akTarget
	endif

endevent

Event ondying(actor akKiller)
	if !__doneDid
		__doneDid = true
		ED_VampireSpellsVL_ChillingFlamesofUndeath_Proc_Spell.Cast(_caster, _target)
	endif
endevent


spell property ED_VampireSpellsVL_ChillingFlamesofUndeath_Proc_Spell auto
hazard property ED_Art_Hazard_ColdFlamePyre auto
