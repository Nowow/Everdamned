;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 49
Scriptname PRKF_ED_Mechanics_Perk_Blood_040B87E4 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_45
Function Fragment_45(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(akTargetRef as actor).say(OuchTopic)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
akActor.playidlewithtarget(pa_ExtractWerewolfSpirit, akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_TEST_ExsanguinateExplosion_Spell.Cast(akActor, akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
debug.trace("ED TEST PERK BUTTON ACTIVATED")

;bool a = game.getplayer().PlayIdleWithTarget(pa_WereWolf_CutWrist, akTargetRef as Actor)

;debug.trace("RESULT: " + a)

debug.trace("Player is in control: " + game.getplayer().GetPlayerControls())
game.getplayer().startvampirefeed(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
somealias.forcerefto(aktargetref as actor)
somescene.start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ObjectReference TheBox
actor akTarget = akTargetRef as actor
;akTargetRef.ForceAddRagdollToWorld()
akActor.PushActorAway(akTarget, 1.0)
akTarget.SetActorValue("paralysis", 1)
akTargetRef.ApplyHavokImpulse(0.0, 0.0, 1.0, 200.0)
TheBox = akTargetRef.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
TheBox.MoveTo(akTargetRef, 0 as Float, 0 as Float, 500 as Float, true)

utility.wait(1.0)
akTargetRef.SplineTranslateToRef(TheBox, 10.0, 50.0, 0.000000)

utility.wait(10.0)
akTargetRef.StopTranslation()
TheBox.Delete()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
actor akTarget = akTargetRef as actor

akActor.PushActorAway(akTarget, 5.0)
utility.Wait(0.25)
akTarget.ApplyHavokImpulse(0 as Float, 0 as Float, 400 as Float, 500.0)



;SCS_VFX.Play(akTarget as objectreference, -1.00000, none)
;akTarget.SetGhost(true)
;akTarget.ApplyHavokImpulse(0 as Float, 0 as Float, 400 as Float, 500.0)
;utility.Wait(0.25)
;akTarget.EnableAI(false)
;utility.Wait(3.0)
	;SCS_Proc.RemoteCast(akTarget as objectreference, akCaster, none)
	;akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	;akTarget.SetAlpha(0.000000, true)
	;akTarget.AttachAshPile(SCS_Pile as form)
	;akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	;akTarget.EnableAI(true)
	;akTarget.SetGhost(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property pa_WereWolf_CutWrist  Auto  

SPELL Property ED_TEST_ExsanguinateExplosion_Spell  Auto  

Activator Property FXEmptyActivator  Auto  

Idle Property pa_ExtractWerewolfSpirit  Auto  

Topic Property OuchTopic  Auto  


Scene Property SOMESCENE  Auto  

ReferenceAlias Property SOMEALIAS  Auto  
