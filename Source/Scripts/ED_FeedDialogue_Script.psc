Scriptname ED_FeedDialogue_Script extends Quest  


GlobalVariable Property ED_SameSexRelationshipPreference Auto

float SeductionAndReveal_SeductionAndReveal_Speech_Score_Mod = 0
float Intimidate_Speech_Score_Mod = 0
float Seduction_Level_Score_Mod = 0
float Intimidation_Level_Score_Mod = 0
float Seduction_Allure_Score_Mod = 0
float Seduction_Persuasion_Score_Mod = 0
float Intimidation_Intimidation_Score_Mod = 0
float Seduction_HypnoticGaze_Score_Mod = 0
float Intimidation_AspectOfTerror_Score_Mod = 0
float Seduction_Clothing_Score_Mod = 0
float Intimidation_Clothing_Score_Mod = 0
float Seduction_RaceMismatch_Score_Mod = 0
float Seduction_Relationship_Score_Mod = 0
float Reveal_Relationship_Score_Mod = 0
float Seduction_Sex_Score_Mod = 0
float Intimidation_Sex_Score_Mod = 0
float Reveal_SameFaction_Score_Mod = 0
float Seduction_Score = 0
float Intimidation_Score = 0
float Reveal_Score = 0

float Seduction_Skill_Score_Mod
float Intimidation_Skill_Score_Mod
float Reveal_Skill_Score_Mod

float Seduction_Perk_Score_Mod
float Intimidation_Perk_Score_Mod
float Reveal_Perk_Score_Mod
	

Function CalculateScore(Actor akSeducer, Actor akSeduced)

	SeductionAndReveal_Speech_Score_Mod = akSeducer.GetAV("Speechcraft")
	Intimidate_Speech_Score_Mod = akSeducer.GetAV("Speechcraft")/2
	Seduction_Level_Score_Mod = akSeducer.GetLevel() / 4.0
	Intimidation_Level_Score_Mod = akSeducer.GetLevel()
	
	;;; PERKS
	if akSeducer.HasPerk(Allure)
		Seduction_Allure_Score_Mod = 15
	endif
	
	if akSeducer.HasPerk(Persuasion)
		Seduction_Persuasion_Score_Mod = 10
	endif
	
	if akSeducer.HasPerk(Intimidation)
		Intimidation_Intimidation_Score_Mod = 15
	endif
	
	if akSeducer.HasPerk(HypnoticGaze)
		Seduction_HypnoticGaze_Score_Mod = 10
	endif
	
	if akSeducer.HasPerk(AspectOfTerror)
		Intimidation_AspectOfTerror_Score_Mod = 15
	endif
	
	;CLOTHING
	if akSeducer.WornHasKeyword(ClothingRich)
		Seduction_Clothing_Score_Mod = 20
		Intimidation_Clothing_Score_Mod = 10
	elseif akSeducer.WornHasKeyword(ClothingPoor)
		Seduction_Clothing_Score_Mod = -20
		Intimidation_Clothing_Score_Mod = -10
	endif
	
	;race match
	if akSeducer.GetLeveledActorBase().GetRace().GetName() != akSeduced.GetLeveledActorBase().GetRace().GetName()
		Seduction_RaceMismatch_Score_Mod = -10
	endif
	;	srRaceMod = -10
	
	;Debug.Notification("Seducer's race: " + akSeducer.GetLeveledActorBase().GetRace().GetName() + " Seduced's race: " + akSeduced.GetLeveledActorBase().GetRace().GetName())
	Seduction_Relationship_Score_Mod = akSeduced.GetRelationshipRank(akSeducer)*5
	Reveal_Relationship_Score_Mod = akSeduced.GetRelationshipRank(akSeducer)*10
	
	if akSeducer.GetLeveledActorBase().GetSex() == 1
		Seduction_Sex_Score_Mod = 15
	elseif akSeducer.GetLeveledActorBase().GetSex() == 0
		Intimidation_Sex_Score_Mod = 15
	endif

	Reveal_SameFaction_Score_Mod
	if akSeducer.GetFactionReaction(akSeduced) == 2
		Reveal_SameFaction_Score_Mod = 25
	endif
	
	Seduction_Skill_Score_Mod = SeductionAndReveal_Speech_Score_Mod + Seduction_Level_Score_Mod
	Intimidation_Skill_Score_Mod = SeductionAndReveal_Speech_Score_Mod + Intimidation_Level_Score_Mod
	Reveal_Skill_Score_Mod = SeductionAndReveal_Speech_Score_Mod
	
	Seduction_Perk_Score_Mod = Seduction_Allure_Score_Mod + Seduction_Persuasion_Score_Mod + Seduction_HypnoticGaze_Score_Mod
	Intimidation_Perk_Score_Mod = Intimidation_Intimidation_Score_Mod + Intimidation_AspectOfTerror_Score_Mod 
	Reveal_Perk_Score_Mod = Seduction_Allure_Score_Mod + Seduction_Persuasion_Score_Mod + Seduction_HypnoticGaze_Score_Mod


	Seduction_Score = (
		Seduction_Skill_Score_Mod + Seduction_Perk_Score_Mod + 
		Seduction_Clothing_Score_Mod + Seduction_Relationship_Score_Mod + Seduction_Sex_Score_Mod
	)
	Intimidation_Score = (
		Intimidation_Skill_Score_Mod + Intimidation_Perk_Score_Mod + Seduction_Clothing_Score_Mod + Seduction_RaceMismatch_Score_Mod
	)
	Reveal_Score = (
		Reveal_Skill_Score_Mod + Reveal_Perk_Score_Mod + Reveal_Relationship_Score_Mod + Reveal_SameFaction_Score_Mod
	)

