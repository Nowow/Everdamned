Scriptname ED_Fortitude_VigorMortis_Toggle extends activemagiceffect  

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(VigorMortisEffect)
	if hasME
		debug.notification("Vigor Mortis removed!")
		akTarget.RemoveSpell(VigorMortisSpell)
	else
		debug.notification("Vigor Mortis added!")
		akTarget.RemoveSpell(VigorMortisSpell)       ; its here in case spell gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(VigorMortisSpell, false)   ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent

SPELL Property VigorMortisSpell Auto
MagicEffect Property VigorMortisEffect Auto
