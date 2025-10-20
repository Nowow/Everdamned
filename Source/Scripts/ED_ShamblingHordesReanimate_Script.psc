Scriptname ED_ShamblingHordesReanimate_Script extends activemagiceffect  


float property offsetBeforeAttemptingCapture auto
{Summon/Reanimate effects are cast upon caster, not target, and actual summoning and actor creation happens with lag}


bool _effectFinished
float _originalDuration
actor _commandedActor


function OnEffectStart(Actor akTarget, Actor akCaster)
	
	utility.wait(offsetBeforeAttemptingCapture)
	if _effectFinished
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell didnt try to capture commanded actor because effect finished faster than offset was waited")
		return
	endif
	
	_commandedActor = ED_SKSEnativebindings.GetActiveEffectCommandedActor(self)
	if _commandedActor
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell successfully captured commanded actor " + _commandedActor)
		_originalDuration = self.getduration()
		
		string _modEventName = "ed_RefreshCommandEffect" + _commandedActor.GetFormID() as string
		debug.Trace("Everdamned DEBUG: Registring for mod event: " + _modEventName) 
		RegisterForModEvent(_modEventName, "OnEDRefreshCommandEffectDuration")
		
	else
		debug.Trace("Everdamned DEBUG: Summon or reanimate spell failed to capture commanded actor")
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", 300.0)
	Game.AdvanceSkill("Conjuration", 100.0)
	
endFunction

event OnEDRefreshCommandEffectDuration(string eventName, string strArg, float numArg, Form sender)
	debug.Trace("Everdamned DEBUG: Got the OnEDRefreshCommandEffectDuration CALLBACK for actor " + _commandedActor)
		
	; prolongation based on original duration
	float _delta = math.ceiling(_originalDuration - (self.GetDuration() - self.GetTimeElapsed()))
	ED_SKSEnativebindings.IncreaseActiveEffectDuration(self, _delta)

endevent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	_effectFinished = true
endFunction


actor property playerRef auto
