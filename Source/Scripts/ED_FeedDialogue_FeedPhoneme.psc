Scriptname ED_FeedDialogue_FeedPhoneme extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster) 

ED_FacialExpression_Utils.PhonemeTide(akTarget, 1, 60, 5)

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

MfgConsoleFunc.ResetPhonemeModifier(akTarget)

EndEvent
