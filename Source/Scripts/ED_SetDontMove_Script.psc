Scriptname ED_SetDontMove_Script extends activemagiceffect  

actor __target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	akTarget.SetDontMove(true)
	__target = akTarget
	debug.Trace("Everdamned DEBUG: Set Dont Move spell started")
endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	
	__target.SetDontMove(false)
	__target.DispelSpell(ED_Mechanics_Spell_SetDontMove)
	debug.Trace("Everdamned DEBUG: Set Dont Move spell ended")
endevent

spell property ED_Mechanics_Spell_SetDontMove auto
