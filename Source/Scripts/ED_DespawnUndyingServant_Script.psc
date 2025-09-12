Scriptname ED_DespawnUndyingServant_Script extends ObjectReference  


function OnLoad()

	actor currentUndyingServant = ED_UndyingLoyaltyServant.GetReference() as actor
	
	if currentUndyingServant != None
	
		if currentUndyingServant.IsDead()
			debug.Trace("Everdamned DEBUG: Undying Servant Despawner found its servant dead, removing from reference")
			ED_UndyingLoyaltyServant.Clear()
		endif
		;if !(currentUndyingServant.IsDisabled())
		debug.Trace("Everdamned DEBUG: Undying Servant Despawner is boutta send to Oblivion")
		currentUndyingServant.SetRestrained(true)
		currentUndyingServant.SetAlpha(0.0, true)
		utility.wait(2.0)
		currentUndyingServant.moveto(MarkerToStoreServantAt)
		;endif
		
	endif
	utility.wait(4.0)
	self.Delete()
endFunction

ReferenceAlias Property ED_UndyingLoyaltyServant  Auto  
float property delayBeforeDisable auto
objectreference property MarkerToStoreServantAt auto
