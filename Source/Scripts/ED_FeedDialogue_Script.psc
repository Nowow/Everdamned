Scriptname ED_FeedDialogue_Script extends Quest  

import math

GlobalVariable Property ED_Mechanics_FeedDialogue_SameSexRelationshipPreference_Setting Auto
GlobalVariable Property ED_Mechanics_FeedDialogue_DifficultyModifier_Setting Auto

; difficulty modificator factions
Faction Property MarkarthTempleofDibellaFaction Auto
Faction Property RiftenTempleofMaraFaction Auto
Faction Property SolitudeTempleoftheDivinesFaction Auto
Faction Property WhiterunTempleofKynarethFaction Auto
Faction Property WindhelmTempleFaction Auto
Faction Property JobPriestFaction Auto
Faction Property JobCourtWizardFaction Auto
Faction Property CollegeofWinterholdFaction Auto
Faction Property ThievesGuildFaction Auto
Faction Property DarkBrotherhoodFaction Auto
Faction Property FavorJobsBeggarsFaction Auto
Faction Property GuardDialogueFaction Auto
Faction Property CWDialogueSoldierFaction Auto
Faction Property BanditFaction Auto
Faction Property PenitusOculatusFaction Auto
Faction Property ForswornFaction Auto
Faction Property DLC1HunterFaction Auto
Faction Property VigilantOfStendarrFaction Auto
Faction Property JobInnServer Auto
Faction Property JobInnkeeperFaction Auto
Faction Property GovImperial Auto
Faction Property GovRuling Auto
Faction Property GovSons Auto
Faction Property JobGuardCaptainFaction Auto
Faction Property GreybeardFaction Auto
Faction Property JobJarlFaction Auto
Faction Property CompanionsFaction Auto
Faction Property CompanionsCirclePlusKodlak Auto

FormList Property ED_Mechanics_OrcRace_List Auto

float SeductionAndReveal_Speech_Score_Mod
float Intimidate_Speech_Score_Mod
float Seduction_Level_Score_Mod
float Intimidation_Level_Score_Mod
float Seduction_Allure_Score_Mod
float Seduction_Persuasion_Score_Mod
float Intimidation_Intimidation_Score_Mod
float Seduction_HypnoticGaze_Score_Mod
float Intimidation_AspectOfTerror_Score_Mod
float Seduction_Clothing_Score_Mod
float Intimidation_Clothing_Score_Mod
float Seduction_RaceMismatch_Score_Mod
float Seduction_Relationship_Score_Mod
float Reveal_Relationship_Score_Mod
float Seduction_Sex_Score_Mod
float Intimidation_Race_Score_Mod
float Reveal_SameFaction_Score_Mod
float Seduction_Score
float Intimidation_Score
float Reveal_Score

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
	
	int pc_sex
	int target_sex
	int same_sex_pref 
	pc_sex = akSeducer.GetLeveledActorBase().GetSex()
	target_sex = akSeduced.GetLeveledActorBase().GetSex()
	same_sex_pref = ED_Mechanics_FeedDialogue_SameSexRelationshipPreference_Setting.GetValue() as int
	
	if (same_sex_pref == 1 && pc_sex == target_sex) || (same_sex_pref == 0 && pc_sex != target_sex)
		Seduction_Sex_Score_Mod = 15
	endif
	
	; also ork scary
	if ED_Mechanics_OrcRace_List.HasForm(akSeducer.GetLeveledActorBase().GetRace()) && !ED_Mechanics_OrcRace_List.HasForm(akSeduced.GetLeveledActorBase().GetRace())
		Intimidation_Race_Score_Mod = 15
	endif

	if akSeducer.GetFactionReaction(akSeduced) == 2
		Reveal_SameFaction_Score_Mod = 25
	endif
	
	Seduction_Skill_Score_Mod = SeductionAndReveal_Speech_Score_Mod + Seduction_Level_Score_Mod
	Intimidation_Skill_Score_Mod = Intimidate_Speech_Score_Mod + Intimidation_Level_Score_Mod
	Reveal_Skill_Score_Mod = SeductionAndReveal_Speech_Score_Mod
	
	Seduction_Perk_Score_Mod = Seduction_Allure_Score_Mod + Seduction_Persuasion_Score_Mod + Seduction_HypnoticGaze_Score_Mod
	Intimidation_Perk_Score_Mod = Intimidation_Intimidation_Score_Mod + Intimidation_AspectOfTerror_Score_Mod 
	Reveal_Perk_Score_Mod = Seduction_Allure_Score_Mod + Seduction_Persuasion_Score_Mod + Seduction_HypnoticGaze_Score_Mod


	Seduction_Score = Seduction_Skill_Score_Mod + Seduction_Perk_Score_Mod + Seduction_Clothing_Score_Mod + Seduction_RaceMismatch_Score_Mod + Seduction_Relationship_Score_Mod + Seduction_Sex_Score_Mod + Utility.RandomInt(-10,10)
	
	Intimidation_Score = Intimidation_Skill_Score_Mod + Intimidation_Perk_Score_Mod + Intimidation_Clothing_Score_Mod + Intimidation_Race_Score_Mod + Utility.RandomInt(-10,10)
	
	Reveal_Score = Reveal_Skill_Score_Mod + Reveal_Perk_Score_Mod + Reveal_Relationship_Score_Mod + Reveal_SameFaction_Score_Mod + Utility.RandomInt(-10,10)
	

