Scriptname ED_DaylightController_Script extends ActiveMagicEffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	if aktarget == playerRef
		
		bool __inDirectSunlight = (ED_Mechanics_Global_EnableShadowRegen.GetValue() == 0 || \
				akTarget.GetLightLevel() >= 50.0) && \
				Weather.GetCurrentWeather().GetClassification() < 1
		debug.Trace("Everdamned DEBUG: Sunlight Controller determined that vamp is in direct sunlight")
		if __inDirectSunlight
			ED_Mechanics_Message_DaylightEncountered.Show()
		else
			ED_Mechanics_Message_DaylightEncounteredShaded.Show()
		endif
		VampireSunlightISMD04.applyCrossFade(2.0)
		MagVampireSunlight.Play(Game.GetPlayer())
		utility.wait(2.0)
		imageSpaceModifier.removeCrossFade()

	endif
endEvent


Sound Property MagVampireSunlight  Auto  
imageSpaceModifier Property VampireSunlightISMD04  Auto 
Message Property ED_Mechanics_Message_DaylightEncountered Auto
Message Property ED_Mechanics_Message_DaylightEncounteredShaded Auto
globalvariable property ED_Mechanics_Global_EnableShadowRegen auto

actor property playerRef auto