Endfunction

float SeductionAndReveal_Speech_Diffic_Mod = 0
float Intimidate_Speech_Diffic_Mod = 0
float Seduction_Level_Score_Mod = 0
float Intimidation_Level_Score_Mod = 0
float Perk_Allure_Diffic_Mod = 0
float Perk_Persuation_Diffic_Mod = 0
float Perk_Intimidation_Diffic_Mod = 0
float Perk_HypnoticGaze_Diffic_Mod = 0
float Perk_AspectOfTerror_Diffic_Mod = 0
float Perk_MasterOfTheMind_Diffic_Mod = 0
float Perk_Rage_Diffic_Mod = 0
float Seduction_Clothing_Diffic_Mod = 0
float Intimidate_Clothing_Diffic_Mod = 0
float Relationship_Diffic_Mod = 0
float Seduction_Sex_Diff_Mod = 0
float Intimidate_Sex_Diffic_Mod = 0
float Seduction_Faction_Diffic_Mod = 0
float Intimidate_Faction_Diffic_Mod = 0
float Reveal_Faction_Diffic_Mod = 0
float Mesmerism_Diffic_Mod = 0
float Vampire_Diffic_Mod = 0
float Seduction_VampirismKnown_Diffic_Mod = 0
float Intimidate_VampirismKnown_Diffic_Mod = 0
;float sdVampirismKnownRevMod = 0
float Seduction_Morality_Diffic_Mod = 0
float Reveal_Morality_Diffic_Mod = 0
float Intimidate_Morality_Diffic_Mod = 0
float Seduction_Aggression_Diffic_Mod = 0
float Reveal_Aggression_Diffic_Mod = 0
float Intimidation_Aggression_Diffic_Mod = 0
float Seduction_Confidence_Diffic_Mod = 0
float Reveal_Confidence_Diffic_Mod = 0
float Intimidation_Confidence_Diffic_Mod = 0

function CalculateFactionDifficulty(Actor akSeducer, Actor akSeduced)

	int index = 0
	while (Index < mslVTFDsdResFactionsFL.GetSize())
		if akSeduced.IsInFaction(mslVTFDsdResFactionsFL.GetAt(Index) as Faction)
			Seduction_Faction_Diffic_Mod = 30
			Intimidate_Faction_Diffic_Mod = 40
			Reveal_Faction_Diffic_Mod = 50
			Index = mslVTFDsdResFactionsFL.GetSize()
		else
			Index += 1
		endif
	endwhile

endfunction


