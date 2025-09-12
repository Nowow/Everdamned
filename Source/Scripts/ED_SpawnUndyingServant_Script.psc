Scriptname ED_SpawnUndyingServant_Script extends ObjectReference  


float property delayBeforeEnable auto


function OnLoad()

	actor currentUndyingServant = ED_UndyingLoyaltyServant.GetReference() as actor
	if currentUndyingServant ;&& currentUndyingServant.IsDisabled()
		debug.Trace("Everdamned DEBUG: Undying Servant Spawner is boutta spawn")
		
		; UPD: alpha already set to 0 in despawner
		;currentUndyingServant.SetAlpha(0.0) 
		currentUndyingServant.moveto(self)
		
		; UPD: already SetRestrained(true) in despawner
		;currentUndyingServant.SetDontMove(true)
		
		;utility.wait(delayBeforeEnable)
		;currentUndyingServant.enablenowait(true)
		
		
		
		int cntr
		while !(currentUndyingServant.Is3dLoaded()) && cntr < 10
			cntr += 1
			utility.wait(0.2)
		endwhile
		if cntr >= 10
			debug.Trace("Everdamned ERROR: Undying Servant spawner waited more than 2 sec for npc 3d to load, wtf")
		endif
		
		currentUndyingServant.placeatme(ED_Art_Explosion_ColdFlameSummon)
		utility.wait(2.5)
		currentUndyingServant.SetAlpha(1.0, true)
		currentUndyingServant.SetRestrained(false)
		
	endif
	utility.wait(1.0)
	self.Delete()
endFunction

ReferenceAlias Property ED_UndyingLoyaltyServant Auto 
visualeffect property ED_Art_VFX_ColdFlameSummon auto
explosion property ED_Art_Explosion_ColdFlameSummon auto
