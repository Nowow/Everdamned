Scriptname ED_BloodWine_Script extends activemagiceffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_FeedManager_Quest.HandleBloodWine()
endevent

ed_feedmanager_script property ED_FeedManager_Quest auto