Function CalculateDifficulty(Actor akSeducer, Actor akSeduced)

	SeductionAndReveal_Speech_Diffic_Mod = akSeducer.GetAV("Speechcraft")
	Intimidate_Speech_Diffic_Mod = akSeducer.GetAV("Speechcraft")/2

	Seduction_Level_Score_Mod = akSeducer.GetLevel() / 4.0
	Intimidation_Level_Score_Mod = akSeducer.GetLevel()
	
	if akSeduced.HasPerk(Allure)
		Perk_Allure_Diffic_Mod = 15
	endif
	
	if akSeduced.HasPerk(Persuasion)
		Perk_Persuation_Diffic_Mod = 10
	endif
	
	if akSeduced.HasPerk(Intimidation)
		Perk_Intimidation_Diffic_Mod = 15
	endif
	
	if akSeduced.HasPerk(HypnoticGaze)
		Perk_HypnoticGaze_Diffic_Mod = 10
	endif
	
	if akSeduced.HasPerk(AspectOfTerror)
		Perk_AspectOfTerror_Diffic_Mod = 15
	endif
	
	if akSeduced.HasPerk(MasterOfTheMind)
		Perk_MasterOfTheMind_Diffic_Mod = 30
	endif
	
	if akSeduced.HasPerk(Rage)
		Perk_Rage_Diffic_Mod = 20
	endif
	
	if akSeduced.WornHasKeyword(ClothingRich)
		Seduction_Clothing_Diffic_Mod = 20
		Intimidate_Clothing_Diffic_Mod = 10
		
	elseif akSeduced.WornHasKeyword(ClothingPoor)
		Seduction_Clothing_Diffic_Mod = -20
		Intimidate_Clothing_Diffic_Mod = -10
	endif
	
	
	if akSeduced.GetRelationshipRank(akSeducer) < akSeduced.GetHighestRelationshipRank()
		Relationship_Diffic_Mod = 20
	endif

	if akSeduced.GetLeveledActorBase().GetSex() == 1
		Seduction_Sex_Diff_Mod = 15
	elseif akSeduced.GetLeveledActorBase().GetSex() == 0
		Intimidate_Sex_Diffic_Mod = 15
	endif
	
	CalculateFactionDifficulty()
	
	if akSeduced.HasMagicEffect(MesSeductionME)
		Mesmerism_Diffic_Mod = -15
		if akSeduced.IsInFaction(MesEntrancementFAC)
			Mesmerism_Diffic_Mod = -40
		endif
	endif

	if akSeduced.HasKeyword(Vampire)
		Vampire_Diffic_Mod = 30
	endif
	
	float Seduction_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*5
	float Reveal_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*10
	float Intimidate_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*5
	
	float Seduction_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*10
	float Reveal_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*5
	float Intimidation_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*5
	
	float Seduction_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*5
	float Reveal_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*5
	float Intimidation_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*10
	
	float sdAISedMod = Seduction_Morality_Diffic_Mod+Seduction_Aggression_Diffic_Mod+Seduction_Confidence_Diffic_Mod
	float sdAIRevMod = Reveal_Morality_Diffic_Mod+Reveal_Aggression_Diffic_Mod+Reveal_Confidence_Diffic_Mod
	float sdAIIntMod = Intimidate_Morality_Diffic_Mod+Intimidation_Aggression_Diffic_Mod+Intimidation_Confidence_Diffic_Mod
	float sdIntimidatedSedMod = 0
	float sdIntimidatedRevMod = 0
	float sdIntimidatedIntMod = 0
	if akSeduced.IsInFaction(mslVTFeedDialogueLastingIntFAC)
		sdIntimidatedSedMod = 20
		sdIntimidatedRevMod = 30
		sdIntimidatedIntMod = 10
	endif
	
Endfunction


