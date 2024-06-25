Scriptname ED_Potence_DeadlyStrengthToggle extends ActiveMagicEffect  

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(DeadlyStrengthEffect)
	if hasME
		debug.notification("Unnatural strength fades, leaving you drained...")
		akTarget.RemoveSpell(DeadlyStrengthSpell)
	else
		debug.notification("Dark power of blood surges through your veins!")
		akTarget.RemoveSpell(DeadlyStrengthSpell)       ; its here in case spell gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(DeadlyStrengthSpell, false)   ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent

SPELL Property DeadlyStrengthSpell Auto
MagicEffect Property DeadlyStrengthEffect Auto
