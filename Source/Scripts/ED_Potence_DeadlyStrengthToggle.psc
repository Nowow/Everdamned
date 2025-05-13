Scriptname ED_Potence_DeadlyStrengthToggle extends ActiveMagicEffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(DeadlyStrengthEffect)
	if hasME
		; TODO: redo with messages
		debug.notification("Unnatural strength fades, leaving you drained...")
		akTarget.RemoveSpell(DeadlyStrengthSpell)
		akTarget.RemoveSpell(ED_VampirePowers_Power_DeadlyStrength_JumpBonus_Spell)
	else
		debug.notification("Dark power of blood surges through your veins!")
		akTarget.RemoveSpell(DeadlyStrengthSpell)       ; its here in case spell gets dispelled by Drain Cleaner effect
		akTarget.RemoveSpell(ED_VampirePowers_Power_DeadlyStrength_JumpBonus_Spell)
		akTarget.AddSpell(DeadlyStrengthSpell, false)   ; in that case magic effect ends, but spell is still in players spell list for some reason
		akTarget.AddSpell(ED_VampirePowers_Power_DeadlyStrength_JumpBonus_Spell, false)
	endif
Endevent

SPELL Property DeadlyStrengthSpell Auto
spell property ED_VampirePowers_Power_DeadlyStrength_JumpBonus_Spell auto
MagicEffect Property DeadlyStrengthEffect Auto
