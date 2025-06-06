Scriptname ED_ShamblingHordesVL_Script extends activemagiceffect  

spell property ED_VampireSpellsVL_ShamblingHordes_Reanimate_Spell auto

float property offsetMin auto
float property offsetMax auto
float property XPgained auto


float _offset
function OnEffectStart(Actor akTarget, Actor akCaster)
	_offset = utility.RandomFloat(offsetMin, offsetMax)
	debug.Trace("Shambling Horde Raise by " + akCaster + " on " + akTarget + " is offset by " + _offset)
	utility.wait(_offset)
	akCaster.DoCombatSpellApply(ED_VampireSpellsVL_ShamblingHordes_Reanimate_Spell, akTarget)
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
endFunction