Endfunction

float SeductionAndReveal_Speech_Diffic_Mod
float Intimidate_Speech_Diffic_Mod
float Seduction_Level_Diffic_Mod
float Intimidation_Level_Diffic_Mod
float Perk_Allure_Diffic_Mod
float Perk_Persuation_Diffic_Mod
float Perk_Intimidation_Diffic_Mod
float Perk_HypnoticGaze_Diffic_Mod
float Perk_AspectOfTerror_Diffic_Mod
float Perk_MasterOfTheMind_Diffic_Mod
float Perk_Rage_Diffic_Mod
float Seduction_Clothing_Diffic_Mod
float Intimidate_Clothing_Diffic_Mod
float Relationship_Diffic_Mod
float Seduction_Sex_Diff_Mod
float Intimidate_Sex_Diffic_Mod
float Seduction_Faction_Diffic_Mod
float Intimidate_Faction_Diffic_Mod
float Reveal_Faction_Diffic_Mod
float Mesmerism_Diffic_Mod
float Vampire_Diffic_Mod
float Seduction_VampirismKnown_Diffic_Mod
float Intimidate_VampirismKnown_Diffic_Mod
;float sdVampirismKnownRevMod = 0
float Seduction_Morality_Diffic_Mod
float Reveal_Morality_Diffic_Mod
float Intimidate_Morality_Diffic_Mod
float Seduction_Aggression_Diffic_Mod
float Reveal_Aggression_Diffic_Mod
float Intimidation_Aggression_Diffic_Mod
float Seduction_Confidence_Diffic_Mod
float Reveal_Confidence_Diffic_Mod
float Intimidation_Confidence_Diffic_Mod

float Seduction_AI_Diffic_Mod
float Reveal_AI_Diffic_Mod
float Intimidation_AI_Diffic_Mod

float Seduction_Difficulty_Score
float Intimidation_Difficulty_Score
float Reveal_Difficulty_Score

float Seduction_Skill_Diffic_Mod
float Intimidation_Skill_Diffic_Mod 
float SeductionAndReveal_Perk_Diffic_Mod
float Intimidation_Perk_Diffic_Mod

float Diffuculty_Mod_Setting


