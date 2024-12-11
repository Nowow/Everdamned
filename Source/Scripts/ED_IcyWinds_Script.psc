Scriptname ED_IcyWinds_Script extends activemagiceffect  

float property StartOffset Auto

actor _target

function OnEffectStart(Actor akTarget, Actor akCaster)
	_target = akTarget
	RegisterForSingleUpdate(StartOffset)
endfunction

event OnUpdate()
	ED_VampireSpellsVL_IcyWinds_FrostHazard_Spell.Cast(_target)
	RegisterForSingleUpdate(1.0)
endevent


SPELL Property ED_VampireSpellsVL_IcyWinds_FrostHazard_Spell  Auto  
