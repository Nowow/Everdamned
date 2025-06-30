Scriptname ED_ApplyEatenOnDeath_Script extends activemagiceffect  


actor __target
actor __caster


Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: HasBeenEaten trigger WAS CAST! Target is alive: " + akTarget.IsDead())
	__target = akTarget
	__caster = akCaster
endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: HasBeenEaten trigger on death triggered")
	ED_FeralBeast_ApplyHasBeenEaten_Spell.Cast(__caster, __target)
	debug.Trace("Everdamned DEBUG: HasBeenEaten trigger on death spell casted at " + __caster + " " + __target)
endevent


spell property ED_FeralBeast_ApplyHasBeenEaten_Spell auto