function CalculateFactionDifficulty(Actor akSeducer, Actor akSeduced)

	; TODO: redo with hashmaps and GetPropertyValue ?
	
	if (akSeduced.IsInFaction(DLC1HunterFaction) || akSeduced.IsInFaction(VigilantOfStendarrFaction))
		
			Seduction_Faction_Diffic_Mod = 40
			Reveal_Faction_Diffic_Mod = 100
			Intimidate_Faction_Diffic_Mod = 40
		
	elseif akSeduced.IsInFaction(MarkarthTempleofDibellaFaction)
		
			Seduction_Faction_Diffic_Mod = -30
			Reveal_Faction_Diffic_Mod = 40
			Intimidate_Faction_Diffic_Mod = 15
			
	elseif (akSeduced.IsInFaction(RiftenTempleofMaraFaction) || akSeduced.IsInFaction(SolitudeTempleoftheDivinesFaction) || akSeduced.IsInFaction(WhiterunTempleofKynarethFaction) || akSeduced.IsInFaction(WindhelmTempleFaction) ||akSeduced.IsInFaction(JobPriestFaction))
	
			Seduction_Faction_Diffic_Mod = 0
			Reveal_Faction_Diffic_Mod = 40
			Intimidate_Faction_Diffic_Mod = 15
		
	elseif (akSeduced.IsInFaction(JobCourtWizardFaction) || akSeduced.IsInFaction(CollegeofWinterholdFaction))
			
			Seduction_Faction_Diffic_Mod = 0
			Reveal_Faction_Diffic_Mod = -20
			Intimidate_Faction_Diffic_Mod = 0
		
	elseif akSeduced.IsInFaction(ThievesGuildFaction)
			
			Seduction_Faction_Diffic_Mod = -10
			Reveal_Faction_Diffic_Mod = -10
			Intimidate_Faction_Diffic_Mod = 15
		
	elseif akSeduced.IsInFaction(DarkBrotherhoodFaction)
			
			Seduction_Faction_Diffic_Mod = 0
			Reveal_Faction_Diffic_Mod = -100
			Intimidate_Faction_Diffic_Mod = 40
			
	elseif akSeduced.IsInFaction(CompanionsCirclePlusKodlak)
			
			Seduction_Faction_Diffic_Mod = -20
			Reveal_Faction_Diffic_Mod = 100
			Intimidate_Faction_Diffic_Mod = 60
	
	elseif akSeduced.IsInFaction(CompanionsFaction)
			
			Seduction_Faction_Diffic_Mod = -20
			Reveal_Faction_Diffic_Mod = 40
			Intimidate_Faction_Diffic_Mod = 40
			
	elseif akSeduced.IsInFaction(GreybeardFaction)
			
			Seduction_Faction_Diffic_Mod = 40
			Reveal_Faction_Diffic_Mod = 40
			Intimidate_Faction_Diffic_Mod = 60
	
	elseif akSeduced.IsInFaction(FavorJobsBeggarsFaction)
			
			Seduction_Faction_Diffic_Mod = 0
			Reveal_Faction_Diffic_Mod = 15
			Intimidate_Faction_Diffic_Mod = -30
	
	elseif akSeduced.IsInFaction(JobGuardCaptainFaction)
			
			Seduction_Faction_Diffic_Mod = -15
			Reveal_Faction_Diffic_Mod = 40
			Intimidate_Faction_Diffic_Mod = 40
	
	elseif akSeduced.IsInFaction(JobJarlFaction)
			
			Seduction_Faction_Diffic_Mod = 0
			Reveal_Faction_Diffic_Mod = 30
			Intimidate_Faction_Diffic_Mod = 40
	
	elseif (akSeduced.IsInFaction(GuardDialogueFaction) || akSeduced.IsInFaction(CWDialogueSoldierFaction) || akSeduced.IsInFaction(BanditFaction) || akSeduced.IsInFaction(PenitusOculatusFaction) || akSeduced.IsInFaction(GovImperial) || akSeduced.IsInFaction(GovRuling) || akSeduced.IsInFaction(GovSons))
		
			Seduction_Faction_Diffic_Mod = -15
			Reveal_Faction_Diffic_Mod = 15
			Intimidate_Faction_Diffic_Mod = 20
	
	elseif akSeduced.IsInFaction(ForswornFaction)
		
			Seduction_Faction_Diffic_Mod = 0
			Reveal_Faction_Diffic_Mod = 0
			Intimidate_Faction_Diffic_Mod = -20
	
	endif

