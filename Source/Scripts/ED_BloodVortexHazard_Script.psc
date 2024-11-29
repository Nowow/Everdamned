Scriptname ED_BloodVortexHazard_Script extends activemagiceffect  

actor _victim


function OnEffectStart(Actor akTarget, Actor akCaster)
	_victim = akTarget
endFunction

event OnDeath(actor akKiller)
	if _victim.HasMagicEffect(Exsanguinate_Effect)
		debug.Trace("Everdamned DEBUG: Blood Vortex Hazard does nothing on dying actor because it is being exsanguinated")
		return
	endif
	ED_BloodVortex.IncrementActorsDied()
endevent

MagicEffect property Exsanguinate_Effect auto
ED_BloodVortexAlias_Script Property ED_BloodVortex Auto  
