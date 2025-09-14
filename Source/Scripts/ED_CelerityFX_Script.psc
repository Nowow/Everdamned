Scriptname ED_CelerityFX_Script extends activemagiceffect  


float property slowdownWorld auto
float property slowdownPlayer auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_SKSEnativebindings.SetTimeSlowdown(slowdownWorld, slowdownPlayer)
endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ED_SKSEnativebindings.SetTimeSlowdown(0.0, 0.0)
	ED_Art_SoundM_CelerityOut.Play(akTarget)
	akTarget.placeatme(ED_Art_Explosion_TimeDilationShockwave)
endevent


explosion property ED_Art_Explosion_TimeDilationShockwave auto
sound property ED_Art_SoundM_CelerityOut auto
