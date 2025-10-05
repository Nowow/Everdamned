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
		if ED_Mechanics_SkillTree_Level_Global.GetValue() >= akTarget.GetLevel()
			if akCaster.GetActorValue("ED_BloodPool") >= 100.0
				debug.Trace("Everdamned DEBUG: Lords Servant casts Command Undead!")
				ED_VampireSpellsVL_LordsServant_Spell_CommandUndead.Cast(akCaster, akTarget)
				akCaster.DamageActorValue("ED_BloodPool", 100.0)
			else
				ED_Mechanics_Message_NotEnoughBloodPoints.Show()
			endif
		else
			; is too powerful to be subjugated.
			debug.Notification(akTarget.GetActorBase().GetName() + " is too powerful to be subjugated.")
		endif
	endif
	
endevent

perk property ED_PerkTreeVL_UndyingLoyalty_Perk auto
spell property ED_VampireSpellsVL_LordsServant_Spell_Reanimate auto
spell property ED_VampireSpellsVL_LordsServant_Spell_CommandUndead auto
spell property ED_VampireSpellsVL_LordsServant_Spell_UndyingLoyalty auto
globalvariable property ED_Mechanics_Global_UndyingLoyaltyPrimer auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto
visualeffect property ED_Art_VFX_LordsServantCharged auto 
message property ED_Mechanics_Message_NotEnoughBloodPoints auto

keyword property MagicNoReanimate auto
