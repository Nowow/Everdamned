Scriptname ED_FeedDialogue_Script extends Quest  


GlobalVariable Property ED_Mechanics_FeedDialogue_SameSexRelationshipPreference_Setting Auto
GlobalVariable Property ED_Mechanics_FeedDialogue_DifficultyModifier_Setting Auto
GlobalVariable Property ED_Mechanics_FeedDialogue_CalculateScoreOverride Auto

GlobalVariable Property ED_Mechanics_FeedDialogue_SeductionResult Auto
;GlobalVariable Property ED_Mechanics_FeedDialogue_IntimidationResult Auto
;GlobalVariable Property ED_Mechanics_FeedDialogue_RevealResult Auto

actorbase[] property PersonalModifierIndexArray auto
int[] property PersonalModifierArray auto


int SeductionFactionScore

bool function CheckIfThanePrivilege(Actor akSeduced)

	faction CrimeFaction = akSeduced.GetCrimeFaction()
	
	If(CrimeFaction == CrimeFactionReach)

		if FavorJarlsMakeFriends.ReachImpGetOutofJail != 0 || FavorJarlsMakeFriends.ReachSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Reach, and Player is Thane there")
			return True
		endif		
	
	ElseIf(CrimeFaction == CrimeFactionRift)

		if FavorJarlsMakeFriends.RiftImpGetOutofJail != 0 || FavorJarlsMakeFriends.RiftSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Rift, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionHaafingar

		if FavorJarlsMakeFriends.HaafingarImpGetOutofJail != 0 || FavorJarlsMakeFriends.HaafingarSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Haafingar, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionWhiterun

		if FavorJarlsMakeFriends.WhiterunImpGetOutofJail != 0 || FavorJarlsMakeFriends.WhiterunSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Whiterun, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionEastmarch

		if FavorJarlsMakeFriends.EastmarchImpGetOutofJail != 0 || FavorJarlsMakeFriends.EastmarchSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Eastmarch, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionHjaalmarch

		if FavorJarlsMakeFriends.HjaalmarchImpGetOutofJail != 0 || FavorJarlsMakeFriends.HjaalmarchSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Hjaalmarch, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionPale

		if FavorJarlsMakeFriends.PaleImpGetOutofJail != 0 || FavorJarlsMakeFriends.PaleSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Pale, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionWinterhold

		if FavorJarlsMakeFriends.WinterholdImpGetOutofJail != 0 || FavorJarlsMakeFriends.WinterholdSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Winterhold, and Player is Thane there")
			return True
		endif
		
	ElseIf CrimeFaction == CrimeFactionFalkreath

		if FavorJarlsMakeFriends.FalkreathImpGetOutofJail != 0 || FavorJarlsMakeFriends.FalkreathSonsGetOutofJail != 0
			Debug.Trace("Everdamned INFO: Seduced is of Falkreath, and Player is Thane there")
			return True
		endif
		
	EndIf
	
	return False
	
endfunction

int function GetPersonalModifier(Actor akSeduced)

	actorbase NPC = akSeduced.GetActorBase()
	int PersonalModifierIndex = PersonalModifierIndexArray.Find(NPC)
	
	if PersonalModifierIndex >= 0
		int PersonalModifier = PersonalModifierArray[PersonalModifierIndex]
		debug.Trace("Everdamned INFO: Seduced has a personal modifier of " + PersonalModifier)
		return PersonalModifier
	endif 
	return 0
endfunction

