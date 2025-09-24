Scriptname ED_IcyWinds_Script extends activemagiceffect  

float property StartOffset Auto
float property SpawnRate Auto
float property ReleaseChargeTime Auto

actor _target

function OnEffectStart(Actor akTarget, Actor akCaster)
	_target = akTarget
	RegisterForSingleUpdate(StartOffset)
endfunction

event OnUpdate()
	;Debug.Trace("ED_IcyWindsSelf actor value: " + _target.getactorvalue("ED_IcyWindsSelf"))
	ED_VampireSpellsVL_IcyWinds_FrostHazard_Spell.Cast(_target)
	RegisterForSingleUpdate(SpawnRate)
endevent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	
	if akTarget.GetActorValue("ED_IcyWindsSelf") <= ReleaseChargeTime
		akTarget.DoCombatSpellApply(ED_VampireSpellsVL_IcyWinds_Release_Spell, akTarget)
		;ED_VampireSpellsVL_IcyWinds_Release_Spell.Cast(akTarget)
	endif 
	
	_target.restoreactorvalue("ED_IcyWindsSelf", 9999.0)
endfunction


SPELL Property ED_VampireSpellsVL_IcyWinds_FrostHazard_Spell  Auto  
SPELL Property ED_VampireSpellsVL_IcyWinds_Release_Spell  Auto  
