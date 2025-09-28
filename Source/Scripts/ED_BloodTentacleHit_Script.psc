Scriptname ED_BloodTentacleHit_Script extends Quest  

function Slap()
	
	actor __victim = ED_Victim.GetReference() as actor
	debug.Trace("Everdamned DEBUG: Tentacle Hit Quest is hitting this guy: " + __victim)
	
	objectreference __tentacle = ED_Tentacle.GetReference()
	float __headingangle = __victim.GetHeadingAngle(__tentacle)
	
	;__tentacle.setscale(1)
	__tentacle.setangle(0.0, 0.0, __victim.GetAngleZ() + __headingangle)
	__tentacle.enable()
	
	ED_BloodTentacleTrap_Script TentacleScript = __tentacle as ED_BloodTentacleTrap_Script
	if !TentacleScript
		debug.Trace("Everdamned ERROR: Tentacle Hit Quest COULD NOT get ahold of tentacle script")
		stop()
		return
	endif
	
	__tentacle.placeatme(ED_Art_Explosion_Gutwrench_NoBones)
	TentacleScript.HitThatGuy(__victim)
	
	;__tentacle.disable()
	;__tentacle.delete()
	Stop()
endfunction

referencealias property ED_Victim auto
referencealias property ED_Tentacle auto
explosion property ED_Art_Explosion_Gutwrench_NoBones auto
