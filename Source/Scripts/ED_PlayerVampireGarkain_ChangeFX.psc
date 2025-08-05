Scriptname ED_PlayerVampireGarkain_ChangeFX extends ActiveMagicEffect  

Race Property ED_VampireGarkainBeastRace auto

VisualEffect property FeedBloodVFX auto
Idle Property IdleVampireTransformation auto
Explosion Property FXVampChangeExplosion auto
VisualEffect property ED_Art_VFX_VampireTransform_Begin auto
hazard property ED_Art_Hazard_VampireTransformBats auto


Quest Property ED_PlayerVampireGarkainQuest auto

bool __transforming

Event OnEffectStart(Actor Target, Actor Caster)
;     Debug.Trace("VAMPIRE: Starting change anim...")

    if (Target.GetActorBase().GetRace() != ED_VampireGarkainBeastRace)
		; Add the tranformation wolf skin Armor effect 
		; Target.equipitem(VampireSkinFXArmor,False,True)
		
			
			RegisterForAnimationEvent(Target, "SetRace")
			
			objectreference __prop = Target.placeatme(ED_Art_Hazard_VampireTransformBats)
			ED_Art_VFX_VampireTransform_Begin.Play(__prop, 10)
			;ED_Art_VFX_VampireTransform_BatCloak.Play(__prop, 6.0)
			Target.PlayIdle(IdleVampireTransformation)
			Utility.Wait(3.0)
			;ED_Art_VFX_VampireTransform_Begin.Play(__prop, 6.0)
			
			Utility.Wait(7.0)
			TransformIfNecessary(Target)
        
    endif
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
;     Debug.Trace("VAMPIRE: Getting anim event -- " + akSource + " " + asEventName)
    if (asEventName == "SetRace")
        TransformIfNecessary(akSource as Actor)
    endif
EndEvent

Function TransformIfNecessary(Actor Target)
	if __transforming
		return
	endif
	__transforming = true
	
	if (Target == None)
; 		Debug.Trace("VAMPIRE: Trying to transform something that's not an actor; bailing out.", 2)
		return
	endif

	UnRegisterForAnimationEvent(Target, "SetRace")

	Actor PlayerRef = Game.GetPlayer()
	Race currRace = Target.GetRace()

	if (currRace != ED_VampireGarkainBeastRace)
; 		Debug.Trace("VAMPIRE: VISUAL: Setting race " + ED_VampireGarkainBeastRace + " on " + Target)

		if Target != PlayerRef
; 			Debug.Trace("VAMPIRE: VISUAL: Target is not player, doing the transition here.")
			Target.SetRace(ED_VampireGarkainBeastRace)
		else
			ED_PlayerVampireGarkainQuest.SetStage(1)
        endif

		; I added this explosion and blood to give the transition some pop!
		target.placeatme(FXVampChangeExplosion)
		if target == PlayerRef
			DLC1VampireChangeStagger.Cast(Target, Target)
		endif

		if Target == PlayerRef || Target.GetDistance(PlayerRef) < 300
			utility.Wait(0.33)
			Game.TriggerScreenBlood(5)
			utility.Wait(0.1)
			Game.TriggerScreenBlood(10)
		endif
		
    endif

EndFunction

SPELL Property DLC1VampireChangeStagger  Auto  