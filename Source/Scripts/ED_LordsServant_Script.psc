Scriptname ED_LordsServant_Script extends ActiveMagicEffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Lords Servant hit!")
	if akTarget.IsDead() && !(akTarget.HasKeyword(MagicNoReanimate))
		if akCaster.HasPerk(ED_PerkTreeVL_UndyingLoyalty_Perk)
			debug.Trace("Everdamned DEBUG: Lords Servant casts Undying Loyaly!")
			ED_VampireSpellsVL_LordsServant_Spell_UndyingLoyalty.Cast(akCaster, akTarget) 
			Game.AdvanceSkill("Conjuration", 200.0)
		else
			debug.Trace("Everdamned DEBUG: Lords Servant casts Reanimate!")
			ED_VampireSpellsVL_LordsServant_Spell_Reanimate.Cast(akCaster, akTarget)
			Game.AdvanceSkill("Conjuration", 200.0)
		endif
	else
		debug.Trace("Everdamned DEBUG: Lords Servant casts Command Undead!")
		ED_VampireSpellsVL_LordsServant_Spell_CommandUndead.Cast(akCaster, akTarget)
	endif
	
endevent

perk property ED_PerkTreeVL_UndyingLoyalty_Perk auto
spell property ED_VampireSpellsVL_LordsServant_Spell_Reanimate auto
spell property ED_VampireSpellsVL_LordsServant_Spell_CommandUndead auto
spell property ED_VampireSpellsVL_LordsServant_Spell_UndyingLoyalty auto

keyword property MagicNoReanimate auto
