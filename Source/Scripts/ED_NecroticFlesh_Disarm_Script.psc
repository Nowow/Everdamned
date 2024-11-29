Scriptname ED_NecroticFlesh_Disarm_Script extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	debuG.Trace("Disarm effect fire")
	debug.Trace("Target: " + akTarget + ", caster: " + akCaster)
	DisarmSpell.cast(akTarget, akCaster)
Endevent


SPELL Property DisarmSpell Auto
