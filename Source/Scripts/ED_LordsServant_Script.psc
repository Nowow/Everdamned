Scriptname ED_LordsServant_Script extends ActiveMagicEffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Lords Servant hit!")
	if akTarget.IsDead() && !(akTarget.HasKeyword(MagicNoReanimate))
		if akCaster.HasPerk(ED_PerkTreeVL_UndyingLoyalty_Perk) \
		   && ED_Mechanics_Global_UndyingLoyaltyPrimer.GetValue() == 1.0
			debug.Trace("Everdamned DEBUG: Lords Servant casts Undying Loyaly!")
			ED_Mechanics_Global_UndyingLoyaltyPrimer.SetValue(0.0)
			ED_VampireSpellsVL_LordsServant_Spell_UndyingLoyalty.Cast(akCaster, akTarget)
			ED_Art_VFX_LordsServantCharged.Stop(akCaster)
		else
			debug.Trace("Everdamned DEBUG: Lords Servant casts Reanimate!")
			ED_VampireSpellsVL_LordsServant_Spell_Reanimate.Cast(akCaster, akTarget)
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
globalvariable property ED_Mechanics_Global_UndyingLoyaltyPrimer auto
visualeffect property ED_Art_VFX_LordsServantCharged auto 

keyword property MagicNoReanimate auto
