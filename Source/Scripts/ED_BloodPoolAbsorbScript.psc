Scriptname ED_BloodPoolAbsorbScript extends activemagiceffect  

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Blood Pool absort effect started!")
	debug.Notification("Blood Pool absort effect started!")
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.Trace("Blood Pool absort effect finished!")
	debug.Notification("Blood Pool absort effect finished!")
Endevent
