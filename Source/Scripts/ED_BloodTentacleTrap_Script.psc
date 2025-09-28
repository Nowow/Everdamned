Scriptname ED_BloodTentacleTrap_Script extends MovingTrap

;
;
;This is the script for the blade trap
;Activating the trap causes it to toggle on and off
;If activated while in the process of stopping, it should be able to handle that.
;================================================================

ED_BloodTentacleTrapHit_Script property ED_TrapHitBase auto hidden

import debug
import utility
	
;If Loop is true, it swings until activated again.
;If Loop is false, it swings once when activated.
bool restartLooping = false
bool finishedPlaying = false
float property initialDelay = 0.25 auto
bool property selfTrigger = true auto
{If this is true, then the trap will trigger when you enter the baked in trigger volume
	Default = TRUE}
string property startDamage = "startDamage" auto hidden
string property stopDamage = "stopDamage" auto hidden
;-----------------------------------


function HitThatGuy(actor victim)
	int counter
	debug.Trace("Everdamned DEBUG: HitThatGuy called! " + self)
	while !is3dloaded() && counter < 50
		counter += 1
		utility.wait(0.1)
	endwhile
	
	debug.Trace("Everdamned DEBUG: HitThatGuy 3d loaded????! " + is3dloaded())
		
	if counter >= 50
		debug.Trace("Everdamned ERROR: Blood Tentacle ref couldnt load 3d for 5 seconds for some reason")
		disable()
		delete()
		return
	endif
	
	self.Activate(Self)
endfunction


Function fireTrap()
	;PlayAnimationAndWait( "reset", "off" )
	;Basic wind up and fire once checking
	;TRACE("fireTrap called")
	ResolveLeveledDamage()
	
	isFiring = True
	if WindupSound
		WindupSound.play( self as ObjectReference)		;play windup sound
	endif
	wait( initialDelay )		;wait for windup
	;TRACE("Initial Delay complete")
	
	if (fireOnlyOnce == True)	;If this can be fired only once then disarm
		trapDisarmed = True
	endif
	
	;TRACE("Looping =")
	;TRACE(Loop)
	
	;Trap Guts
	while(finishedPlaying == False && isLoaded == TRUE)
		;TRACE("playing anim Single")

		PlayAnimation("Trigger01")
		WaitForAnimationEvent(startDamage)
		ED_TrapHitBase.goToState("CanHit")
		finishedPlaying = True
		WaitForAnimationEvent(stopDamage)
		ED_TrapHitBase.goToState("CannotHit")
		WaitForAnimationEvent("done")
		if (loop == TRUE)			;Reset Limiter
			resetLimiter()
		endif
		wait(0.0)
	endWhile
	
	if isLoaded 	
		isFiring = false
		;hitBase.goToState("CannotHit")
		;PlayAnimationAndWait( "reset", "off" )
		goToState("Reset")
	endif
	
endFunction

Function ResetLimiter()
	finishedPlaying = False
EndFunction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
auto State Idle
	
	event onActivate (objectReference activateRef)
		debug.Trace("Everdamned DEBUG: Blood Tentacle in Idle state onActivate triggered by: " + activateRef)
		lastActivateRef = activateRef

		GoToState ( "DoOnce" )							
		ResetLimiter()
		FireTrap()

	endevent
	
;	Event onTriggerEnter(ObjectReference triggerRef)
;		if selfTrigger && acceptableTrigger(triggerRef)
;			self.Activate(Self)
;		endif
;	endEvent
endstate

State DoOnce															;Type Do Once
	
	Event OnActivate( objectReference activateRef )
		debug.Trace("Everdamned DEBUG: Blood Tentacle in DoOnce state onActivate triggered by: " + activateRef)
		lastActivateRef = activateRef
		
	EndEvent

endstate

State Reset

	Event OnBeginState()
		overrideLoop = True
		ED_TrapHitBase.goToState("CannotHit")
		disable(true)
		delete()
		;GoToState ( "Idle" )
		;hitBase = (self as objectReference) as TrapHitBase
		;if hitbase
		;	hitBase.goToState("CannotHit")
		;endif
	endEvent
	
	Event OnActivate( objectReference activateRef )
		lastActivateRef = activateRef
	EndEvent
	
endState



faction property owningFaction Auto
actorBase property owningActorBase Auto


bool function acceptableTrigger(objectReference triggerRef)

	debug.Trace("Everdamned DEBUG: Blood Tentacle is checking " + triggerRef + " to see if its acceptable")
	
	actor triggerActor = triggerRef as actor
	
	if !triggerActor	;if this is not a player only trigger and this is not an actor
		return True
	elseif owningFaction
		if triggerActor.IsInFaction(owningFaction)
 				debug.Trace("Everdamned DEBUG: Blood Tentacle found that trigger actor is in owning faction")
			return False
		else
				debug.Trace("Everdamned DEBUG: Blood Tentacle found that trigger actor is OK")
				Return True
		endif
	else
		if owningActorBase
			if triggerActor.getActorBase() == owningActorBase
				debug.Trace("Everdamned DEBUG: Blood Tentacle found that trigger actor is THE owning NPC")
				return False
			Else
				debug.Trace("Everdamned DEBUG: Blood Tentacle found that trigger actor is OK")
				Return True
			endif
		else
			Return True
		endif
	endif

endFunction

;int Function ResolveLeveledDamage (int damage)
Function ResolveLeveledDamage()
	int damageLevel
	int damage
	damageLevel = CalculateEncounterLevel(TrapLevel)
	
	damage = LvlDamage1
	
	if (damageLevel > LvlThreshold1 && damageLevel <= LvlThreshold2)
		damage = LvlDamage2
		;Trace("damage threshold =")
		;Trace("2")
	endif
	if (damageLevel > LvlThreshold2 && damageLevel <= LvlThreshold3)
		damage = LvlDamage3
		;Trace("damage threshold =")
		;Trace("3")
	endif
	if (damageLevel > LvlThreshold3 && damageLevel <= LvlThreshold4)
		damage = LvlDamage4
		;Trace("damage threshold =")
		;Trace("4")
	endif
	if (damageLevel > LvlThreshold4 && damageLevel <= LvlThreshold5)
		damage = LvlDamage5
		;Trace("damage threshold =")
		;Trace("5")
	endif
	if (damageLevel > LvlThreshold5)
		damage = LvlDamage6
		;Trace("damage threshold =")
		;Trace("6")
	endif
	
	;Trace("damage =")
	;Trace(damage)
	
	;return damage
	;hitBase = (self as objectReference) as TrapHitBase
	;if hitbase
	;	hitBase.damage = damage
	;endif
	
	ED_TrapHitBase = (self as objectReference) as ED_BloodTentacleTrapHit_Script
	if ED_TrapHitBase
		ED_TrapHitBase.damage = damage
	endif
	
EndFunction

