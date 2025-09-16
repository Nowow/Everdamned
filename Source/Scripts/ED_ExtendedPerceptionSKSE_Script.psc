Scriptname ED_ExtendedPerceptionSKSE_Script extends activemagiceffect  


float property slowdownWorld auto
float property slowdownPlayer auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_SKSEnativebindings.SetTimeSlowdown(slowdownWorld, slowdownPlayer)
endevent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ED_SKSEnativebindings.SetTimeSlowdown(0.0, 0.0)
endevent
