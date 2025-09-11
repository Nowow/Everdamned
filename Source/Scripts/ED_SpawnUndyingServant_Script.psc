Scriptname ED_SpawnUndyingServant_Script extends ObjectReference  


float property delayBeforeEnable auto


function OnLoad()

	actor currentUndyingServant = ED_UndyingLoyaltyServant.GetReference() as actor
	if currentUndyingServant ;&& currentUndyingServant.IsDisabled()
		debug.Trace("Everdamned DEBUG: Undying Servant Spawner is boutta spawn")
		currentUndyingServant.moveto(self)
		utility.wait(delayBeforeEnable)
		currentUndyingServant.enablenowait(true)
		currentUndyingServant.SetAlpha(0.0)
		currentUndyingServant.SetDontMove(true)
		
		int cntr
		while !(currentUndyingServant.Is3dLoaded()) && cntr < 10
			cntr += 1
			utility.wait(0.2)
		endwhile
		if cntr >= 10
			debug.Trace("Everdamned ERROR: Undying Servant spawner waited more than 2 sec for npc 3d to load, wtf")
		endif
		
		;ED_Art_VFX_ColdFlameSummon.Play(self, 5.0)
		currentUndyingServant.placeatme(ED_Art_Explosion_ColdFlameSummon)
		utility.wait(2.5)
		currentUndyingServant.SetAlpha(1.0, true)
		currentUndyingServant.SetDontMove(false)
		
	endif
	utility.wait(1.0)
	self.Delete()
endFunction

ReferenceAlias Property ED_UndyingLoyaltyServant Auto 
visualeffect property ED_Art_VFX_ColdFlameSummon auto
explosion property ED_Art_Explosion_ColdFlameSummon auto
