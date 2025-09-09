Scriptname ED_MarchOfUndeathTarget_Script extends activemagiceffect  

spell property ED_VampireSpellsVL_MarchOfUndeath_UnholyStrength_Spell auto

actor _target
actor _caster 

function OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Marching Flesh target effect started on target: " + akTarget)
	_target = akTarget
	_caster = akCaster
	RegisterForSingleUpdate(4.0)
endFunction

event OnUpdate()

	string _modEventName = "ed_RefreshCommandEffect" + _target.GetFormID() as string
	debug.Trace("Everdamned DEBUG: Mod event " + _modEventName + " sent!")
	
	SendModEvent(_modEventName)
	_caster.DoCombatSpellApply(ED_VampireSpellsVL_MarchOfUndeath_UnholyStrength_Spell, _target)
endevent

;function OnEffectFinish(Actor akTarget, Actor akCaster)
;	debug.Trace("Marching Flesh target effect finished on target: " + akTarget)
;endFunction
