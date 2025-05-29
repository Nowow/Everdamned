Scriptname ED_MainPlayerAlias_Script extends ReferenceAlias  

Event OnRaceSwitchComplete()

	race __raceSwitchedTo = playerRef.GetRace()
	
	if playerRef.hasperk(ED_PerkTreeVL_UndyingLoyalty_Perk)
		Debug.Trace("Everdamned DEBUG: Main Quest detected that player has Undying Loyalty perk")
		
		actor currentUndyingServant = ED_UndyingLoyaltyServant1.GetReference() as actor
		
		if currentUndyingServant
			Debug.Trace("Everdamned DEBUG: Main Quest detected Undying Servant alias is filled")
			
			if __raceSwitchedTo == DLC1VampireBeastRace
				Debug.Trace("Everdamned DEBUG: player switched to Vampire Lord")
				if currentUndyingServant.IsDisabled()
					Debug.Trace("Everdamned DEBUG: Undying Servant is disabled, need to summon it back")
					playerRef.placeatme(ED_Misc_UndyingServant1_Activator_Spawn)
					; SpawnSummonActivator() that does the summoning, because need to wait for OnLoad?
				endif
				
			else
				Debug.Trace("Everdamned DEBUG: player switched NOT to Vampire Lord")
				if !(currentUndyingServant.IsDisabled())
					Debug.Trace("Everdamned DEBUG: Undying Servant is not disabled, should send it to Oblivion")
					playerRef.placeatme(ED_Misc_UndyingServant1_Activator_Despawn)
					; SpawnSendoffActivator() that does the sending, because need to wait for OnLoad?
					; DoSendToOblivion()
				endif
				
			endif
		endif
	endif
	
	if playerRef.HasPerk(ED_PerkTreeVL_UnearthlyWill_Perk)
		if __raceSwitchedTo == DLC1VampireBeastRace 
			Debug.Trace("Everdamned DEBUG: Player has Unearthly Will and switched TO VL, halving the blood costs")
			ED_Mechanics_Helper_Quest.GoToState("UnearthlyWill")
		else
			Debug.Trace("Everdamned DEBUG: Player has Unearthly Will and switched FROM VL, full blood costs")
			ED_Mechanics_Helper_Quest.GoToState("")
		endif		
	endif
	
	
EndEvent

race property DLC1VampireBeastRace auto
actor property playerRef auto
activator property ED_Misc_UndyingServant1_Activator_Spawn auto
activator property ED_Misc_UndyingServant1_Activator_Despawn auto
perk property ED_PerkTreeVL_UndyingLoyalty_Perk auto


ReferenceAlias Property ED_UndyingLoyaltyServant1  Auto  

perk property ED_PerkTreeVL_UnearthlyWill_Perk auto
ED_BloodCostDeducter_Script property ED_Mechanics_Helper_Quest auto
