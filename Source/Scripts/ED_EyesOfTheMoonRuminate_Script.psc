Scriptname ED_EyesOfTheMoonRuminate_Script extends activemagiceffect  

int __stage
message __showNext_Message

bool __hasAllure
bool __hasPersuasion
bool __hasNobleClothes
bool __goodSpeech
bool __dibellaBlessing
bool __dibellaAmulet
bool __dibellaAgent
bool __usedIllusion
Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate effect started!")
	
	Game.ForceThirdPerson()
	Game.DisablePlayerControls(true, true, true, false, true, true, true, true)
	
	if playerRef.HasMagicEffect(ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate_Effect_StandingMarker)
		playerRef.PlayIdle(IdleStudy)
	endif
	FadeToBlackHoldImod.ApplyCrossFade(3.0)
	
	RegisterForSingleUpdate(4.0)
	
	MessageCache.Revert()
	
	__hasAllure = playerRef.HasPerk(Allure)
	__hasPersuasion = playerRef.HasPerk(Persuasion)
	__hasNobleClothes = playerRef.WornHasKeyword(ClothingRich)
	__goodSpeech = playerRef.GetActorValue("Speechcraft") >= 60.0
	__dibellaBlessing = playerRef.HasMagicEffect(FortifyPersuasionFFSelf)
	__dibellaAgent = playerRef.HasMagicEffect(PerkT01Dibella)
	__dibellaAmulet = playerRef.IsEquipped(ReligiousDibellaBeauty)
	
	if __hasAllure
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_Allure)
	endif
	if __hasPersuasion
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_Persuasion)
	endif
	if __hasNobleClothes
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_Clothes)
	endif
	if __goodSpeech
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_Speech)
	endif
	if __dibellaBlessing
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_DibellaBlessing)
	endif
	if __dibellaAmulet
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_DibellaAmulet)
	endif
	if __dibellaAgent
		MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Good_DibellaAgent)
	endif
	
	int __nextMessageIndex = utility.randomint(0, MessageCache.GetSize() - 1)
	__showNext_Message = MessageCache.GetAt(__nextMessageIndex) as message
	debug.Trace("Everdamned DEBUG: Message index: " + __nextMessageIndex + ", message: " + __showNext_Message)
	
endevent


bool __badTaken
bool __badSpeech
bool __badMood
bool __badLowRelationship
bool __badFaction
bool __badClothes
bool __adviceThane
bool __adviceSpeechEnch
bool __advicePerks
bool __adviceMood
bool __adviceInns
bool __adviceFaction
bool __adviceClothes
bool __adviceCharity
event OnUpdate()

	if __stage == 0
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 0")
		
		message.ResetHelpMessage("ed_ruminate_stage0")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage0", 5.0, 1.0, 1)
		
		RegisterForSingleUpdate(utility.randomfloat(7.0,8.5))
		
		MessageCache.Revert()
		
		__badClothes = !__hasNobleClothes
		__badSpeech = !__goodSpeech
		__badTaken = ConditionalsScript.Penalty_TargetHasSomeone
		__badLowRelationship = ConditionalsScript.Penalty_LowRelationship
		__badFaction = ConditionalsScript.Penalty_Faction
		__badMood = ConditionalsScript.Penalty_AIData
		
		if __badClothes
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Bad_Clothes)
		endif
		if __badSpeech
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Bad_Speech)
		endif
		if __badTaken
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Bad_Taken)
		endif
		if __badLowRelationship
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Bad_LowRelationship)
		endif
		if __badFaction
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Bad_Faction)
		endif
		if __badMood
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Bad_Mood)
		endif
		
		int __nextMessageIndex = utility.randomint(0, MessageCache.GetSize() - 1)
		__showNext_Message = MessageCache.GetAt(__nextMessageIndex) as message
		debug.Trace("Everdamned DEBUG: Message index: " + __nextMessageIndex + ", message: " + __showNext_Message)
		
		__stage = 1
		
	elseif __stage == 1
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 1")
		
		message.ResetHelpMessage("ed_ruminate_stage1")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage1", 5.0, 1.0, 1)
		
		RegisterForSingleUpdate(utility.randomfloat(7.0,8.5))
		
		MessageCache.Revert()
		
		__adviceThane = !(ConditionalsScript.Bonus_Thane)
		__advicePerks = !__hasPersuasion && !__hasAllure
		__adviceClothes = !__hasNobleClothes &&  __showNext_Message != ED_Mechanics_FeedDialogue_Message_Bad_Clothes
		__adviceMood = __showNext_Message != ED_Mechanics_FeedDialogue_Message_Bad_Mood
		__adviceCharity = !(ConditionalsScript.Bonus_GiftOfCharity)
		__adviceInns = true
		__adviceFaction = true
		__adviceSpeechEnch = true
		
		if __adviceThane
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Thane)
		endif
		if __advicePerks
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Perks)
		endif
		if __adviceClothes
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Clothes)
		endif
		if __adviceMood
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Mood)
		endif
		if __adviceCharity
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Charity)
		endif
		if __adviceInns
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Inns)
		endif
		if __adviceFaction
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Faction)
		endif
		if __adviceSpeechEnch
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_SpeechEnch)
		endif
		
		int __nextMessageIndex = utility.randomint(0, MessageCache.GetSize() - 1)
		__showNext_Message = MessageCache.GetAt(__nextMessageIndex) as message
		debug.Trace("Everdamned DEBUG: Message index: " + __nextMessageIndex + ", message: " + __showNext_Message)
		
		__stage = 2
	else
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 2 - final")
		
		message.ResetHelpMessage("ed_ruminate_stage2")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage2", 5.0, 1.0, 1)
		
		utility.wait(6.0)
		self.Dispel()
	endif

