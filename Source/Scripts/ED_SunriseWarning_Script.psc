Scriptname ED_SunriseWarning_Script extends activemagiceffect  

message property ED_Mechanics_Message_SunriseWarning auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_Mechanics_Message_SunriseWarning.Show()
endevent
