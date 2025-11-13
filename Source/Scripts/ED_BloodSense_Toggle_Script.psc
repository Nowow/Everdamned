Scriptname ED_BloodSense_Toggle_Script extends ActiveMagicEffect  


Event OnEffectStart(Actor Target, Actor Caster)
	bool __hasSightME = Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect)
	bool __hasPVME = Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Effect_Far)

	if __hasPVME
		Target.removespell(ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Spell)
		debug.Trace("Everdamned DEBUG: Blood Sense toggle removes Blood Sense")
		if __hasSightME
			Target.removeSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual)
			debug.Trace("Everdamned DEBUG: Blood Sense toggle removes Vampires Sight")
		endif
	elseif Target.GetActorValue("ED_BloodPool") > 1
		if !__hasSightME
			Target.AddSpell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual, false)
			debug.Trace("Everdamned DEBUG: Blood Sense toggle adds Vampires Sight")
		endif
		Target.addspell(ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Spell, false)
		debug.Trace("Everdamned DEBUG: Blood Sense toggle adds Blood Sense")
	else
		MAGFail.Play(Target)
		ED_Mechanics_Message_PowerCantBeUsed.Show()
	endif
	
endevent


spell property ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Spell auto
spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual auto

magiceffect property ED_BeingVampire_Vanilla_Pw_BloodSense_Cloak_Effect_Far auto
magiceffect property ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect auto

sound property MAGFail auto
message property ED_Mechanics_Message_PowerCantBeUsed auto

