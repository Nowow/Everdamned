Scriptname ED_GarkainBeast_BrutalizeSpell extends activemagiceffect  

Idle Property WerewolfKillmove  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.trace("PIKACHU, BRUTALIZE!")
	akCaster.PlayIdleWithTarget(WerewolfKillmove, akTarget as Actor)
EndEvent

