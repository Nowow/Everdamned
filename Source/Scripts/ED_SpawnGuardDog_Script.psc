Scriptname ED_SpawnGuardDog_Script extends ObjectReference  

event OnLoad()
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest: dummy summon loaded")
	self.disable()
	actor _dog = (self.placeatme(ED_Actor_RoyalGuardian_DeathHound, 1, false, true)) as actor
	ED_Mechanics_Quest_RoyalGuardian.HandleDogPlaced(_dog)
	actor dummy = (self as ObjectReference) as actor
	dummy.kill()
	dummy.SetCriticalStage(dummy.CritStage_DisintegrateStart)
	dummy.SetCriticalStage(dummy.CritStage_DisintegrateEnd)
	dummy.Delete()
endevent

actorbase property ED_Actor_RoyalGuardian_DeathHound auto
ED_RoyalGuardianQuest_Script property ED_Mechanics_Quest_RoyalGuardian auto
