Scriptname ED_InterruptVampDrainDouble_Script extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)
	utility.wait(0.2)
	Target.InterruptCast()
	ED_Misc_Spell_StaggerSelfWeak_Spell.Cast(Target)
	debug.Trace("Everdamned DEBUG: Staggering for illegal use of Vamp Drain")
endevent

spell property ED_Misc_Spell_StaggerSelfWeak_Spell auto
