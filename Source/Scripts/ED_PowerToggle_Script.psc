Scriptname ED_PowerToggle_Script extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(PowerActualEffect)
	if hasME
		debug.Trace("ME IS!")
		akTarget.RemoveSpell(PowerAbility)
	else
		debug.Trace("ME ISNT!")
		akTarget.RemoveSpell(PowerAbility)       ; its here in case spell gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(PowerAbility, false)   ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent

SPELL Property PowerAbility Auto
MagicEffect Property PowerActualEffect Auto
