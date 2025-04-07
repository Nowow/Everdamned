Scriptname ED_Potence_DeadlyStrength extends ActiveMagicEffect  


float property originalJumpHeight auto
float property JumpBon auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	originalJumpHeight = Game.GetGameSettingFloat("fJumpHeightMin")
	JumpBon = 17.5 + ((VampireAge.value as int)*22.5)
	
	;debug.notification("Jump Bon is: " + JumpBon)
	Game.SetGameSettingFloat("fJumpHeightMin", 76+JumpBon)
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	JumpBon = 17.5 + ((VampireAge.value as int)*22.5)
	;debug.notification("Jump Bon is: " + JumpBon)
	if Game.GetGameSettingFloat("fJumpHeightMin") == 76+JumpBon
		Game.SetGameSettingFloat("fJumpHeightMin", originalJumpHeight)
	endif
Endevent

Event OnPlayerLoadGame()
	JumpBon = 17.5 + ((VampireAge.value as int)*22.5)
	;debug.notification("Jump Bon is: " + JumpBon)
	if Game.GetGameSettingFloat("fJumpHeightMin") == originalJumpHeight
		Game.SetGameSettingFloat("fJumpHeightMin", 76+JumpBon)
	endif
EndEvent

GlobalVariable Property VampireAge Auto
