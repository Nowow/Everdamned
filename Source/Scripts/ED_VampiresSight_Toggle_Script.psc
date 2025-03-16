Scriptname ED_VampiresSight_Toggle_Script extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)
	if Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect)
		debug.Trace("Everdamned DEBUG: actor " + Caster + " already has ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect effect, Vampires Sight turn off")
		Caster.removespell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual)
	else
		debug.Trace("Everdamned DEBUG: actor " + Caster + " does not have ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect effect, Vampires Sight turn on")
		Caster.addspell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual, false)
	endif
endevent

spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual auto
magiceffect property ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect auto
