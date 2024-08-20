Scriptname ED_FeedDialogue_Cooldown extends activemagiceffect  


Event OnEffectFinish(Actor akTarget, Actor akCaster)

debug.trace("Cooldown Effect finished, removing target from Dialogue Fail faction")
akTarget.SetFactionRank(ED_Mechanics_FeedDialogue_Fail_Fac, -1)

EndEvent

Faction Property ED_Mechanics_FeedDialogue_Fail_Fac  Auto  
