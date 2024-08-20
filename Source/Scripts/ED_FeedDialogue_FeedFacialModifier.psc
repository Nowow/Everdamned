Scriptname ED_FeedDialogue_FeedFacialModifier extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster) 

ED_FacialExpression_Utils.ModifierTideDouble(akTarget, 0, 1, 95, 5)

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

MfgConsoleFunc.ResetPhonemeModifier(akTarget)

EndEvent

Faction Property ED_Mechanics_FeedDialogue_Fail_Fac  Auto  
