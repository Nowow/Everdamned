Scriptname ED_BlooBoil_AliasScript extends ReferenceAlias  

Event OnDying(actor akKiller)
	self.Clear()
endevent

function TryToClearThisActor(actor thisActor)
	if self.GetActorReference() == thisActor
		debug.Trace("Everdamned DEBUG: Something called alias ED_BloodBoilTarget to clear correct actor, clearing alias")
		self.Clear()
	endif
endfunction