endevent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	
	ImageSpaceModifier.RemoveCrossFade(2.0)
	if playerRef.HasMagicEffect(ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate_Effect_StandingMarker)
		playerRef.PlayIdle(IdleStudy_exit)
	endif
	
	Game.EnablePlayerControls()
	
	playerRef.DispelSpell(ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate)
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate effect finished!")
endevent


idle property IdleStudy auto
idle property IdleStudy_exit auto
imagespacemodifier property FadeToBlackHoldImod auto
spell property ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate auto
magiceffect property ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate_Effect_StandingMarker auto
ED_FeedDialogueConditionals_Script property ConditionalsScript auto

formlist property MessageCache auto
message property ED_Mechanics_FeedDialogue_Message_Good_Speech auto
message property ED_Mechanics_FeedDialogue_Message_Good_Persuasion auto
message property ED_Mechanics_FeedDialogue_Message_Good_Illusion auto
message property ED_Mechanics_FeedDialogue_Message_Good_DibellaBlessing auto
message property ED_Mechanics_FeedDialogue_Message_Good_DibellaAmulet auto
message property ED_Mechanics_FeedDialogue_Message_Good_DibellaAgent auto
message property ED_Mechanics_FeedDialogue_Message_Good_Clothes auto
message property ED_Mechanics_FeedDialogue_Message_Good_Allure auto

message property ED_Mechanics_FeedDialogue_Message_Bad_Taken auto
message property ED_Mechanics_FeedDialogue_Message_Bad_Speech auto
message property ED_Mechanics_FeedDialogue_Message_Bad_Mood auto
message property ED_Mechanics_FeedDialogue_Message_Bad_LowRelationship auto
message property ED_Mechanics_FeedDialogue_Message_Bad_Faction auto
message property ED_Mechanics_FeedDialogue_Message_Bad_Clothes auto

message property ED_Mechanics_FeedDialogue_Message_Advice_Thane auto
message property ED_Mechanics_FeedDialogue_Message_Advice_SpeechEnch auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Perks auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Mood auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Inns auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Faction auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Clothes auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Charity auto

perk property Allure auto
perk property Persuasion auto
keyword property ClothingRich auto
magiceffect property PerkT01Dibella auto ; agent of dibella
magiceffect property FortifyPersuasionFFSelf auto  ; dibella's blessing
armor property ReligiousDibellaBeauty auto

actor property playerRef auto