Function SeductionCheck(Actor akSeducer, Actor akSeduced)

	;Calculating the seducer's base score

	;float srArmourMod = 0
	;if akSeducer.WornHasKeyword(ArmorMaterialDaedric) || akSeducer.WornHasKeyword(ArmorMaterialDragonplate)
	;	srArmourMod = 30
	;elseif akSeducer.WornHasKeyword(ArmorMaterialOrcish) || akSeducer.WornHasKeyword(ArmorDarkBrotherhood) || akSeducer.WornHasKeyword(ArmorNightingale) || akSeducer.WornHasKeyword(ArmorMaterialDragonscale) || akSeducer.WornHasKeyword(ArmorMaterialEbony) || akSeducer.WornHasKeyword(ArmorMaterialThievesGuildLeader)
	;	srArmourMod = 25
	;elseif akSeducer.WornHasKeyword(ArmorMaterialFalmer) || akSeducer.WornHasKeyword(ArmorMaterialBlades) || akSeducer.WornHasKeyword(ArmorMaterialDwarven) || akSeducer.WornHasKeyword(ArmorMaterialBearStormcloak) || akSeducer.WornHasKeyword(ArmorMaterialPenitus) || akSeducer.WornHasKeyword(ArmorMaterialSteelPlate) || akSeducer.WornHasKeyword(ArmorMaterialThievesGuild) || akSeducer.WornHasKeyword(ArmorMaterialGlass)
	;	srArmourMod = 20
	;elseif akSeducer.WornHasKeyword(ArmorMaterialImperialHeavy) || akSeducer.WornHasKeyword(ArmorMaterialSteel) || akSeducer.WornHasKeyword(ArmorMaterialScaled) || akSeducer.WornHasKeyword(ArmorMaterialElven) || akSeducer.WornHasKeyword(ArmorMaterialElvenGilded)
	;	srArmourMod = 15
	;elseif akSeducer.WornHasKeyword(ArmorMaterialIronBanded) || akSeducer.WornHasKeyword(ArmorMaterialStormcloak) || akSeducer.WornHasKeyword(ArmorMaterialMS02Forsworn) || akSeducer.WornHasKeyword(ArmorMaterialForsworn) || akSeducer.WornHasKeyword(ArmorMaterialImperialLight) || akSeducer.WornHasKeyword(ArmorMaterialImperialStudded)
	;	srArmourMod = 10
	;elseif akSeducer.WornHasKeyword(ArmorMaterialIron) || akSeducer.WornHasKeyword(ArmorMaterialStudded) || akSeducer.WornHasKeyword(ArmorMaterialLeather) || akSeducer.WornHasKeyword(ArmorMaterialHide)
	;	srArmourMod = 5
	;endif
	
	;float srRaceMod = 0
	;float srRaceIntMod = 0
	;if DunmerRaceFL.HasForm(akSeducer.GetLeveledActorBase().GetRace()) && akSeducer.GetLeveledActorBase().GetSex() == 1
	;	srRaceMod = 0
	;elseif OrsimerRaceFL.HasForm(akSeducer.GetLeveledActorBase().GetRace()) && !OrsimerRaceFL.HasForm(akSeduced.GetLeveledActorBase().GetRace())
	;	srRaceMod = -20
	;	srRaceIntMod = 15
	;elseif KhajiitRaceFL.HasForm(akSeducer.GetLeveledActorBase().GetRace()) && !KhajiitRaceFL.HasForm(akSeduced.GetLeveledActorBase().GetRace())
	;	srRaceIntMod = 10
	;elseif akSeducer.GetLeveledActorBase().GetRace().GetName() != akSeduced.GetLeveledActorBase().GetRace().GetName()
	;	srRaceMod = -10
	;endif
	
	;Calculating the seduced's base score

	
	if akSeduced.HasPerk(Allure)
		Perk_Allure_Diffic_Mod = 15
	endif
	
	if akSeduced.HasPerk(Persuasion)
		Perk_Persuation_Diffic_Mod = 10
	endif
	
	if akSeduced.HasPerk(Intimidation)
		Perk_Intimidation_Diffic_Mod = 15
	endif
	
	if akSeduced.HasPerk(HypnoticGaze)
		Perk_HypnoticGaze_Diffic_Mod = 10
	endif
	
	if akSeduced.HasPerk(AspectOfTerror)
		Perk_AspectOfTerror_Diffic_Mod = 15
	endif
	
	if akSeduced.HasPerk(MasterOfTheMind)
		Perk_MasterOfTheMind_Diffic_Mod = 30
	endif
	
	if akSeduced.HasPerk(Rage)
		Perk_Rage_Diffic_Mod = 20
	endif
	
	if akSeduced.WornHasKeyword(ClothingRich)
		Seduction_Clothing_Diffic_Mod = 20
		Intimidate_Clothing_Diffic_Mod = 10
		
	elseif akSeduced.WornHasKeyword(ClothingPoor)
		Seduction_Clothing_Diffic_Mod = -20
		Intimidate_Clothing_Diffic_Mod = -10
	endif
	
	;float sdArmourMod = 0
	;if akSeduced.WornHasKeyword(ArmorMaterialDaedric) || akSeduced.WornHasKeyword(ArmorMaterialDragonplate)
	;	sdArmourMod = 30
	;elseif akSeduced.WornHasKeyword(ArmorMaterialOrcish) || akSeduced.WornHasKeyword(ArmorDarkBrotherhood) || akSeduced.WornHasKeyword(ArmorNightingale) || akSeduced.WornHasKeyword(ArmorMaterialDragonscale) || akSeduced.WornHasKeyword(ArmorMaterialEbony) || akSeduced.WornHasKeyword(ArmorMaterialThievesGuildLeader)
	;	sdArmourMod = 25
	;elseif akSeduced.WornHasKeyword(ArmorMaterialFalmer) || akSeduced.WornHasKeyword(ArmorMaterialBlades) || akSeduced.WornHasKeyword(ArmorMaterialDwarven) || akSeduced.WornHasKeyword(ArmorMaterialBearStormcloak) || akSeduced.WornHasKeyword(ArmorMaterialPenitus) || akSeduced.WornHasKeyword(ArmorMaterialSteelPlate) || akSeduced.WornHasKeyword(ArmorMaterialThievesGuild) || akSeduced.WornHasKeyword(ArmorMaterialGlass)
	;	sdArmourMod = 20
	;elseif akSeduced.WornHasKeyword(ArmorMaterialImperialHeavy) || akSeduced.WornHasKeyword(ArmorMaterialSteel) || akSeduced.WornHasKeyword(ArmorMaterialScaled) || akSeduced.WornHasKeyword(ArmorMaterialElven) || akSeduced.WornHasKeyword(ArmorMaterialElvenGilded)
	;	sdArmourMod = 15
	;elseif akSeduced.WornHasKeyword(ArmorMaterialIronBanded) || akSeduced.WornHasKeyword(ArmorMaterialStormcloak) || akSeduced.WornHasKeyword(ArmorMaterialMS02Forsworn) || akSeduced.WornHasKeyword(ArmorMaterialForsworn) || akSeduced.WornHasKeyword(ArmorMaterialImperialLight) || akSeduced.WornHasKeyword(ArmorMaterialImperialStudded)
	;	sdArmourMod = 10
	;elseif akSeduced.WornHasKeyword(ArmorMaterialIron) || akSeduced.WornHasKeyword(ArmorMaterialStudded) || akSeduced.WornHasKeyword(ArmorMaterialLeather) || akSeduced.WornHasKeyword(ArmorMaterialHide)
	;	sdArmourMod = 5
	;endif
	
	;float sdRaceMod = 0
	;float sdRaceIntMod = 0
	;if DunmerRaceFL.HasForm(akSeduced.GetLeveledActorBase().GetRace()) && akSeduced.GetLeveledActorBase().GetSex() == 1
	;	sdRaceMod = -10
	;elseif AltmerRaceFL.HasForm(akSeduced.GetLeveledActorBase().GetRace())
	;	sdRaceMod = 15
	;elseif OrsimerRaceFL.HasForm(akSeduced.GetLeveledActorBase().GetRace()) && !OrsimerRaceFL.HasForm(akSeducer.GetLeveledActorBase().GetRace())
	;	sdRaceIntMod = 15
	;elseif KhajiitRaceFL.HasForm(akSeduced.GetLeveledActorBase().GetRace()) && !KhajiitRaceFL.HasForm(akSeducer.GetLeveledActorBase().GetRace())
	;	sdRaceIntMod = 10
	;endif
	
	
	if akSeduced.GetRelationshipRank(akSeducer) < akSeduced.GetHighestRelationshipRank()
		Relationship_Diffic_Mod = 20
	endif

	if akSeduced.GetLeveledActorBase().GetSex() == 1
		Seduction_Sex_Diff_Mod = 15
	elseif akSeduced.GetLeveledActorBase().GetSex() == 0
		Intimidate_Sex_Diffic_Mod = 15
	endif

	int index = 0
	while (Index < mslVTFDsdResFactionsFL.GetSize())
		if akSeduced.IsInFaction(mslVTFDsdResFactionsFL.GetAt(Index) as Faction)
			Seduction_Faction_Diffic_Mod = 30
			Intimidate_Faction_Diffic_Mod = 40
			Reveal_Faction_Diffic_Mod = 50
			Index = mslVTFDsdResFactionsFL.GetSize()
		else
			Index += 1
		endif
	endwhile
	
	;float Mesmerism_Diffic_Mod = 0
	if akSeduced.HasMagicEffect(MesSeductionME)
		Mesmerism_Diffic_Mod = -15
		if akSeduced.IsInFaction(MesEntrancementFAC)
			Mesmerism_Diffic_Mod = -40
		endif
	endif
	;float Vampire_Diffic_Mod = 0
	if akSeduced.HasKeyword(Vampire)
		Vampire_Diffic_Mod = 30
	endif
	;float Seduction_VampirismKnown_Diffic_Mod = 0
	;float Intimidate_VampirismKnown_Diffic_Mod = 0
	;float sdVampirismKnownRevMod = 0
	;if akSeduced.GetFactionRank(mslVTMasqPlayerKnownFac) == -1
	;	Seduction_VampirismKnown_Diffic_Mod = 15
	;	Intimidate_VampirismKnown_Diffic_Mod = -20
	;	sdVampirismKnownRevMod = 30
	;elseif akSeduced.GetFactionRank(mslVTMasqPlayerKnownFac) == 1
	;	Seduction_VampirismKnown_Diffic_Mod = -15
	;	Intimidate_VampirismKnown_Diffic_Mod = -10
	;	sdVampirismKnownRevMod = -30
	;endif
	float Seduction_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*5
	float Reveal_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*10
	float Intimidate_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*5
	float Seduction_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*10
	float Reveal_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*5
	float Intimidation_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*5
	float Seduction_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*5
	float Reveal_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*5
	float Intimidation_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*10
	float sdAISedMod = Seduction_Morality_Diffic_Mod+Seduction_Aggression_Diffic_Mod+Seduction_Confidence_Diffic_Mod
	float sdAIRevMod = Reveal_Morality_Diffic_Mod+Reveal_Aggression_Diffic_Mod+Reveal_Confidence_Diffic_Mod
	float sdAIIntMod = Intimidate_Morality_Diffic_Mod+Intimidation_Aggression_Diffic_Mod+Intimidation_Confidence_Diffic_Mod
	float sdIntimidatedSedMod = 0
	float sdIntimidatedRevMod = 0
	float sdIntimidatedIntMod = 0
	if akSeduced.IsInFaction(mslVTFeedDialogueLastingIntFAC)
		sdIntimidatedSedMod = 20
		sdIntimidatedRevMod = 30
		sdIntimidatedIntMod = 10
	endif


	float sdBaseScoreSed = 
		Seduction_Speech_Diffic_Mod*2 + sdAllurePerkMod + Perk_Persuation_Diffic_Mod + Perk_MasterOfTheMind_Diffic_Mod + 
		Seduction_Clothing_Diffic_Mod + sdRaceMod + Relationship_Diffic_Mod + Seduction_Sex_Diff_Mod + Seduction_Faction_Diffic_Mod + Mesmerism_Diffic_Mod + 
		Vampire_Diffic_Mod + Seduction_VampirismKnown_Diffic_Mod + sdAISedMod + sdIntimidatedSedMod
		
	float sdBaseScoreInt = Seduction_Speech_Diffic_Mod*2+Intimidation_Intimidation_Diffic_Mod+Perk_AspectOfTerror_Diffic_Mod+Perk_Rage_Diffic_Mod+Seduction_Clothing_Diffic_Mod+sdArmourMod+sdRaceIntMod+Intimidate_Sex_Diffic_Mod+Intimidate_Faction_Diffic_Mod+Mesmerism_Diffic_Mod+Vampire_Diffic_Mod+Intimidate_VampirismKnown_Diffic_Mod+(akSeduced.GetAV("Health")/2)+sdAIIntMod+sdIntimidatedIntMod 
	float sdBaseScoreRev = Seduction_Speech_Diffic_Mod*2+sdAllurePerkMod+Perk_Persuation_Diffic_Mod+Perk_MasterOfTheMind_Diffic_Mod+Reveal_Faction_Diffic_Mod+Mesmerism_Diffic_Mod+Vampire_Diffic_Mod+sdAIRevMod+sdIntimidatedRevMod
	;Debug.Notification("Seducee's base seduction score is: " + sdBaseScoreSed)
	;Debug.Notification("Seducee's base intimidation score is: " + sdBaseScoreInt)
	;Debug.Notification("Seducee's base reveal score is: " + sdBaseScoreRev)

	;Calculating final scores

	mslVTFDsrToneSubtle.SetValue(Seduction_Score+Utility.RandomInt(-15,10))
	mslVTFDsdToneSubtle.SetValue(sdBaseScoreSed+mslVTFDDifficulty.Value+Utility.RandomInt(-10,15))
	mslVTFDsrToneAggressive.SetValue(Intimidation_Score+Utility.RandomInt(-15,15))
	mslVTFDsdToneAggressive.SetValue(sdBaseScoreInt+mslVTFDDifficulty.Value+Utility.RandomInt(-15,15))
	mslVTFDsrToneCharming.SetValue(Reveal_Score+Utility.RandomInt(-10,5))
	mslVTFDsdToneCharming.SetValue(sdBaseScoreRev+mslVTFDDifficulty.Value+Utility.RandomInt(-5,10))

	;Debug.Notification("Function finished!")

