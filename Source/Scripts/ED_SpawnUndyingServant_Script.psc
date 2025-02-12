Scriptname ED_SpawnUndyingServant_Script extends ObjectReference  


function OnLoad()

	actor currentUndyingServant = ED_UndyingLoyaltyServant.GetReference() as actor
	if currentUndyingServant && currentUndyingServant.IsDisabled()
		debug.Trace("Everdamned DEBUG: Undying Servant Spawner is boutta spawn")
		currentUndyingServant.moveto(self)
		utility.wait(delayBeforeEnable)
		currentUndyingServant.enable(true) ;with fade it
	endif
	self.Delete()
endFunction

ReferenceAlias Property ED_UndyingLoyaltyServant  Auto  
float property delayBeforeEnable auto
