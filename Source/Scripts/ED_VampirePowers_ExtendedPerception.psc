Scriptname ED_VampirePowers_ExtendedPerception extends activemagiceffect  

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool hasME = akTarget.HasMagicEffect(ExtendedPerceptionEffect)
	if hasME
		debug.notification("Player has effect!")
		akTarget.RemoveSpell(ExtendedPerceptionSpell)
	else
		debug.notification("Player DOES NOT have effect!")
		akTarget.RemoveSpell(ExtendedPerceptionSpell)      ; its here in case Extended Perception gets dispelled by Drain Cleaner effect
		akTarget.AddSpell(ExtendedPerceptionSpell, false)  ; in that case magic effect ends, but spell is still in players spell list for some reason
	endif
Endevent


SPELL Property ExtendedPerceptionSpell Auto
MagicEffect Property ExtendedPerceptionEffect Auto


;Message Property mslVTPwTogOnMSG Auto
;Message Property mslVTPwTogOffMSG Auto