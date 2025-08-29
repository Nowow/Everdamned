Scriptname ED_CelerityFX_Script extends activemagiceffect  


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ED_Art_SoundM_CelerityOut.Play(akTarget)
	akTarget.placeatme(ED_Art_Explosion_TimeDilationShockwave)
endevent


explosion property ED_Art_Explosion_TimeDilationShockwave auto
sound property ED_Art_SoundM_CelerityOut auto
