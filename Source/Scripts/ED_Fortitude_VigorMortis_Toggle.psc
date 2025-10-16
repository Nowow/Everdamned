Scriptname ED_Fortitude_VigorMortis_Toggle extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(VigorMortisEffect)
	if hasME
		akTarget.RemoveSpell(VigorMortisSpell)
		ED_Art_SoundM_VigorMortisOff.Play(akTarget)
	else
		akTarget.RemoveSpell(VigorMortisSpell)       ; its here in case spell gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(VigorMortisSpell, true)   ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent

SPELL Property VigorMortisSpell Auto
MagicEffect Property VigorMortisEffect Auto
sound property ED_Art_SoundM_VigorMortisOff auto
