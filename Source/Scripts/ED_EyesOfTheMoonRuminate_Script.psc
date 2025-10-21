Scriptname ED_EyesOfTheMoonRuminate_Script extends activemagiceffect  

bool __idlePlayed
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

bool __badTaken
bool __badSpeech
bool __badMood
bool __badLowRelationship
bool __badFaction
bool __badClothes
bool __badNothing

bool __adviceThane
bool __adviceSpeechEnch
bool __advicePerks
bool __adviceMood
bool __adviceInns
bool __adviceFaction
bool __adviceClothes
bool __adviceCharity
bool __adviceDibella
bool __adviceBloodDoll


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate effect started!")
	
	ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate_Cooldown.cast(playerRef)
	
	Game.ForceThirdPerson()
	Game.DisablePlayerControls(true, true, true, false, true, true, true, true)
	
	if playerRef.HasMagicEffect(ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate_Effect_StandingMarker)
		playerRef.PlayIdle(IdleStudy)
		__idlePlayed = true
	endif
	FadeToBlackHoldImod.ApplyCrossFade(3.0)
	
	RegisterForSingleUpdate(4.0)
	
	SpentCache.Revert()
	
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate chooses a Good Message at effect start")
	ChooseGoodMessage()
	if !__showNext_Message
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate found no matching Good Message, choosing Bad Message and setting __stage to 1")
		ChooseBadMessage()
		__stage = 1
	endif
	
endevent


event OnUpdate()
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate UPDATE event fired in stage: " + __stage)
		
	if __stage == 0
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 0, showing established message and then ChooseBadMessage()")
		
		message.ResetHelpMessage("ed_ruminate_stage0")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage0", 5.0, 1.0, 1)
		
		RegisterForSingleUpdate(utility.randomfloat(7.0,8.5))
		
		ChooseBadMessage()
		
		__stage = 1
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Proceeding to __stage " + __stage)
		
	elseif __stage == 1
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 1, showing established message and then ChooseAdvice()")
		
		message.ResetHelpMessage("ed_ruminate_stage1")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage1", 5.0, 1.0, 1)
		
		RegisterForSingleUpdate(utility.randomfloat(7.0,8.5))
		
		ChooseAdvice()
		
		if ConditionalsScript.LastScore_Category ==  4
			__stage = 2
			debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate found that you failed too bad last time, you'll get 2 advices")
		else
			__stage = 3
		endif
		
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Proceeding to __stage " + __stage)
		
		
	elseif __stage == 2
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 2, showing established message and then ChooseAdvice() once more")
		
		message.ResetHelpMessage("ed_ruminate_stage3")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage3", 5.0, 1.0, 1)
		RegisterForSingleUpdate(utility.randomfloat(7.0,8.5))
		
		SpentCache.AddForm(__showNext_Message)
		ChooseAdvice()
		
		__stage = 3
		
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Proceeding to __stage " + __stage)
		
	else
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - Ruminate state 3 - final, showing established message and dispelling")
		
		message.ResetHelpMessage("ed_ruminate_stage3")
		__showNext_Message.ShowAsHelpMessage("ed_ruminate_stage3", 5.0, 1.0, 1)
		
		utility.wait(6.0)
		self.Dispel()
	endif

endevent


function ChooseGoodMessage()
	
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - choosing a Good Message!")
	
	MessageCache.Revert()
	
	__hasAllure = playerRef.HasPerk(Allure) || ED_Mechanics_Global_MCM_AllureToggle.GetValue() == 1.0
	__hasPersuasion = playerRef.HasPerk(Persuasion) || ED_Mechanics_Global_MCM_PersuasionToggle.GetValue() == 1.0
	__hasNobleClothes = playerRef.WornHasKeyword(ClothingRich)
	__goodSpeech = playerRef.GetActorValue("Speechcraft") >= 60.0 && ConditionalsScript.LastScore_Category < 3
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
	
	int __cacheSize = MessageCache.GetSize()
	int __nextMessageIndex = utility.randomint(0, __cacheSize - 1)
	__showNext_Message = MessageCache.GetAt(__nextMessageIndex) as message
	debug.Trace("Everdamned DEBUG: Cache size: " + __cacheSize+ ", message index: " + __nextMessageIndex + ", message: " + __showNext_Message)

endfunction


