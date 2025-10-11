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
float property AdjustPerLevelSeconds = 1.0 auto
float property StrengthModifier = 1.0 auto

float __currentStrength
int __currentDarknessLevel = 5
int __nextDarknessLevel = 5
float __levelDiff
bool __finishing



ImageSpaceModifier[] property ImodArrayByStrength auto
ImageSpaceModifier[] property ImodTransitionArray auto
ImageSpaceModifier[] property ImodStartArray auto

int MaxLevel
int MinLevel
int function GetDarknessLevel()
	float lightLevel = playerRef.GetLightLevel()
	
	float DarknessLevel = (maxLightlevel - lightLevel) / maxLightlevel
	
	;debug.Trace("Everdamned DEBUG: Darkness Percent raw: " + DarknessLevel )

	if DarknessLevel > 1.0 
		DarknessLevel = 1.0
	elseif DarknessLevel <= 0.0
		DarknessLevel = 0.1 ; because ceiling
	endif
	
	;debug.Trace("Everdamned DEBUG: Darkness Percent raw adjusted: " + DarknessLevel )
	
	int levell = math.ceiling(DarknessLevel*MaxLevel)
	if levell < MinLevel
		levell = MinLevel
	endif
	
	;debug.Trace("Everdamned DEBUG: Darkness Level raw: " + levell )
	
	return levell
endfunction

state AdaptiveDisabled
	int function GetDarknessLevel()
		return MaxLevel
	endfunction
	event OnUpdate()
	endevent
endstate

imagespacemodifier __lastImod
imagespacemodifier __nextImod
Event OnEffectStart(Actor Target, Actor Caster)
	
	StrengthModifier = ED_Mechanics_Global_MCM_NightSightStrengthMult.GetValue()
	MaxLevel = ED_Mechanics_Global_MCM_NightSightMaxLevel.GetValue() as int
	MinLevel = ED_Mechanics_Global_MCM_NightSightMinLevel.GetValue() as int
	
	if ED_Mechanics_Global_MCM_NightSightDisableAdaptive.GetValue() == 1.0
		debug.Trace("Everdamned Debug: Vampires Sight not adaptive")
		GoToState("AdaptiveDisabled")
	endif
	
	
	__currentDarknessLevel = GetDarknessLevel() - 1
	
	imagespacemodifier __startImod = ImodStartArray[__currentDarknessLevel]
	__nextImod = ImodArrayByStrength[__currentDarknessLevel]
	__lastImod = __nextImod
	
	debug.Trace("Everdamned DEBUG: starting darkness level: " + __currentDarknessLevel)

	int instanceID = IntroSoundFX.play((target as objectReference))
	
	; just blur and secondary stuff
	introFX.apply(1.0)
	__startImod.Apply(StrengthModifier)
	utility.wait(1.0)
	__startImod.PopTo(__nextImod, StrengthModifier)
	
	registerforsingleupdate(1)
	
EndEvent


event OnUpdate()
	__nextDarknessLevel = GetDarknessLevel() - 1
	debug.Trace("Everdamned DEBUG: Darkness Level adjusted: " + __nextDarknessLevel )
	;debug.Trace("Everdamned DEBUG: Current darkness level " + __nextDarknessLevel)
	__levelDiff = __currentDarknessLevel - __nextDarknessLevel
	
	if __levelDiff == 0
		registerforsingleupdate(1)
		return
	endif
	
	debug.Trace("Everdamned DEBUG: Vampires Sight darkness level changed from " + __currentDarknessLevel + " to " + __nextDarknessLevel)
	if __finishing
		return
	endif
	
	float __delay = math.abs(__levelDiff)*AdjustPerLevelSeconds + 0.2

	int __transImodIndex = 4*__currentDarknessLevel + __nextDarknessLevel
	if __levelDiff < 0
		__transImodIndex -= 1
	endif
	imagespacemodifier __transitionImod = ImodTransitionArray[__transImodIndex]	
	debug.Trace("Everdamned DEBUG: Vampires Sight transition IMAD index is: " + __transitionImod)
	
	
	__nextImod = ImodArrayByStrength[__nextDarknessLevel]
	
	__lastImod.PopTo(__transitionImod, StrengthModifier)
	utility.wait(__delay)
	__transitionImod.PopTo(__nextImod, StrengthModifier)
	
	;__nextImod.ApplyCrossFade(__delay)
	;utility.wait(__delay)
	;__lastImod.Remove()
	;__nextImod.PopTo(__nextImod)
	;ImageSpaceModifier.RemoveCrossFade()
	
	__currentDarknessLevel = __nextDarknessLevel
	__lastImod = __nextImod
	
	
	if !__finishing
		registerforsingleupdate(1)
	endif
endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	
	__finishing = true
	int instanceID = OutroSoundFX.play((target as objectReference))         ; play OutroSoundFX sound from my self
	
	;__currentStrength = 0.5*(__currentDarknessLevel + 1)/10.0
	__currentStrength = (__currentDarknessLevel + 1)/10.0  ; max half strength cuz
	ImodArrayByStrength[__currentDarknessLevel].PopTo(OutroFX, __currentStrength * StrengthModifier)
	
	debug.Trace("Everdamned DEBUG: Vampires Sight outro imod played at strength: " + __currentStrength)
	introFX.remove()

endEvent

actor property playerRef auto
globalvariable property ED_Mechanics_Global_MCM_NightSightDisableAdaptive auto
globalvariable property ED_Mechanics_Global_MCM_NightSightMaxLevel auto
globalvariable property ED_Mechanics_Global_MCM_NightSightMinLevel auto
globalvariable property ED_Mechanics_Global_MCM_NightSightStrengthMult auto
