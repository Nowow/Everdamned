Scriptname ED_BloodTentacleTrapNoHavok_Script extends MovingTrap  



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

objectreference __anchor
objectreference __tanchor
actor __victim
spell SpellToHitThemWith
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
	__victim = victim
	__anchor = ED_TentacleAnchor.GetReference().placeatme(FXEmptyActivator)
	
	actor pl = Game.GetPlayer()
		
	__tanchor= victim.placeatme(FXEmptyActivator)
	
	__anchor.moveto(__anchor, 0, 0, 20.0)
	__tanchor.moveto(__tanchor, 0, 0, 20.0)
	ED_Art_Shader_BloodAnkh.Play(self, 10.0)

	self.Activate(Self)
endfunction


Function fireTrap()

	ResolveLeveledDamage()
	
	isFiring = True
	if WindupSound
		WindupSound.play( self as ObjectReference)		;play windup sound
	endif
	wait( initialDelay )		;wait for windup
	
	
	if (fireOnlyOnce == True)	;If this can be fired only once then disarm
		trapDisarmed = True
	endif

	
	;Trap Guts
	while(finishedPlaying == False && isLoaded == TRUE)
		;TRACE("playing anim Single")

		PlayAnimation("Trigger01")
		WaitForAnimationEvent(startDamage)
		finishedPlaying = True
		utility.wait(0.2)
		SpellToHitThemWith.cast(__anchor, __tanchor)
		TrapHitSound.play( self as ObjectReference)
		if hitFX
			hitFX.fire(self, hitFxAmmo)
		endif
		game.ShakeCamera(__tanchor, 0.5, 0.5)
		
		utility.wait(0.01)  ; cant cast without wait second spell for some reason
		ED_Mechanics_Spell_BloodTentacleHitHazard.cast(__anchor, __tanchor)
		
		
		;__victim.ProcessTrapHit(self, 10.0, 1000.0, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0, 0, 0.0)
		;WaitForAnimationEvent(stopDamage)
		WaitForAnimationEvent("done")
		if (loop == TRUE)			;Reset Limiter
			resetLimiter()
		endif
		wait(0.0)
	endWhile
	
	if isLoaded 	
		isFiring = false

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
		disable(true)
		delete()
	endEvent
	
	Event OnActivate( objectReference activateRef )
		lastActivateRef = activateRef
	EndEvent
	
endState



Function ResolveLeveledDamage()
	float damageLevel

	damageLevel = ED_Mechanics_SkillTree_Level_Global.GetValue()

	
		
	SpellToHitThemWith = ED_Mechanics_Spell_BloodTentacleHit_Level1
	
EndFunction

referencealias property ED_TentacleAnchor auto

activator property FXEmptyActivator auto
sound property TrapHitSound auto
actor property playerRef auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto

globalvariable property ED_TEST_Global1 auto
effectshader property ED_Art_Shader_BloodAnkh auto

spell property ED_Mechanics_Spell_BloodTentacleHit_Level1 auto
spell property ED_Mechanics_Spell_BloodTentacleHitHazard auto
spell[] property HitSpellArray auto

weapon property hitFX auto
ammo property hitFXAmmo auto