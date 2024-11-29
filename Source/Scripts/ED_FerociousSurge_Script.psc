Scriptname ED_FerociousSurge_Script extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SprintDrainValue = Game.GetGameSettingFloat("fSprintStaminaDrainMult")
	Game.SetGameSettingFloat("fSprintStaminaDrainMult",0.00)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Game.SetGameSettingFloat("fSprintStaminaDrainMult",SprintDrainValue)
EndEvent

Float Property SprintDrainValue Auto