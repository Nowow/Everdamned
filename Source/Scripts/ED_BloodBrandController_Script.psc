Scriptname ED_BloodBrandController_Script extends activemagiceffect  


float property XPgained auto

function OnEffectStart(Actor akTarget, Actor akCaster)

	bool isHostileNow = akTarget.IsHostileToActor(akCaster)
	;debug.Trace("Everdamned DEBUG: hostile " + isHostileNow)
	bool isEnemy = akTarget.GetFactionReaction(akCaster) == 1
	;debug.Trace("Everdamned DEBUG: isEnemy " + isEnemy)
	bool notTeammate = !(akTarget.IsPlayerTeammate())
	;debug.Trace("Everdamned DEBUG: notTeammate " + notTeammate)
	
	if (isHostileNow || isEnemy) && notTeammate
		akCaster.DoCombatSpellApply(ED_VampireSpells_BloodBrand_Spell_Hostile, akTarget)
	else
		akCaster.DoCombatSpellApply(ED_VampireSpells_BloodBrand_Spell_NonHostile, akTarget)
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)

endFunction


spell property ED_VampireSpells_BloodBrand_Spell_Hostile auto
spell property ED_VampireSpells_BloodBrand_Spell_NonHostile auto
