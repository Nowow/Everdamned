Scriptname ED_VampirePowers_ExtendedPerception extends activemagiceffect  

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffectWithKeyword(ED_Mechanics_Keywords_TimeDilation)
	if hasME
		debug.Trace("Everdamned DEBUG: Extended Perception ends")
		akTarget.RemoveSpell(ExtendedPerceptionSpell)
		akTarget.DispelSpell(ED_VampirePowers_Power_Celerity)
	else
		debug.notification("Everdamned DEBUG: Extended Perception starts")
		akTarget.RemoveSpell(ExtendedPerceptionSpell)      ; its here in case Extended Perception gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(ExtendedPerceptionSpell, false)  ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent


SPELL Property ExtendedPerceptionSpell Auto
MagicEffect Property ExtendedPerceptionEffect Auto
spell property ED_VampirePowers_Power_Celerity auto
keyword property ED_Mechanics_Keywords_TimeDilation auto

;Message Property mslVTPwTogOnMSG Auto
;Message Property mslVTPwTogOffMSG Auto