endfunction


Function CalculateDifficulty(Actor akSeducer, Actor akSeduced)

	SeductionAndReveal_Speech_Diffic_Mod = akSeducer.GetAV("Speechcraft")
	Intimidate_Speech_Diffic_Mod = akSeducer.GetAV("Speechcraft")/2

	Seduction_Level_Diffic_Mod = akSeducer.GetLevel() / 4.0
	Intimidation_Level_Diffic_Mod = akSeducer.GetLevel()
	
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
	
	int relationshipRank = akSeduced.GetRelationshipRank(akSeducer)
	float relationshipMult = relationshipRank as float / akSeduced.GetHighestRelationshipRank() as float
	
	if akSeduced.GetRelationshipRank(akSeducer) < akSeduced.GetHighestRelationshipRank()
		Relationship_Diffic_Mod = 20
	endif

	if akSeduced.GetLeveledActorBase().GetSex() == 1
		Seduction_Sex_Diff_Mod = 15
	elseif akSeduced.GetLeveledActorBase().GetSex() == 0
		Intimidate_Sex_Diffic_Mod = 15
	endif
	
	CalculateFactionDifficulty(akSeducer, akSeduced)
	
	;if akSeduced.HasMagicEffect(MesSeductionME)
	;	Mesmerism_Diffic_Mod = -15
	;	if akSeduced.IsInFaction(MesEntrancementFAC)
	;		Mesmerism_Diffic_Mod = -40
	;	endif
	;endif

	
	Seduction_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*5
	Reveal_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*10
	Intimidate_Morality_Diffic_Mod = akSeduced.GetAV("Morality")*5
	
	Seduction_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*10
	Reveal_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*5
	Intimidation_Aggression_Diffic_Mod = akSeduced.GetAV("Aggression")*5
	
	Seduction_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*5
	Reveal_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*52
	Intimidation_Confidence_Diffic_Mod = akSeduced.GetAV("Confidence")*10
	
	Seduction_AI_Diffic_Mod = Seduction_Morality_Diffic_Mod+Seduction_Aggression_Diffic_Mod+Seduction_Confidence_Diffic_Mod
	Reveal_AI_Diffic_Mod = Reveal_Morality_Diffic_Mod+Reveal_Aggression_Diffic_Mod+Reveal_Confidence_Diffic_Mod
	Intimidation_AI_Diffic_Mod = Intimidate_Morality_Diffic_Mod+Intimidation_Aggression_Diffic_Mod+Intimidation_Confidence_Diffic_Mod
	
	Seduction_Skill_Diffic_Mod = SeductionAndReveal_Speech_Diffic_Mod + Seduction_Level_Diffic_Mod
	Intimidation_Skill_Diffic_Mod = Intimidate_Speech_Diffic_Mod + Intimidation_Level_Diffic_Mod
	
	SeductionAndReveal_Perk_Diffic_Mod = Perk_Allure_Diffic_Mod + Perk_Persuation_Diffic_Mod + Perk_HypnoticGaze_Diffic_Mod + Perk_MasterOfTheMind_Diffic_Mod
	Intimidation_Perk_Diffic_Mod = Perk_Intimidation_Diffic_Mod + Perk_AspectOfTerror_Diffic_Mod + Perk_Rage_Diffic_Mod
	
	Diffuculty_Mod_Setting = ED_Mechanics_FeedDialogue_DifficultyModifier_Setting.GetValue()
	
	Seduction_Difficulty_Score = Seduction_Skill_Diffic_Mod + SeductionAndReveal_Perk_Diffic_Mod + Seduction_Faction_Diffic_Mod + Seduction_Clothing_Diffic_Mod + Relationship_Diffic_Mod + Seduction_Sex_Diff_Mod + Seduction_AI_Diffic_Mod + Utility.RandomInt(-10,10) + Diffuculty_Mod_Setting
	Intimidation_Difficulty_Score = Intimidation_Skill_Diffic_Mod + Intimidation_Perk_Diffic_Mod + Intimidate_Clothing_Diffic_Mod + Intimidate_Sex_Diffic_Mod + Intimidation_AI_Diffic_Mod + Intimidate_Faction_Diffic_Mod + Utility.RandomInt(-10,10) + Diffuculty_Mod_Setting
	Reveal_Difficulty_Score = SeductionAndReveal_Speech_Diffic_Mod + SeductionAndReveal_Perk_Diffic_Mod + Relationship_Diffic_Mod + Reveal_Faction_Diffic_Mod + Reveal_AI_Diffic_Mod + Utility.RandomInt(-10,10) + Diffuculty_Mod_Setting

		
	
	;float sdIntimidatedSedMod = 0
	;float sdIntimidatedRevMod = 0
	;float sdIntimidatedIntMod = 0
	;if akSeduced.IsInFaction(mslVTFeedDialogueLastingIntFAC)
	;	sdIntimidatedSedMod = 20
	;	sdIntimidatedRevMod = 30
	;	sdIntimidatedIntMod = 10
	;endif
	
	
	
	
