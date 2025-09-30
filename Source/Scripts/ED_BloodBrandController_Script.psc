Scriptname ED_BloodBrandController_Script extends activemagiceffect  


float property XPgained auto

function OnEffectStart(Actor akTarget, Actor akCaster)

	;bool inCombat = akTarget.IsInCombat()
	;debug.Trace("Everdamned DEBUG: Blood Brand in combat " + inCombat)
	;debug.Trace("Everdamned DEBUG: Blood Brand hostile " + isHostileNow)
	
	
	;bool isEnemy = akTarget.GetFactionReaction(akCaster) == 1 
	;debug.Trace("Everdamned DEBUG: Blood Brand isEnemy " + isEnemy)
	;bool notTeammate = !(akTarget.IsPlayerTeammate())
	;debug.Trace("Everdamned DEBUG: Blood Brand notTeammate " + notTeammate)
	
	if akTarget.IsDead()
		akCaster.DoCombatSpellApply(ED_VampireSpells_BloodBrand_Spell_BurnCorpse, akTarget)
		

	elseif akCaster.HasPerk(ED_PerkTree_BloodMagic_65_Transfusion_Perk)
		bool isHostileNow = akTarget.IsHostileToActor(akCaster)
		if isHostileNow || akCaster.IsSneaking()
			akCaster.DoCombatSpellApply(ED_VampireSpells_BloodBrand_Spell_Hostile, akTarget)
		else 
			ED_Art_VFX_Transfusion.Play(akTarget, 5.0, akCaster)
			akCaster.DoCombatSpellApply(ED_VampireSpells_BloodBrand_Spell_NonHostile, akTarget)
		endif
	else
		akCaster.DoCombatSpellApply(ED_VampireSpells_BloodBrand_Spell_Hostile, akTarget)
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)

endFunction


spell property ED_VampireSpells_BloodBrand_Spell_Hostile auto
spell property ED_VampireSpells_BloodBrand_Spell_NonHostile auto
spell property ED_VampireSpells_BloodBrand_Spell_BurnCorpse auto
perk property ED_PerkTree_BloodMagic_65_Transfusion_Perk auto
visualeffect property ED_Art_VFX_Transfusion auto
