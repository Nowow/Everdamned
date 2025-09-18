Scriptname ED_ChainedBeastAlias_Script extends ReferenceAlias  

; all of this script is just for precaution
event OnEnterBleedout()
	debug.Trace("Everdamned DEBUG: Chained Beast quest alias detected going into bleedout, stopping quest")
	GetOwningQuest().SetCurrentStageID(100)
endevent

event OnDying(Actor akKiller)
	debug.Trace("Everdamned DEBUG: Chained Beast quest alias detected DYING, stopping quest")
	GetOwningQuest().SetCurrentStageID(100)
endevent
	