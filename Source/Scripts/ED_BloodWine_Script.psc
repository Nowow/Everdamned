Scriptname ED_BloodWine_Script extends activemagiceffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_BloodStarved)
		message.ResetHelpMessage("ed_bloodwine_toothirsty")
		ED_Mechanics_Message_CantSateWithWine.ShowAsHelpMessage("ed_bloodwine_toothirsty", 5.0, 1.0, 1)
		
		return
		; TODO: add some SFX
	endif
	
	ED_Art_VFX_BloodWineIngestion.play(akTarget, 5.0)
	ED_FeedManager_Quest.HandleBloodWine()
endevent

ed_feedmanager_script property ED_FeedManager_Quest auto
keyword property ED_Mechanics_Keyword_BloodStarved auto
message property ED_Mechanics_Message_CantSateWithWine auto
visualeffect property ED_Art_VFX_BloodWineIngestion auto
