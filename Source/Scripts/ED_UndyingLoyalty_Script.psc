Scriptname ED_UndyingLoyalty_Script extends ActiveMagicEffect  


import ED_SKSEnativebindings

float property offsetBeforeAttemptingCapture auto
{Summon/Reanimate effects are cast upon caster, not target, and actual summoning and actor creation happens with lag}

bool _effectFinished
float _originalDuration
actor _commandedActor

;float property CommandedActorFormIdAsFloat auto

function OnEffectStart(Actor akTarget, Actor akCaster)
	
	utility.wait(offsetBeforeAttemptingCapture)
	if _effectFinished
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell didnt try to capture commanded actor because effect finished faster than offset was waited")
		return
	endif
	
	_commandedActor = GetActiveEffectCommandedActor(self)
	if _commandedActor
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell successfully captured commanded actor " + _commandedActor + ", forcing it to Undying Loyalty reference")
		actor currentServant = ED_UndyingLoyaltyServant1.GetReference() as actor
		if currentServant != None
			debug.Trace("Everdamned DEBUG: But Undying Servant reference is currently occupied")
			if currentServant.isDisabled()
				debug.Trace("Everdamned DEBUG: Previous Undying Servant was disabled, enabling and moving to player")
				currentServant.moveto(playerRef)
				currentServant.enable(true)
			endif
			if !(currentServant.isDead())
				debug.Trace("Everdamned DEBUG: Previous Undying Servant was not dead, killing it")
				currentServant.Kill()
			endif
		endif
		
		ED_UndyingLoyaltyServant1.ForceRefTo(_commandedActor)
	else
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell failed to capture commanded actor")
	endif
	
	
	
endFunction


function OnEffectFinish(Actor akTarget, Actor akCaster)
	_effectFinished = true
	;debug.Trace("Marching Flesh target effect finished on target: " + akTarget)
endFunction


ReferenceAlias Property ED_UndyingLoyaltyServant1  Auto  
actor property playerRef auto