int Function CalculateScore(Actor akSeducer, Actor akSeduced)

	int __playerSeductionScore =  akSeducer.GetAV("Speechcraft") as int
	
	; -110 if aquaintance, 0 if lover
	int __relationshipRank = akSeducer.GetRelationshipRank(akSeduced)
	
	; from -80 to 0
	if __relationshipRank > 0 || akSeduced.GetCurrentLocation().HasKeyword(LocTypeInn)
		__playerSeductionScore += (__relationshipRank * 20) - 80
		if __relationshipRank > 3
			ConditionalsScript.Bonus_HighRelationship = true
		endif
	;becomes -110
	else
		; you are unaquainted, really hard to seduce. separate fail responses
		__playerSeductionScore += -30
		ConditionalsScript.Penalty_LowRelationship = true
	endif
	
	
	; has parther that is not seducer
	bool seducedHasPartner = __relationshipRank < 4 && (akSeduced.HasAssociation(Spouse) || akSeduced.HasAssociation(Courting)) && !(akSeduced.HasAssociation(Spouse, akSeducer))
	if seducedHasPartner
		__playerSeductionScore += akSeduced.GetHighestRelationshipRank() * -10
		ConditionalsScript.Penalty_TargetHasSomeone = true
	endif
	
	; faction relationships
	CalculateFactionDifficulty(akSeducer, akSeduced)
	__playerSeductionScore += SeductionFactionScore
	
	; if BlueBlood
	if akSeduced.HasKeyword(ED_Mechanics_Keyword_BlueBlood_VIP)
		__playerSeductionScore += -20
	endif
	
	; personal modifiers
	__playerSeductionScore += GetPersonalModifier(akSeduced)

	; AI data
	
	
	
	__playerSeductionScore += -5 *  (akSeduced.GetAV("Morality") as int)
	__playerSeductionScore += -10 * (akSeduced.GetAV("Aggression") as int)
	
	int seducedCondifence = akSeduced.GetAV("Confidence") as int 
	if seducedCondifence == 0
		; cowardly
		__playerSeductionScore += -20
	endif
	
	; PERKS
	if akSeducer.HasPerk(Allure)
		__playerSeductionScore += 15
	endif
	
	if akSeducer.HasPerk(Persuasion)
		__playerSeductionScore += 10
	endif
	
	if akSeducer.HasPerk(HypnoticGaze)
		__playerSeductionScore += 10
	endif
	
	;if akSeducer.HasPerk(Intimidation)
	;	Intimidation_Intimidation_Score_Mod = 15
	;endif
	
	;if akSeducer.HasPerk(AspectOfTerror)
	;	Intimidation_AspectOfTerror_Score_Mod = 15
	;endif
	
	;CLOTHING
	if akSeducer.WornHasKeyword(ClothingRich)
		__playerSeductionScore += 20
		ConditionalsScript.Bonus_Clothes = true
	elseif akSeducer.WornHasKeyword(ClothingPoor)
		__playerSeductionScore += -20
	endif
	
	if akSeduced.WornHasKeyword(ClothingRich)
		__playerSeductionScore -= 20
		ConditionalsScript.Bonus_Clothes = false
	elseif akSeduced.WornHasKeyword(ClothingPoor)
		__playerSeductionScore += 20
	endif
	
	; if thane
	if CheckIfThanePrivilege(akSeduced)
		__playerSeductionScore += 20
		ConditionalsScript.Bonus_Thane = true
	endif
		
	;race match
	bool HasDibellasBlessing = akSeducer.HasMagicEffect(FortifyPersuasionFFSelf)
	
	string playerRace = akSeducer.GetLeveledActorBase().GetRace().GetName()
	string seducedRace = akSeduced.GetLeveledActorBase().GetRace().GetName()
	
	if playerRace != seducedRace
		if HasDibellasBlessing
			ConditionalsScript.Bonus_Dibella = true
		else
			__playerSeductionScore += -10
		endif
	endif 
	
	int pc_sex
	int target_sex
	int same_sex_pref 
	pc_sex = akSeducer.GetLeveledActorBase().GetSex()
	target_sex = akSeduced.GetLeveledActorBase().GetSex()
	same_sex_pref = ED_Mechanics_FeedDialogue_SameSexRelationshipPreference_Setting.GetValue() as int
	
	if (same_sex_pref == 1 && pc_sex == target_sex) || (same_sex_pref == 0 && pc_sex != target_sex)
		__playerSeductionScore += 10
		; agent of dibella
		if akSeducer.HasMagicEffect(PerkT01Dibella)
			__playerSeductionScore += 10
			ConditionalsScript.Bonus_Dibella = true
		endif
	endif	
	
	__playerSeductionScore += ED_Mechanics_FeedDialogue_DifficultyModifier_Setting.GetValue() as int
	
	; add some random
	__playerSeductionScore += Utility.RandomInt(-10,10)
	
	; also ork scary
	;if ED_Mechanics_OrcRace_List.HasForm(akSeducer.GetLeveledActorBase().GetRace()) && !ED_Mechanics_OrcRace_List.HasForm(akSeduced.GetLeveledActorBase().GetRace())
	;	Intimidation_Race_Score_Mod = 15
	;endif

	;if akSeducer.GetFactionReaction(akSeduced) == 2
	;	Reveal_SameFaction_Score_Mod = 25
	;endif	

	return __playerSeductionScore
Endfunction


