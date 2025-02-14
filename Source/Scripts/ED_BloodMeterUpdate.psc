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

Actor Property PlayerRef Auto

float fThisBloodPoolValue
float fMaxBloodPoolValue 
float fMeterPercent
float fLastMeterPercent

int iDisplayIterationsRemaining



; -------------------------------------------------------------------------------------------------
; EVENTS ------------------------------------------------------------------------------------------


Event OnInit()

	ExposureMeter.HAnchor = "left"
	ExposureMeter.VAnchor = "bottom"
	ExposureMeter.X = ED_Mechanics_BloodMeter_X_Global.GetValue() ; Default is 67
	ExposureMeter.Y = ED_Mechanics_BloodMeter_Y_Global.GetValue() ; Default is 640
	
	StartUpdating()
	
endEvent


Event OnGameReload()

	StartUpdating()
	
endEvent


function StartUpdating()

	debug.Trace("Blood meter started updating!")
	
	UpdateMeterBasicSettings()
	
	RegisterForSingleUpdate(2)
	
endFunction


Event OnUpdate()

;	debug.trace("Blood meter OnUpdate called")
;	debug.Trace("ED_Mechanics_BloodMeter_Enable_Global value is: " + ED_Mechanics_BloodMeter_Enable_Global.GetValue())

	; TODO: move param switching logic to MCM quest
	if ED_Mechanics_BloodMeter_Enable_Global.GetValue() == 0
;	debug.trace("Blood meter is hidden now")
		ExposureMeter.Alpha = 0.0
		;UnRegisterForUpdate()
	else
		UpdateMeter()
	endif

	;if UDALIT.GetValue() != 0
;		debug.trace("Blood meter registred for update")
	
	; TODO: switch to RegisterForUpdate
	RegisterForSingleUpdate(2)
	
	;endif
	
endEvent


; -------------------------------------------------------------------------------------------------
; FUNCTIONS ---------------------------------------------------------------------------------------


function UpdateMeter()

;	debug.trace("Blood meter UpdateMeter called")
	
	fThisBloodPoolValue = PlayerRef.GetActorValue("ED_BloodPool")
	fMaxBloodPoolValue = ED_Mechanics_BloodPool_Total.GetValue()
	fMeterPercent = ((fThisBloodPoolValue)/(fMaxBloodPoolValue))
	
	ExposureMeter.SetPercent(fMeterPercent)
	
	Int _primaryColor = 11141120
	ExposureMeter.SetColors(_primaryColor, 3276800)
	ExposureMeter.Alpha = ED_Mechanics_BloodMeter_Opacity_Global.GetValue()
	
;	debug.Trace("fThisBloodPoolValue value is: " + fThisBloodPoolValue)
;	debug.Trace("fMaxBloodPoolValue value is: " + fMaxBloodPoolValue)
;	debug.Trace("fMeterPercent value is: " + fMeterPercent)
	
	fLastMeterPercent = fMeterPercent
	
	
endFunction

function UpdateMeterBasicSettings()
	ExposureMeter.HAnchor = "left" 
	ExposureMeter.VAnchor = "bottom" 
	ExposureMeter.X = ED_Mechanics_BloodMeter_X_Global.GetValue() ; Default is 67
	ExposureMeter.Y = ED_Mechanics_BloodMeter_Y_Global.GetValue() ; Default is 640
	Exposuremeter.Height = ((ED_Mechanics_BloodMeter_Scale_Global.GetValue()/100)*25.2) ; Default Scale is 100 with Height of 25.2
	Exposuremeter.Width = ((ED_Mechanics_BloodMeter_Scale_Global.GetValue()/100)*292.8) ; Default Scale is 100 with Width of 292.8
	
	int __fillDirection = ED_Mechanics_BloodMeter_FillDirection_Global.value as int
	if __fillDirection == 1
		ExposureMeter.FillDirection = "both"
	elseif __fillDirection == 2
		ExposureMeter.FillDirection = "left"
	else
		ExposureMeter.FillDirection = "right"
	endif
	
	ExposureMeter.Alpha = ED_Mechanics_BloodMeter_Opacity_Global.GetValue()
	
endfunction

