Scriptname ED_Potence_DeadlyStrength extends ActiveMagicEffect  

import math
import debug

float originalJumpHeight
float JumpBon

Event OnEffectStart(Actor akTarget, Actor akCaster)
	originalJumpHeight = Game.GetGameSettingFloat("fJumpHeightMin")
	JumpBon = -30.0 + (math.log(800.0*VampireAge.Value)*10.0) + (VampireAge.Value*7.0)
	debug.notification("Jump Bon is: " + JumpBon)
	Game.SetGameSettingFloat("fJumpHeightMin", 76+JumpBon)
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	JumpBon = -30.0 + (math.log(800.0*VampireAge.Value)*10.0) + (VampireAge.Value*7.0)
	debug.notification("Jump Bon is: " + JumpBon)
	if Game.GetGameSettingFloat("fJumpHeightMin") == 76+JumpBon
		Game.SetGameSettingFloat("fJumpHeightMin", originalJumpHeight)
	endif
Endevent

Event OnPlayerLoadGame()
	JumpBon = -30.0 + (math.log(800.0*VampireAge.Value)*10.0) + (VampireAge.Value*7.0)
	debug.notification("Jump Bon is: " + JumpBon)
	if Game.GetGameSettingFloat("fJumpHeightMin") == originalJumpHeight
		Game.SetGameSettingFloat("fJumpHeightMin", 76+JumpBon)
	endif
EndEvent

GlobalVariable Property VampireAge Auto
Float Property JumpBonus Auto
