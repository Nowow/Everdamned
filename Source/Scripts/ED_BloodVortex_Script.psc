Scriptname ED_BloodVortex_Script extends activemagiceffect  


function OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Blood Vortex spell was cast")
	ED_Mechanics_Quest_BloodVortex.Start()	
endFunction


quest property ED_Mechanics_Quest_BloodVortex auto
