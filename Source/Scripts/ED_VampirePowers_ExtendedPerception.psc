Scriptname ED_VampirePowers_ExtendedPerception extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffectWithKeyword(ED_Mechanics_Keywords_TimeDilation)
	if hasME
		ED_Art_SoundM_ExtendedPerception_Off.Play(akTarget)
		akTarget.RemoveSpell(ExtendedPerceptionSpell)
		akTarget.DispelSpell(ED_VampirePowers_Power_Celerity)
	else
	
		akTarget.RemoveSpell(ExtendedPerceptionSpell)      ; its here in case Extended Perception gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(ExtendedPerceptionSpell, false)  ; in that case magic effect ends, but spell is still in players spell list for some reason
		ED_Art_SoundM_ExtendedPerception_Application.Play(akTarget)
	endif
Endevent


SPELL Property ExtendedPerceptionSpell Auto
MagicEffect Property ExtendedPerceptionEffect Auto
spell property ED_VampirePowers_Power_Celerity auto
keyword property ED_Mechanics_Keywords_TimeDilation auto
sound property ED_Art_SoundM_ExtendedPerception_Application auto
sound property ED_Art_SoundM_ExtendedPerception_Off auto


