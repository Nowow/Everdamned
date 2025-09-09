Scriptname ED_RoyalGuardian_Script extends activemagiceffect  


float property retryDelay = 1.0 auto

bool __done
bool __questLaunched

function OnEffectStart(Actor akTarget, Actor akCaster)
	
	if ED_Mechanics_Quest_RoyalGuardian.IsStopped()
		debug.Trace("Everdamned DEBUG: Royal Guardian Quest: Passive Ability effect started, calling start ED_Mechanics_Quest_RoyalGuardian")
		__questLaunched = ED_Mechanics_Quest_RoyalGuardian.start()
		if !__questLaunched
			debug.Trace("Everdamned DEBUG: Royal Guardian passive failed to start quest, retry in " + retryDelay)
			RegisterForSingleUpdate(retryDelay)
		endif
	else
		debug.Trace("Everdamned WARNING: Royal Guardian passive activated, but quest is already running - probably should not have happened")
	endif
	
endfunction


event OnUpdate()
	if !__questLaunched && !__done
		debug.Trace("Everdamned DEBUG: Royal Guardian passive retries to start quest")
		__questLaunched = ED_Mechanics_Quest_RoyalGuardian.start()
		if !__questLaunched
			debug.Trace("Everdamned DEBUG: Royal Guardian passive failed to start quest, retry in " + retryDelay)
			RegisterForSingleUpdate(retryDelay)
		endif
	endif
endevent


function OnEffectFinish(Actor akTarget, Actor akCaster)
	__done = true
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest: Passive Ability effect ended, calling stop ED_Mechanics_Quest_RoyalGuardian")
	ED_Mechanics_Quest_RoyalGuardian.stop()
endfunction

Quest property ED_Mechanics_Quest_RoyalGuardian auto
