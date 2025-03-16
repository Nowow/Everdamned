Scriptname ED_VampiresSight_Toggle_Script extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)

	Bool actPredatorVision = ED_Mechanics_VampireAge.value >= 2  && Input.IsKeyPressed(42)
	
	if !actPredatorVision
	
		if Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect)
			debug.Trace("Everdamned DEBUG: actor " + Caster + " already has ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect effect, Vampires Sight + Predator Vision turn off")
			Caster.removespell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual)
			Caster.removespell(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell)
		else
			debug.Trace("Everdamned DEBUG: actor " + Caster + " does not have ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect effect, Vampires Sight turn on")
			Caster.addspell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual, false)
		endif
	
	else
		if Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect)
			debug.Trace("Everdamned DEBUG: actor " + Caster + " does have ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect effect, Predator Vision turn off")
			Caster.removespell(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell)
		else
			debug.Trace("Everdamned DEBUG: actor " + Caster + " already has ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect effect, Vampires Sight + Predator Vision turn on")
			Caster.addspell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual, false)
			Caster.addspell(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell, false)
		endif
	
	endif
endevent

spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual auto
spell property ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell auto
magiceffect property ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect auto
globalvariable property ED_Mechanics_VampireAge auto
