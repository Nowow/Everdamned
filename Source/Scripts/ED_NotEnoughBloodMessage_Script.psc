Scriptname ED_NotEnoughBloodMessage_Script extends activemagiceffect  

message property ED_Mechanics_Message_NotEnoughBloodPoints auto

Event OnEffectStart(Actor Target, Actor Caster)
	ED_Mechanics_Message_NotEnoughBloodPoints.Show()
endevent
