Scriptname ED_TrembleEffect_Script extends ActiveMagicEffect  

;-- Properties --------------------------------------
Float property ED_PushForce auto


function OnEffectStart(Actor akTarget, Actor akCaster)

	;objectreference TheBox = akTarget.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
	;TheBox.MoveTo(akTarget as objectreference, 0 as Float, 0 as Float, SCS_FlipHeight, true)
	;akTarget.TranslateToRef(TheBox, SCS_FlipSpeed, 0.000000)
	;self.RegisterForAnimationEvent(akTarget as objectreference, SCS_AnimEvent)
	;utility.Wait(2.00000)
	;TheBox.Delete()
	
	akCaster.PushActorAway(akTarget, ED_PushForce)
	
endFunction

;function OnAnimationEvent(objectreference akSource, String asEventName)
;
;	SCS_Stagger.Cast(self.GetTargetActor() as objectreference, none)
;	self.Dispel()
;endFunction
