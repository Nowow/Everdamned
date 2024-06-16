Scriptname ED_Potence_DeadlyStrengthToggle extends ActiveMagicEffect  

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(DeadlyStrengthEffect)
	if hasME
		debug.notification("Deadly Strength removed!")
		akTarget.RemoveSpell(DeadlyStrengthSpell)
	else
		debug.notification("Deadly Strength added!")
		akTarget.RemoveSpell(DeadlyStrengthSpell)       ; its here in case spell gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(DeadlyStrengthSpell, false)   ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent

SPELL Property DeadlyStrengthSpell Auto
MagicEffect Property DeadlyStrengthEffect Auto
