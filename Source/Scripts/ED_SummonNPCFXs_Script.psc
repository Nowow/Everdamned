Scriptname ED_SummonNPCFXs_Script extends ObjectReference  

EVENT onDying(actor myKiller)

	AtronachUnsummonDeathFXS.Play(self)

ENDEVENT

effectshader property AtronachUnsummonDeathFXS auto

