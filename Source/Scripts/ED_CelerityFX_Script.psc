Scriptname ED_CelerityFX_Script extends activemagiceffect  


float property slowdownWorld auto
float property slowdownPlayer auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_SKSEnativebindings.SetTimeSlowdown(slowdownWorld, GetMagnitude())
	debug.Notification(GetMagnitude())
endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ED_SKSEnativebindings.SetTimeSlowdown(0.0, 0.0)
	ED_Art_SoundM_CelerityOut.Play(akTarget)
	ED_Art_VFX_TimeDilationExplosion.play(akTarget, 3.0)
	;akTarget.placeatme(ED_Art_Explosion_TimeDilationShockwave)
endevent


visualeffect property ED_Art_VFX_TimeDilationExplosion auto
sound property ED_Art_SoundM_CelerityOut auto
