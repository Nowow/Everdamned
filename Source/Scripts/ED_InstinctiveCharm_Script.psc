Scriptname ED_InstinctiveCharm_Script extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	debug.Trace("Everdamned DEBUG: Target: " + Target + ", Caster: " + Caster)
	ED_VampirePowers_InstinctiveCharm_Spell.Cast(Target, Caster)
endevent

spell property ED_VampirePowers_InstinctiveCharm_Spell auto
