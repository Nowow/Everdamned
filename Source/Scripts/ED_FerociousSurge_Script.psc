Scriptname ED_FerociousSurge_Script extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SprintDrainValue = Game.GetGameSettingFloat("fSprintStaminaDrainMult")
	Game.SetGameSettingFloat("fSprintStaminaDrainMult",0.00)
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Game.SetGameSettingFloat("fSprintStaminaDrainMult",SprintDrainValue)
EndEvent

float property XPgained auto
Float Property SprintDrainValue Auto