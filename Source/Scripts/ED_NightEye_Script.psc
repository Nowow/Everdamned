Scriptname ED_NightEye_Script extends ActiveMagicEffect


ImageSpaceModifier property IntroFX auto
ImageSpaceModifier property MainFX auto
ImageSpaceModifier property OutroFX auto

sound property IntroSoundFX auto 
sound property OutroSoundFX auto 

globalvariable property NightEyeTransitionGlobal auto

float property maxLightlevel = 90.0 auto
Float Property fImodStrength auto
float property fDelay auto
float property AdjustPerLevelSeconds = 0.5 auto

float __currentStrength
int __currentDarknessLevel = 5
int __nextDarknessLevel = 5
float __levelDiff
bool __finishing


ImageSpaceModifier[] property ImodArrayByStrength auto


int function GetDarknessLevel()
	float lightLevel = playerRef.GetLightLevel()
	
	float DarknessLevel = (maxLightlevel - lightLevel) / maxLightlevel

	if DarknessLevel > 1.0 
		DarknessLevel = 1.0
	elseif DarknessLevel <= 0.0
		DarknessLevel = 0.1 ; because ceiling
	endif
	
	return math.ceiling(DarknessLevel*10)
endfunction

Event OnEffectStart(Actor Target, Actor Caster)
	
	__currentDarknessLevel = GetDarknessLevel() - 1
	
	debug.Trace("Everdamned DEBUG: starting darkness level: " + __currentDarknessLevel)

	int instanceID = IntroSoundFX.play((target as objectReference))
	introFX.apply(1.0) 
	ImodArrayByStrength[__currentDarknessLevel].ApplyCrossFade(0.88)
	utility.wait(0.88)
	
	registerforsingleupdate(1)
	
EndEvent


event OnUpdate()
	__nextDarknessLevel = GetDarknessLevel() - 1
	__levelDiff = math.abs(__currentDarknessLevel - __nextDarknessLevel)
	if __levelDiff < 2
		registerforsingleupdate(1)
		return
	endif
	
	debug.Trace("Everdamned DEBUG: Vampires Sight darkness level changed from " + __currentDarknessLevel + " to " + __nextDarknessLevel)
	if __finishing
		return
	endif
	
	float __delay = __levelDiff*AdjustPerLevelSeconds

	int __old = __currentDarknessLevel - 0
	__currentDarknessLevel = __nextDarknessLevel
	ImodArrayByStrength[__nextDarknessLevel].ApplyCrossFade(__delay)
	utility.wait(__delay)
	ImodArrayByStrength[__old].Remove()
	
	
	if !__finishing
		registerforsingleupdate(1)
	endif
endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	
	__finishing = true
	int instanceID = OutroSoundFX.play((target as objectReference))         ; play OutroSoundFX sound from my self
	
	__currentStrength = 0.5*(__currentDarknessLevel + 1)/10.0
	ImodArrayByStrength[__currentDarknessLevel].PopTo(OutroFX, __currentStrength)
	
	debug.Trace("Everdamned DEBUG: Vampires Sight outro imod played at strength: " + __currentStrength)
	introFX.remove()

endEvent

actor property playerRef auto
