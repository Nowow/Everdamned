Scriptname ED_BloodSense_Toggle_Script extends ActiveMagicEffect  


Event OnEffectStart(Actor Target, Actor Caster)
	bool __hasSightME = Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect)
	bool __hasPVME = Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Effect_Far)

	if __hasPVME
		Target.removespell(ED_BeingVampire_Vanilla_Pw_BloodSense_Spell)
		debug.Trace("Everdamned DEBUG: Blood Sense toggle removes Blood Sense")
	else
		if __hasSightME
			Target.RemoveSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual)
			debug.Trace("Everdamned DEBUG: Blood Sense toggle removed Vampires Sight")
		endif
		Target.addspell(ED_BeingVampire_Vanilla_Pw_BloodSense_Spell)
		debug.Trace("Everdamned DEBUG: Blood Sense toggle adds Blood Sense")
	endif
	
endevent


spell property ED_BeingVampire_Vanilla_Pw_BloodSense_Spell auto
spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual auto
magiceffect property ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Effect_Far auto
magiceffect property ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect auto
