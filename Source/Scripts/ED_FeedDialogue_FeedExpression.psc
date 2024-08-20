Scriptname ED_FeedDialogue_FeedExpression extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster) 

ED_FacialExpression_Utils.EmotionalTide(akTarget, 10, 95, 15)

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

akTarget.ClearExpressionOverride()
EndEvent
