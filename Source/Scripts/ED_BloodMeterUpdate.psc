Scriptname ED_BloodMeterUpdate extends Quest  


; script on this same quest with address that extends unattached script ED_BloodMeterWidget
ED_BloodMeter property ExposureMeter auto

; ------------------------------------------------------------
; Base settings adjusted in MCM
GlobalVariable Property ED_Mechanics_BloodMeter_Enable_Global Auto
GlobalVariable property ED_Mechanics_BloodMeter_X_Global auto
GlobalVariable property ED_Mechanics_BloodMeter_Y_Global auto
GlobalVariable Property ED_Mechanics_BloodMeter_Scale_Global Auto
GlobalVariable property ED_Mechanics_BloodMeter_Opacity_Global auto
GlobalVariable property ED_Mechanics_BloodMeter_FillDirection_Global auto

GlobalVariable property ED_Mechanics_BloodMeter_DisplayContextual_Global auto
GlobalVariable property ED_Mechanics_BloodMeter_DisplayTime_Global auto
; ------------------------------------------------------------

GlobalVariable Property ED_Mechanics_BloodPool_Total Auto
GlobalVariable Property ED_Mechanics_BloodPool_Current Auto

float property BloodMeter_UpdateRate auto

Actor Property PlayerRef Auto

float fThisBloodPoolValue
float fMaxBloodPoolValue 
float fMeterPercent
float fLastMeterPercent

bool bShouldFadeWhenIdle
int iDisplayIterationsNeededUntilFade = 3
int iDisplayIterationsRemaining



; -------------------------------------------------------------------------------------------------
; EVENTS ------------------------------------------------------------------------------------------


Event OnInit()
	utility.wait(1.0)
	ED_SKSEnativebindings.CommunicateCurrentWidgetRoot(ExposureMeter.WidgetRoot + ".setPercent")
	StartUpdating()
endEvent


Event OnGameReload()
	utility.wait(1.0)
	ED_SKSEnativebindings.CommunicateCurrentWidgetRoot(ExposureMeter.WidgetRoot + ".setPercent")
	StartUpdating()
endEvent


function StartUpdating()

	debug.Trace("Everdamned DEBUG: Blood Meter widget starts updating!")
	
	;ED_SKSEnativebindings.CommunicateCurrentWidgetRoot(ExposureMeter.WidgetRoot + ".setPercent")
	;utility.wait(1.0)
	;ED_SKSEnativebindings.ToggleBloodPoolUpdateLoop(true)
	
	UpdateMeterBasicSettings()
	
	; registration happens in UpdateMeterBasicSettings
	
endFunction


Event OnUpdate()
	UpdateMeter()
endEvent


; -------------------------------------------------------------------------------------------------
; FUNCTIONS ---------------------------------------------------------------------------------------


function UpdateMeter()
	
	fThisBloodPoolValue = PlayerRef.GetActorValue("ED_BloodPool")
	; for display effect
	ED_Mechanics_BloodPool_Current.SetValue(fThisBloodPoolValue)
	
	;fMaxBloodPoolValue = ED_Mechanics_BloodPool_Total.GetValue()
	;fMeterPercent = ((fThisBloodPoolValue)/(fMaxBloodPoolValue))
	
	;ExposureMeter.SetPercent(fMeterPercent)
	;debug.Trace("Everdamned DEBUG: WidgetRoot: " + ExposureMeter.WidgetRoot)
	;debug.Trace("Everdamned DEBUG: HUD_MENU: " + ExposureMeter.HUD_MENU)
	
	Int _primaryColor = 11141120
	ExposureMeter.SetColors(_primaryColor, 3276800)

	float fNewOpacity = ED_Mechanics_BloodMeter_Opacity_Global.GetValue()
	if bShouldFadeWhenIdle
		if fLastMeterPercent == fMeterPercent
		
			if iDisplayIterationsRemaining > 0
				iDisplayIterationsRemaining -= 1
			else
				fNewOpacity = fNewOpacity/2.0 ; 2 times less opaque
			endif
			
		else
			iDisplayIterationsRemaining = iDisplayIterationsNeededUntilFade
		endif
	endif
	
	ExposureMeter.FadeTo(fNewOpacity, 1.0)
	
	fLastMeterPercent = fMeterPercent
	
	; here on occasion UpdateMeterBasicSettings unregisters due to Enabled change
	; but OnUpdate manages to fire anyway
	; consider switching to RegisterForUpdate
	if ED_Mechanics_BloodMeter_Enable_Global.value == 0
		ED_SKSEnativebindings.ToggleBloodPoolUpdateLoop(false)
		ExposureMeter.Alpha = 0.0
	else
		RegisterForSingleUpdate(BloodMeter_UpdateRate)
	endif

endFunction

function UpdateMeterBasicSettings()

	ExposureMeter.HAnchor = "left" 
	ExposureMeter.VAnchor = "bottom" 
	ExposureMeter.X = ED_Mechanics_BloodMeter_X_Global.GetValue() ; Default is 67
	ExposureMeter.Y = ED_Mechanics_BloodMeter_Y_Global.GetValue() ; Default is 640
	Exposuremeter.Height = ((ED_Mechanics_BloodMeter_Scale_Global.GetValue()/100.0)*25.2) ; Default Scale is 100 with Height of 25.2
	Exposuremeter.Width = ((ED_Mechanics_BloodMeter_Scale_Global.GetValue()/100.0)*292.8) ; Default Scale is 100 with Width of 292.8
	
	int __fillDirection = ED_Mechanics_BloodMeter_FillDirection_Global.value as int
	if __fillDirection == 1
		ExposureMeter.FillDirection = "both"
	elseif __fillDirection == 2
		ExposureMeter.FillDirection = "left"
	else
		ExposureMeter.FillDirection = "right"
	endif
	
	float DisplayTimeSeconds = ED_Mechanics_BloodMeter_DisplayTime_Global.GetValue()
	
	if DisplayTimeSeconds > 0
		bShouldFadeWhenIdle = true
		iDisplayIterationsNeededUntilFade = math.ceiling(DisplayTimeSeconds / BloodMeter_UpdateRate)
		iDisplayIterationsRemaining = iDisplayIterationsNeededUntilFade
	else
		bShouldFadeWhenIdle = false
	endif
	
	if ED_Mechanics_BloodMeter_Enable_Global.value == 0
		ExposureMeter.Alpha = 0.0
		ED_SKSEnativebindings.ToggleBloodPoolUpdateLoop(false)
		UnregisterForUpdate()
	else
		ExposureMeter.Alpha = ED_Mechanics_BloodMeter_Opacity_Global.GetValue()
		ED_SKSEnativebindings.ToggleBloodPoolUpdateLoop(true)
		RegisterForSingleUpdate(BloodMeter_UpdateRate)
	endif
	
endfunction

