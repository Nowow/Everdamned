Scriptname ED_BloodVortexHazard_Script extends activemagiceffect  

actor _victim


function OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Hazard spell effect started")
	_victim = akTarget
endFunction


bool __onDyingTriggered
event OnDying(actor akKiller)
	if __onDyingTriggered
		return
	endif
	__onDyingTriggered = true
	
	debug.Trace("Everdamned DEBUG: Blood Vortex Hazard spell ONDEATH triggered")

	if _victim.HasMagicEffect(Exsanguinate_Effect)
		debug.Trace("Everdamned DEBUG: Blood Vortex does not increment for " + _victim + ", because it is being Exsanguinated now")
		__onDyingTriggered = false
		return
	endif
	
	if ED_Mechanics_Quest_BloodVortex.IsRunning()
		ED_Mechanics_Quest_BloodVortex.SetCurrentStageId(50)
	endif
	
endevent


MagicEffect property Exsanguinate_Effect auto
quest Property ED_Mechanics_Quest_BloodVortex Auto  
