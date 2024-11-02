Scriptname ED_FeedDialogue_SmileSpell extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster) 
akTarget.SetExpressionOverride(10, 100)
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
akTarget.ClearExpressionOverride()
EndEvent
