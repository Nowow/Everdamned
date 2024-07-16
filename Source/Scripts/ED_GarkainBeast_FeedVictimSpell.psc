Scriptname ED_GarkainBeast_FeedVictimSpell extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	(ED_PlayerVampireGarkainQuest as ED_PlayerVampireGarkainChangeScript).Feed(akTarget as Actor)
EndEvent

Quest Property ED_PlayerVampireGarkainQuest Auto
