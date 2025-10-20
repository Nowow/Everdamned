Scriptname ED_ReanimSummonCaptureActor_Script extends activemagiceffect  

import ED_SKSEnativebindings

float property offsetBeforeAttemptingCapture auto
{Summon/Reanimate effects are cast upon caster, not target, and actual summoning and actor creation happens with lag}

float property XPgained auto
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
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell successfully captured commanded actor " + _commandedActor)
		_originalDuration = self.getduration()
		
		;CommandedActorFormIdAsFloat = _commandedActor.GetFormID() as float
		;debug.Trace("Actor ID as float: " + CommandedActorFormIdAsFloat)
		;original duration, can be subject to change because of March Of Flesh
		
		string _modEventName = "ed_RefreshCommandEffect" + _commandedActor.GetFormID() as string
		debug.Trace("Everdamned DEBUG: Registring for mod event: " + _modEventName) 
		RegisterForModEvent(_modEventName, "OnEDRefreshCommandEffectDuration")
		
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
		
		Game.AdvanceSkill("Conjuration", 300.0)
		CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
		
	else
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell failed to capture commanded actor")
	endif
	
	
endFunction

event OnEDRefreshCommandEffectDuration(string eventName, string strArg, float numArg, Form sender)
	debug.Trace("Everdamned DEBUG: Got the OnEDRefreshCommandEffectDuration CALLBACK for actor " + _commandedActor)
	;debug.Trace("CommandedActorFormIdAsFloat: " + CommandedActorFormIdAsFloat + ", numArg: " + numArg)
	;if CommandedActorFormIdAsFloat == numArg
	;	debug.Trace("And FormID matched!")
		
		; prolongation based on original duration
	float _delta = math.ceiling(_originalDuration - (self.GetDuration() - self.GetTimeElapsed()))
	IncreaseActiveEffectDuration(self, _delta)
	;endif
	
endevent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	_effectFinished = true
	;debug.Trace("Marching Flesh target effect finished on target: " + akTarget)
endFunction

ReferenceAlias Property ED_UndyingLoyaltyServant1  Auto  
actor property playerRef auto