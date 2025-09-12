Scriptname ED_MainPlayerAlias_Script extends ReferenceAlias  

Event OnRaceSwitchComplete()

	race __raceSwitchedTo = playerRef.GetRace()
	
	if playerRef.hasperk(ED_PerkTreeVL_UndyingLoyalty_Perk)
		Debug.Trace("Everdamned DEBUG: Main Quest detected that player has Undying Loyalty perk")
		
		actor currentUndyingServant = ED_UndyingLoyaltyServant1.GetReference() as actor
		
		if currentUndyingServant
			Debug.Trace("Everdamned DEBUG: Main Quest detected Undying Servant alias is filled")
			
			cell whereThemAt = currentUndyingServant.GetParentCell()
			
			if __raceSwitchedTo == DLC1VampireBeastRace
				Debug.Trace("Everdamned DEBUG: player switched to Vampire Lord")
				if whereThemAt == ED_Cell_Stuffgoeshere
					Debug.Trace("Everdamned DEBUG: Undying Servant is stashed, need to summon it back")
					playerRef.placeatme(ED_Misc_UndyingServant1_Activator_Spawn)
				endif
				
			else
				Debug.Trace("Everdamned DEBUG: player switched NOT to Vampire Lord")
				if !(whereThemAt == ED_Cell_Stuffgoeshere)
					Debug.Trace("Everdamned DEBUG: Undying Servant was not stashed, should send it to Oblivion")
					currentUndyingServant.placeatme(ED_Misc_UndyingServant1_Activator_Despawn)
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

Event OnDying(Actor akKiller)
	actorbase playerActorBase = playerRef.GetActorBase()
	if playerActorBase.IsProtected() || playerRef.IsEssential()
		return
	endif
	if playerRef.HasMagicEffectWithKeyword(MagicDamageFire)
		DLC1HarkonDisintegrate01FXS.Play(playerRef)
		utility.wait(1.75)
		playerRef.SetAlpha (0.0,True)
		playerRef.AttachAshPile(AshPileObject)
		
	endif
endevent

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned DEBUG: Main Quest modifies FavorJobsBeggarsAbility to be able to distinguish it from Alchemy LOL")
	PO3_SKSEFunctions.RemoveMagicEffectFromSpell(FavorJobsBeggarsAbility, ED_Mechanics_Spell_GiftOfCharityTracker_Effect, 0, 0, 3600, 0.0)
	string[] __condList
	PO3_SKSEFunctions.AddMagicEffectToSpell(FavorJobsBeggarsAbility, ED_Mechanics_Spell_GiftOfCharityTracker_Effect, 0, 0, 3600, 0.0, __condList)
		
	
endevent

race property DLC1VampireBeastRace auto
actor property playerRef auto

activator property ED_Misc_UndyingServant1_Activator_Spawn auto
activator property ED_Misc_UndyingServant1_Activator_Despawn auto
perk property ED_PerkTreeVL_UndyingLoyalty_Perk auto
objectreference property MarkerToStoreServantAt auto
cell property ED_Cell_Stuffgoeshere auto

effectshader property DLC1HarkonDisintegrate01FXS auto
keyword property MagicDamageFire auto
activator property AshPileObject auto

ReferenceAlias Property ED_UndyingLoyaltyServant1  Auto  

perk property ED_PerkTreeVL_UnearthlyWill_Perk auto
ED_BloodCostDeducter_Script property ED_Mechanics_Helper_Quest auto

spell property FavorJobsBeggarsAbility auto
magiceffect property ED_Mechanics_Spell_GiftOfCharityTracker_Effect auto
