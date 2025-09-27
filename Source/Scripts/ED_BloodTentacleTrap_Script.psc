Scriptname ED_BloodTentacleTrap_Script extends MovingTrap

;
;
;This is the script for the blade trap
;Activating the trap causes it to toggle on and off
;If activated while in the process of stopping, it should be able to handle that.
;================================================================



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
		hitBase.goToState("CanHit")
		finishedPlaying = True
		WaitForAnimationEvent(stopDamage)
		hitBase.goToState("CannotHit")
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
	
	Event onTriggerEnter(ObjectReference triggerRef)
		if selfTrigger && acceptableTrigger(triggerRef)
			self.Activate(Self)
		endif
	endEvent
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
		GoToState ( "Idle" )
		hitBase = (self as objectReference) as TrapHitBase
		if hitbase
			hitBase.goToState("CannotHit")
		endif
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

