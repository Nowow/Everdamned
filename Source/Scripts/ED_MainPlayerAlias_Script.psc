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
	
	ED_Art_SoundM_LolUDied.Play(playerRef)
	ED_Art_SoundM_DeathSounds.Play(playerRef)
	
	if ED_Mechanics_Global_MCM_DisableDisintegrate.GetValue() != 0.0
		return
	endif
	
	if playerRef.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_BurningInSun)
		DLC1HarkonDisintegrate01FXS.Play(playerRef)
		utility.wait(1.75)
		playerRef.SetAlpha (0.0,True)
		playerRef.AttachAshPile(AshPileObject)
	else
		ShockDisintegrate01FXS.Play(playerRef)
		utility.wait(1.75)
		playerRef.SetAlpha (0.0,True)
		playerRef.AttachAshPile()
	endif
	
endevent

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned INFO: Main Quest modifies FavorJobsBeggarsAbility to be able to distinguish it from Alchemy LOL")
	Debug.Trace("Everdamned WARNING: RemoveMagicEffectFromSpell MAY FAIL, that OK")
	; it may fail from time to time, thats ok
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
globalvariable property ED_Mechanics_Global_MCM_DisableDisintegrate auto

effectshader property DLC1HarkonDisintegrate01FXS auto
effectshader property ShockDisintegrate01FXS auto

;keyword property MagicDamageFire auto
keyword property ED_Mechanics_Keyword_BurningInSun auto
activator property AshPileObject auto
sound property ED_Art_SoundM_LolUDied auto
sound property ED_Art_SoundM_DeathSounds auto

ReferenceAlias Property ED_UndyingLoyaltyServant1  Auto  

perk property ED_PerkTreeVL_UnearthlyWill_Perk auto
ED_BloodCostDeducter_Script property ED_Mechanics_Helper_Quest auto

spell property FavorJobsBeggarsAbility auto
magiceffect property ED_Mechanics_Spell_GiftOfCharityTracker_Effect auto