Endfunction


Perk Property Allure Auto
Perk Property Persuasion Auto
Perk Property HypnoticGaze Auto
Perk Property Intimidation Auto
Perk Property MasterOfTheMind Auto
Perk Property AspectOfTerror Auto
Perk Property Rage Auto
Keyword Property ClothingRich Auto
Keyword Property ClothingPoor Auto
Keyword Property ArmorMaterialDaedric Auto
Keyword Property ArmorMaterialDragonplate Auto
Keyword Property ArmorMaterialOrcish Auto
Keyword Property ArmorDarkBrotherhood Auto
Keyword Property ArmorNightingale Auto
Keyword Property ArmorMaterialDragonscale Auto
Keyword Property ArmorMaterialEbony Auto
Keyword Property ArmorMaterialThievesGuildLeader Auto
Keyword Property ArmorMaterialFalmer Auto
Keyword Property ArmorMaterialBlades Auto
Keyword Property ArmorMaterialDwarven Auto
Keyword Property ArmorMaterialBearStormcloak Auto
Keyword Property ArmorMaterialPenitus Auto
Keyword Property ArmorMaterialSteelPlate Auto
Keyword Property ArmorMaterialThievesGuild Auto
Keyword Property ArmorMaterialGlass Auto
Keyword Property ArmorMaterialImperialHeavy Auto
Keyword Property ArmorMaterialSteel Auto
Keyword Property ArmorMaterialScaled Auto
Keyword Property ArmorMaterialElven Auto
Keyword Property ArmorMaterialElvenGilded Auto
Keyword Property ArmorMaterialIronBanded Auto
Keyword Property ArmorMaterialStormcloak Auto
Keyword Property ArmorMaterialMS02Forsworn Auto
Keyword Property ArmorMaterialForsworn Auto
Keyword Property ArmorMaterialImperialLight Auto
Keyword Property ArmorMaterialImperialStudded Auto
Keyword Property ArmorMaterialIron Auto
Keyword Property ArmorMaterialStudded Auto
Keyword Property ArmorMaterialLeather Auto
Keyword Property ArmorMaterialHide Auto
Keyword Property Vampire Auto
FormList Property DunmerRaceFL Auto
FormList Property AltmerRaceFL Auto
FormList Property OrsimerRaceFL Auto
FormList Property KhajiitRaceFL Auto
FormList Property mslVTFDsdResFactionsFL Auto
Faction Property mslVTMasqPlayerKnownFac Auto
Faction Property mslVTFeedDialogueLastingIntFAC Auto
MagicEffect Property SunPenaltyME Auto
MagicEffect Property SunDamageME Auto
MagicEffect Property MesSeductionME Auto
Faction Property MesEntrancementFAC Auto
MagicEffect Property mslVTBloodSexFemaleME Auto
MagicEffect Property mslVTBloodSexMaleME Auto

GlobalVariable Property mslVTFDsrToneSubtle Auto
GlobalVariable Property mslVTFDsdToneSubtle Auto
GlobalVariable Property mslVTFDsrToneAggressive Auto
GlobalVariable Property mslVTFDsdToneAggressive Auto
GlobalVariable Property mslVTFDsrToneCharming Auto
GlobalVariable Property mslVTFDsdToneCharming Auto

GlobalVariable Property mslVTFDDifficulty Auto