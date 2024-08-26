Scriptname ED_FeedDialogue_AnimFinishTrigger extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)

debug.Trace("Registred for animation finish event for actor " + akTarget)
RegisterForAnimationEvent(akTarget, "ed_seduction_flirtCustAnimFin")

EndEvent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
;     Debug.Trace("VAMPIRE: Getting anim event -- " + akSource + " " + asEventName)

    if (asEventName == "ed_seduction_flirtCustAnimFin")
		debug.Trace("Animation Finish event caught on " + akSource + ", removing trigger spell")
		(akSource as Actor).DispelSpell(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell)
    endif
EndEvent


Spell Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell auto
