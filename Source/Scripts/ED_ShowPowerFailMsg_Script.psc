Scriptname ED_ShowPowerFailMsg_Script extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_Mechanics_Message_PowerCantBeUsed.Show()
Endevent

message property ED_Mechanics_Message_PowerCantBeUsed auto
sound property MAGFail auto
