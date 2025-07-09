Scriptname ED_FeedDialogue_AnimFinishTrigger extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
RegisterForAnimationEvent(akTarget, "ed_seduction_touchHair_trigger")
EndEvent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)

	if (asEventName == "ed_seduction_touchHair_trigger")
		; to clip the animation that I cant edit
		debug.SendAnimationEvent(akSource, "ed_seduction_touchHair_forceNext")
    endif
	
EndEvent

Spell Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell auto
