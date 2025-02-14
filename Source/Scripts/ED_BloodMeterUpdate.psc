Scriptname ED_BloodMeterUpdate extends Quest  


; script on this same quest with address that extends unattached script ED_BloodMeterWidget
ED_BloodMeter property ExposureMeter auto
GlobalVariable Property EnableVampireBloodPool Auto
GlobalVariable Property EnableVampireBloodMeter Auto

GlobalVariable property ED_BloodMeterDisplay_Contextual auto
GlobalVariable property ED_BloodMeter_Opacity auto
GlobalVariable Property ED_BloodMeterScale Auto
GlobalVariable property ED_BloodMeterX auto
GlobalVariable property ED_BloodMeterY auto
GlobalVariable property ED_BloodMeterDisplayTime auto

; using Actor value ED_BloodPool as blood pool now
GlobalVariable Property VampireBloodPool Auto
GlobalVariable Property VampireBloodPoolMax Auto

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
	ExposureMeter.X = ED_BloodMeterX.GetValue() ; Default is 67
	ExposureMeter.Y = ED_BloodMeterY.GetValue() ; Default is 640
	
	StartUpdating()
	
endEvent


Event OnGameReload()

	StartUpdating()
	
endEvent


function StartUpdating()

	debug.Trace("Blood meter started updating!")

	RegisterForSingleUpdate(2)
	
endFunction


Event OnUpdate()

;	debug.trace("Blood meter OnUpdate called")
;	debug.Trace("EnableVampireBloodPool value is: " + EnableVampireBloodPool.GetValue())
;	debug.Trace("EnableVampireBloodMeter value is: " + EnableVampireBloodMeter.GetValue())

	; TODO: move param switching logic to MCM quest
	if EnableVampireBloodPool.GetValue() == 0 || EnableVampireBloodMeter.GetValue() == 0
;	debug.trace("Blood meter is hidden now")
		ExposureMeter.Alpha = 0.0
		;UnRegisterForUpdate()
	else
		UpdateMeter()
	endif

	;if EnableVampireBloodPool.GetValue() != 0
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
	fMaxBloodPoolValue = VampireBloodPoolMax.GetValue()
	fMeterPercent = ((fThisBloodPoolValue)/(fMaxBloodPoolValue))
	
;	debug.Trace("fThisBloodPoolValue value is: " + fThisBloodPoolValue)
;	debug.Trace("fMaxBloodPoolValue value is: " + fMaxBloodPoolValue)
;	debug.Trace("fMeterPercent value is: " + fMeterPercent)
	
	
	UpdateBlood(fMeterPercent)
	
	fLastMeterPercent = fMeterPercent
	
endFunction


function UpdateBlood(float meterPercent)

;	debug.trace("Blood meter UpdateBlood called")
	ExposureMeter.Alpha = ED_BloodMeter_Opacity.GetValue()

	
	;if fLastBloodPointValue <= 0
	;	ExposureMeter.ForcePercent(0.0)
	;endif

	ExposureMeter.HAnchor = "left" 
	ExposureMeter.VAnchor = "bottom" 
	ExposureMeter.X = ED_BloodMeterX.GetValue() ; Default is 67
	ExposureMeter.Y = ED_BloodMeterY.GetValue() ; Default is 640
	ExposureMeter.Height = 25.2
	ExposureMeter.Width = 292.8
	ExposureMeter.FillDirection = "right"
	
	ExposureMeter.SetPercent(meterPercent)


	Int _primaryColor = 11141120
	
	ExposureMeter.SetColors(_primaryColor, 3276800)
	
endFunction

