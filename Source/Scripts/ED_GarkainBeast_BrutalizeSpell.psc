Scriptname ED_GarkainBeast_BrutalizeSpell extends activemagiceffect  

Idle Property WerewolfKillmove Auto
Spell Property ApplyEatenSpell Auto  

;Event OnEffectStart(Actor akTarget, Actor akCaster)
;	debug.trace("PIKACHU, BRUTALIZE!")
;	akCaster.PlayIdleWithTarget(WerewolfKillmove, akTarget as Actor)
;EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if akTarget.IsDead()
		ApplyEatenSpell.Cast(akTarget, akTarget as Actor)
	endif
EndEvent