Scriptname ED_FeedDialogue_AnimFinishTrigger extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)

debug.Trace("Registred for animation finish event for actor " + akTarget)
RegisterForAnimationEvent(akTarget, "ed_seduction_customAnimFin")
RegisterForAnimationEvent(akTarget, "ed_seduction_touchHair_trigger")
;RegisterForAnimationEvent(akTarget, "Soundplay")
RegisterForAnimationEvent(akTarget, "Soundplay.NPCHumanSitChairDownLR")

EndEvent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    Debug.Trace("VAMPIRE: Getting anim event -- " + akSource + " " + asEventName)

	if (asEventName == "ed_seduction_touchHair_trigger")
		; to clip the animation that I cant edit
		debug.SendAnimationEvent(akSource, "ed_seduction_flirt_touchHair_forceNext")
		
    elseif (asEventName == "ed_seduction_customAnimFin")
		debug.Trace("Animation Finish event caught on " + akSource + ", removing trigger spell")
		;(akSource as Actor).DispelSpell(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell)
    endif
	
EndEvent

Spell Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell auto
