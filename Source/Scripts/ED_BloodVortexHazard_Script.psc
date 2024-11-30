Scriptname ED_BloodVortexHazard_Script extends activemagiceffect  

actor _victim


function OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Hazard spell effect started")
	_victim = akTarget
endFunction

event OnDying(actor akKiller)
	debug.Trace("Everdamned DEBUG: Hazard spell ONDEATH triggered")
	if _victim.HasMagicEffect(Exsanguinate_Effect)
		return
	endif
	ED_BloodVortex.IncrementActorsDied()
endevent

MagicEffect property Exsanguinate_Effect auto
MagicEffect property ED_Misc_BloodVortexHazard_Effect auto
ED_BloodVortexAlias_Script Property ED_BloodVortex Auto  