function CalculateFactionDifficulty(Actor akSeducer, Actor akSeduced)


	;--------------------------------------------------
	;Factions
	
	if (akSeduced.IsInFaction(DLC1HunterFaction) || akSeduced.IsInFaction(VigilantOfStendarrFaction))
		
			SeductionFactionScore += -40

	elseif akSeduced.IsInFaction(GreybeardFaction)
			
			SeductionFactionScore += -40

	;elseif (akSeduced.IsInFaction(GuardDialogueFaction) || akSeduced.IsInFaction(CWDialogueSoldierFaction) || akSeduced.IsInFaction(BanditFaction) || akSeduced.IsInFaction(PenitusOculatusFaction) || akSeduced.IsInFaction(GovImperial) || akSeduced.IsInFaction(GovRuling) || akSeduced.IsInFaction(GovSons))


	;--------------------------------------------------
	;temples
	
	elseif akSeduced.IsInFaction(MarkarthTempleofDibellaFaction)
		
			SeductionFactionScore += 30
	
	;elseif (akSeduced.IsInFaction(RiftenTempleofMaraFaction) || akSeduced.IsInFaction(SolitudeTempleoftheDivinesFaction) || akSeduced.IsInFaction(WhiterunTempleofKynarethFaction) || akSeduced.IsInFaction(WindhelmTempleFaction) ||akSeduced.IsInFaction(JobPriestFaction))
	
	
	;--------------------------------------------------
	;jobs
	
	elseif akSeduced.IsInFaction(JobBardFaction)
	
		SeductionFactionScore += 20
	
	elseif akSeduced.IsInFaction(FavorJobsBeggarsFaction)
			
			bool PlayerHasCharityBuff = akSeducer.HasMagicEffectWithKeyword(USKPGiftOfCharity)
			
			if PlayerHasCharityBuff
				SeductionFactionScore += 20
			endif
	
	elseif akSeduced.IsInFaction(JobJarlFaction)
			
			SeductionFactionScore += -30
			
	;elseif (akSeduced.IsInFaction(JobCourtWizardFaction) || akSeduced.IsInFaction(CollegeofWinterholdFaction))
	
	
	;--------------------------------------------------
	;Guilds
	
	elseif akSeduced.IsInFaction(ThievesGuildFaction)
			
			SeductionFactionScore += 10
	
	elseif akSeduced.IsInFaction(CompanionsCirclePlusKodlak)
			
			SeductionFactionScore += 20
	
	;elseif akSeduced.IsInFaction(DarkBrotherhoodFaction)
	
		
	endif

endfunction

bool __finished = true
Function RollFeedDialogueChecks(Actor akSeducer, Actor akSeduced)
	__finished = false
	
	
	; setting this asap to win the race condition with ForceGreet idle ;)
	int __relationshipRank = akSeducer.GetRelationshipRank(akSeduced)
	if !(akSeduced.IsInFaction(ED_Mechanics_FeedDialogue_Seduced_Fac))
		if __relationshipRank <= 1
			; guarded 1,2,5,6
			ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(1)
		else
			; serious 3,4,7,8
			ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(3)
		endif
	else
		;all else
		ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(9,16))
	endif

	if akSeduced.IsInFaction(PlayerMarriedFaction)
		ED_Mechanics_FeedDialogue_SeductionResult.SetValue(1)
		ConditionalsScript.SetLastScore(100)
		debug.Trace("Everdamned INFO: Seduced is married to player, not calculating score, auto success")
		__finished = true
		return
	endif
	
	int PlayerSeductionScore = CalculateScore(akSeducer, akSeduced)
	
	debug.Trace("Everdamned INFO: Seduction score is: " + PlayerSeductionScore)
	
	ConditionalsScript.SetLastScore(PlayerSeductionScore)
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue LastScore: " + ConditionalsScript.LastScore)
	debug.Trace("Everdamned DEBUG: Feed Dialogue LastScore_Category: " + ConditionalsScript.LastScore_Category)
	debug.Trace("Everdamned DEBUG: Feed Dialogue Bonus_Dibella: " + ConditionalsScript.Bonus_Dibella)
	debug.Trace("Everdamned DEBUG: Feed Dialogue Bonus_Clothes: " + ConditionalsScript.Bonus_Clothes)
	debug.Trace("Everdamned DEBUG: Feed Dialogue Bonus_Thane: " + ConditionalsScript.Bonus_Thane)
	debug.Trace("Everdamned DEBUG: Feed Dialogue Bonus_HighRelationship: " + ConditionalsScript.Bonus_HighRelationship)
	debug.Trace("Everdamned DEBUG: Feed Dialogue Penalty_TargetHasSomeone: " + ConditionalsScript.Penalty_TargetHasSomeone)
	debug.Trace("Everdamned DEBUG: Feed Dialogue Penalty_LowRelationship: " + ConditionalsScript.Penalty_LowRelationship)

	if ED_Mechanics_FeedDialogue_CalculateScoreOverride.GetValue() == 1
		debug.trace("Everdamned INFO: Feed dialogue score override engaged, not actually changing results")
		__finished = true
		return
	endif
	
	if PlayerSeductionScore >= 0
		
		bool __isFemale = akSeduced.GetActorBase().GetSex() == 1
		; painful...
		if akSeduced.IsInFaction(PlayerMarriedFaction)
			if __isFemale
				debug.Trace("Everdamned DEBUG: Feed Dialogue sets NPC animation to female spouse")
				ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(12,17))
			else
				debug.Trace("Everdamned DEBUG: Feed Dialogue sets NPC animation to male spouse")
				ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(11,15))
			endif
		elseif !(akSeduced.IsInFaction(ED_Mechanics_FeedDialogue_Seduced_Fac))
			if __relationshipRank <= 1
				; guarded
				debug.Trace("Everdamned DEBUG: Feed Dialogue sets NPC animation to low relationship guarded success")
				ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(5,6))
			else
				; serious
				debug.Trace("Everdamned DEBUG: Feed Dialogue sets NPC animation to high relationship serious success")
				ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(7,8))
			endif
		else
			if __isFemale
			debug.Trace("Everdamned DEBUG: Feed Dialogue sets NPC animation to seduced female")
				ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(9,17))
			else
				debug.Trace("Everdamned DEBUG: Feed Dialogue sets NPC animation to seduced male")
				ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(9,15))
			endif
		endif
		
		ED_Mechanics_FeedDialogue_SeductionResult.SetValue(1)
	else
		if __relationshipRank <= 1
			ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(1,2))
		else
			ED_Mechanics_FeedDialogue_NPCSequenceIndex.SetValue(utility.RandomInt(3,4))
		endif
		
		ED_Mechanics_FeedDialogue_SeductionResult.SetValue(0)
	endif
	
	__finished = true
	
	
	
	;if Intimidation_score >= Intimidation_Difficulty_Score
	;	ED_Mechanics_FeedDialogue_IntimidationResult.SetValue(1)
	;elseif Intimidation_Difficulty_Score - Intimidation_score > 30.0
	;	; you failed in intimidation so bad you are a laughing stock, no assault
	;	ED_Mechanics_FeedDialogue_IntimidationResult.SetValue(0)
	;else
	;	; target feels assaulted
	;	ED_Mechanics_FeedDialogue_IntimidationResult.SetValue(-1)
	;endif
	
	;if Reveal_Score >= Reveal_Difficulty_Score
	;	ED_Mechanics_FeedDialogue_RevealResult.SetValue(1)
	;elseif akSeduced.GetRelationshipRank(akSeducer) >= 2 && Reveal_Difficulty_Score - Reveal_Score <= 30.0
	;	; target does not feel comfortable with you being a vampire, but they are your close friend and not gonna tell on you
	;	ED_Mechanics_FeedDialogue_RevealResult.SetValue(0)
	;else
	;	; you were totally unconvincing, target is scared of you and calls for help
	;	ED_Mechanics_FeedDialogue_RevealResult.SetValue(-1)
	;endif
	
