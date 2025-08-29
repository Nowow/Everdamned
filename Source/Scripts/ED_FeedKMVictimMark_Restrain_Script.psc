Scriptname ED_FeedKMVictimMark_Restrain_Script extends activemagiceffect  


actor __target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Feed Victim Mark RESTRAIN effect started, which means target was NOT restrained")
	__target = akTarget
	__target.SetRestrained(true)
endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	__target.SetRestrained(false)
	debug.Trace("Everdamned DEBUG: Feed Victim Mark RESTRAIN effect ended!")
endevent