Endfunction


Function CalculateScoreAndDiffuculty(Actor akSeducer, Actor akSeduced)

	CalculateScore(akSeducer, akSeduced)
	CalculateDifficulty(akSeducer, akSeduced)
	
	;debug.notification("Scores got calculated")
	debug.Trace("Everdamned INFO: Seduction score is: " + Seduction_Score)
	debug.Trace("Everdamned INFO: Seduction difficulty is: " + Seduction_Difficulty_Score)
	debug.Trace("Everdamned INFO: Intimidation score is: " + Intimidation_Score)
	debug.Trace("Everdamned INFO: Intimidation difficulty is: " + Intimidation_Difficulty_Score)
	debug.Trace("Everdamned INFO: Reveal score is: " + Reveal_Score)
	debug.Trace("Everdamned INFO: Reveal difficulty is: " + Reveal_Difficulty_Score)
	
	if ED_Mechanics_FeedDialogue_CalculateScoreOverride.GetValue() == 1
		debug.trace("Everdamned INFO: Feed dialogue score override engaged, not actually changing results")
		return
	endif
	
	if Seduction_Score >= Seduction_Difficulty_Score
		ED_Mechanics_FeedDialogue_SeductionResult.SetValue(1)
	else
		ED_Mechanics_FeedDialogue_SeductionResult.SetValue(0)
	endif
	
	if Intimidation_score >= Intimidation_Difficulty_Score
		ED_Mechanics_FeedDialogue_IntimidationResult.SetValue(1)
	elseif Intimidation_Difficulty_Score - Intimidation_score > 30.0
		; you failed in intimidation so bad you are a laughing stock, no assault
		ED_Mechanics_FeedDialogue_IntimidationResult.SetValue(0)
	else
		; target feels assaulted
		ED_Mechanics_FeedDialogue_IntimidationResult.SetValue(-1)
	endif
	
	if Reveal_Score >= Reveal_Difficulty_Score
		ED_Mechanics_FeedDialogue_RevealResult.SetValue(1)
	elseif akSeduced.GetRelationshipRank(akSeducer) >= 2 && Reveal_Difficulty_Score - Reveal_Score <= 30.0
		; target does not feel comfortable with you being a vampire, but they are your close friend and not gonna tell on you
		ED_Mechanics_FeedDialogue_RevealResult.SetValue(0)
	else
		; you were totally unconvincing, target is scared of you and calls for help
		ED_Mechanics_FeedDialogue_RevealResult.SetValue(-1)
	endif
	
	debug.Notification("Feed dialogue score calc finished")
	
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
Keyword Property VampireKeyword Auto

GlobalVariable Property ED_Mechanics_FeedDialogue_SeductionResult Auto
GlobalVariable Property ED_Mechanics_FeedDialogue_IntimidationResult Auto
GlobalVariable Property ED_Mechanics_FeedDialogue_RevealResult Auto
GlobalVariable Property ED_Mechanics_FeedDialogue_CalculateScoreOverride Auto