Endfunction


function WaitForScoreCalcToFinish()
	int __failsafeCounter
	while !__finished && __failsafeCounter <= 150
		__failsafeCounter += 1
		utility.wait(0.1)
	endwhile
	
	if __failsafeCounter > 150
		debug.Trace("Everdamned WARNING: Feed Dialogue score calc waiter waiter more than 15 sec for score calc, something went wrong")
	endif
	
	; walkaway can still happen, but seduction was successfully applied/failed
	ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState.SetValue(1)

endfunction

FavorJarlsMakeFriendsScript property FavorJarlsMakeFriends auto

globalvariable property ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState auto
globalvariable property ED_Mechanics_FeedDialogue_NPCSequenceIndex auto


associationtype property Spouse auto
associationtype property Courting auto

keyword property ED_Mechanics_Keyword_BlueBlood_VIP auto
keyword property USKPGiftOfCharity auto
Keyword Property ClothingRich Auto
Keyword Property ClothingPoor Auto
Keyword Property VampireKeyword Auto
keyword property LocTypeInn auto

magiceffect property FortifyPersuasionFFSelf auto
magiceffect property PerkT01Dibella auto

Perk Property Allure Auto
Perk Property Persuasion Auto
Perk Property HypnoticGaze Auto
Perk Property Intimidation Auto
Perk Property MasterOfTheMind Auto
Perk Property AspectOfTerror Auto
Perk Property Rage Auto

; crime factions
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionRift Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionEastmarch Auto
Faction Property CrimeFactionHjaalmarch Auto
Faction Property CrimeFactionPale Auto
Faction Property CrimeFactionWinterhold Auto
Faction Property CrimeFactionFalkreath Auto

; spouse
Faction Property PlayerMarriedFaction auto

; seduced faction
faction property ED_Mechanics_FeedDialogue_Seduced_Fac auto

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
Faction property JobBardFaction auto

FormList Property ED_Mechanics_OrcRace_List Auto

ED_FeedDialogueConditionals_Script property ConditionalsScript auto

