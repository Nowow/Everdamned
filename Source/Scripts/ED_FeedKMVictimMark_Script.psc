Scriptname ED_FeedKMVictimMark_Script extends activemagiceffect  


actor __target

bool __wasNotGhost

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Feed Victim Mark effect started!")
	__target = akTarget
	
	__wasNotGhost = !(__target.IsGhost())
	if __wasNotGhost
		__target.SetGhost(true)
	else
		debug.Trace("Everdamned WARNING: Feed Victim Mark WILL NOT set Ghost, because victim was already Ghost!")
	endif

endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	
	if __target && !(__target.IsDead())
		debug.Trace("Everdamned DEBUG: Feed Victim Mark detects that target is not dead! WELP")
	endif

	if __wasNotGhost
		__target.SetGhost(false)
	endif
	
	debug.Trace("Everdamned DEBUG: Feed Victim Mark effect finished!")
endevent