function ChooseBadMessage()
	
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - choosing a Bad Message!")

	MessageCache.Revert()
		
	__badClothes = !__hasNobleClothes
	__badSpeech = playerRef.GetActorValue("Speechcraft") < 60.0
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
	
	int __cacheSize = MessageCache.GetSize()
	int __nextMessageIndex = utility.randomint(0, __cacheSize - 1)
	__showNext_Message = MessageCache.GetAt(__nextMessageIndex) as message
	debug.Trace("Everdamned DEBUG: Cache size: " + __cacheSize+ ", message index: " + __nextMessageIndex + ", message: " + __showNext_Message)
	
	if !__showNext_Message
		__badNothing = true
		
		__showNext_Message = ED_Mechanics_FeedDialogue_Message_Bad_Nothing
		debug.Trace("Everdamned DEBUG: Eyes of the Moon - ChooseBadMessage() found no bad message, displaying ED_Mechanics_FeedDialogue_Message_Bad_Nothing")
	endif
endfunction


function ChooseAdvice()
	
	debug.Trace("Everdamned DEBUG: Eyes of the Moon - choosing an Advice!")
	
	MessageCache.Revert()
		
	__adviceThane = !(ConditionalsScript.Bonus_Thane)
	__advicePerks = !__hasPersuasion && !__hasAllure
	__adviceClothes = !__hasNobleClothes &&  __showNext_Message != ED_Mechanics_FeedDialogue_Message_Bad_Clothes
	__adviceMood = __showNext_Message != ED_Mechanics_FeedDialogue_Message_Bad_Mood
	__adviceCharity = !(ConditionalsScript.Bonus_GiftOfCharity)
	__adviceInns = __badNothing
	__adviceFaction = true
	__adviceSpeechEnch = true
	__adviceDibella = !__dibellaBlessing || !__dibellaAgent || !__dibellaAmulet
	__adviceBloodDoll = true
	
	if __adviceThane
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Thane)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Thane)
		endif
	endif
	if __advicePerks
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Perks)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Perks)
		endif
	endif
	if __adviceClothes
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Clothes)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Clothes)
		endif
	endif
	if __adviceMood
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Mood)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Mood)
		endif
	endif
	if __adviceCharity
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Charity)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Charity)
		endif
	endif
	if __adviceInns
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Inns)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Inns)
		endif
	endif
	if __adviceFaction
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Faction)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Faction)
		endif
	endif
	if __adviceSpeechEnch
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_SpeechEnch)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_SpeechEnch)
		endif
	endif
	if __adviceDibella
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_Dibella)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_Dibella)
		endif
	endif
	if __adviceBloodDoll
		if !SpentCache.HasForm(ED_Mechanics_FeedDialogue_Message_Advice_BloodDoll)
			MessageCache.AddForm(ED_Mechanics_FeedDialogue_Message_Advice_BloodDoll)
		endif
	endif
	
	int __cacheSize = MessageCache.GetSize()
	int __nextMessageIndex = utility.randomint(0, __cacheSize - 1)
	__showNext_Message = MessageCache.GetAt(__nextMessageIndex) as message
	debug.Trace("Everdamned DEBUG: Cache size: " + __cacheSize+ ", message index: " + __nextMessageIndex + ", message: " + __showNext_Message)
endfunction


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	
	ImageSpaceModifier.RemoveCrossFade(2.0)
	if __idlePlayed
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
spell property ED_VampirePowers_EyesOfTheMoon_Spell_Ruminate_Cooldown auto
ED_FeedDialogueConditionals_Script property ConditionalsScript auto

formlist property MessageCache auto
formlist property SpentCache auto
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
message property ED_Mechanics_FeedDialogue_Message_Bad_Nothing auto


message property ED_Mechanics_FeedDialogue_Message_Advice_Thane auto
message property ED_Mechanics_FeedDialogue_Message_Advice_SpeechEnch auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Perks auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Mood auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Inns auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Faction auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Clothes auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Charity auto
message property ED_Mechanics_FeedDialogue_Message_Advice_Dibella auto
message property ED_Mechanics_FeedDialogue_Message_Advice_BloodDoll auto


Perk Property Allure Auto
globalvariable property ED_Mechanics_Global_MCM_AllureToggle auto
Perk Property Persuasion Auto
globalvariable property ED_Mechanics_Global_MCM_PersuasionToggle auto
keyword property ClothingRich auto
magiceffect property PerkT01Dibella auto ; agent of dibella
magiceffect property FortifyPersuasionFFSelf auto  ; dibella's blessing
armor property ReligiousDibellaBeauty auto

actor property playerRef auto
