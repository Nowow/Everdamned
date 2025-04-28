Scriptname ED_ActorSelfDelete_Script extends activemagiceffect  


Event OnEffectFinish(Actor Target, Actor Caster)
	if ShouldKill
		Target.Kill()
	endif
	;with fadeout
	Target.Disable(true)
	Target.Delete()
EndEvent

bool property ShouldKill = true auto
