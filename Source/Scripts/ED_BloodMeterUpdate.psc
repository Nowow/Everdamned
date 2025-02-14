Scriptname ED_BloodMeterUpdate extends Quest  



; -------------------------------------------------------------------------------------------------
; VARIABLES ---------------------------------------------------------------------------------------


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
	
	PlayerRef = Game.GetPlayer()

	RegisterForSingleUpdate(2)
	
endFunction


Event OnUpdate()

;	debug.trace("Blood meter OnUpdate called")
	
;	debug.Trace("EnableVampireBloodPool value is: " + EnableVampireBloodPool.GetValue())
;	debug.Trace("EnableVampireBloodMeter value is: " + EnableVampireBloodMeter.GetValue())

	if EnableVampireBloodPool.GetValue() == 0 || EnableVampireBloodMeter.GetValue() == 0
;	debug.trace("Blood meter is hidden now")
		ExposureMeter.Alpha = 0.0
		;UnRegisterForUpdate()
	else
		UpdateMeter()
	endif

	if EnableVampireBloodPool.GetValue() != 0
;		debug.trace("Blood meter registred for update")
		RegisterForSingleUpdate(2)
	endif
	
endEvent


; -------------------------------------------------------------------------------------------------
; FUNCTIONS ---------------------------------------------------------------------------------------


function UpdateMeter(bool bSkipDisplayHandling = false)

;	debug.trace("Blood meter UpdateMeter called")
	
	fThisBloodPoolValue = PlayerRef.GetActorValue("ED_BloodPool")
	fMaxBloodPoolValue = VampireBloodPoolMax.GetValue()
	fMeterPercent = ((fThisBloodPoolValue)/(fMaxBloodPoolValue))
	
;	debug.Trace("fThisBloodPoolValue value is: " + fThisBloodPoolValue)
;	debug.Trace("fMaxBloodPoolValue value is: " + fMaxBloodPoolValue)
;	debug.Trace("fMeterPercent value is: " + fMeterPercent)
	
	
	UpdateBlood(fMeterPercent, bSkipDisplayHandling)
	
	fLastMeterPercent = fMeterPercent

	;if iDisplayIterationsRemaining > 0
	;	iDisplayIterationsRemaining -= 1
	;	if iDisplayIterationsRemaining <= 0
	;		iDisplayIterationsRemaining = 0
	;		if ED_BloodMeterDisplay_Contextual.GetValueInt() != 1
	;			ExposureMeter.FadeTo(0.0, 3.0)
	;		endif
	;	endif
	;elseif iDisplayIterationsRemaining == 0
	;	if ExposureMeter.Alpha == ED_BloodMeter_Opacity.GetValue()
	;		if ED_BloodMeterDisplay_Contextual.GetValueInt() != 1
	;			ExposureMeter.FadeTo(0.0, 3.0)
	;		endif
	;	endif
	;else
	;endif	
	
endFunction


function UpdateBlood(float meterPercent, bool bSkipDisplayHandling = false)

;	debug.trace("Blood meter UpdateBlood called")
	ExposureMeter.Alpha = ED_BloodMeter_Opacity.GetValue()
	
	;if BetterVampiresBloodMeterDisplay_Contextual.GetValueInt() == 1
		;ExposureMeter.Alpha = BetterVampiresBloodMeter_Opacity.GetValue()
	;elseif BetterVampiresBloodMeterDisplay_Contextual.GetValueInt() == 2
	;	ContextualDisplay(fThisBloodPointValue)
	;elseif BetterVampiresBloodMeterDisplay_Contextual.GetValueInt() == 0 && iDisplayIterationsRemaining == 0
	;	ExposureMeter.Alpha = 0.0
	;	return
	;endif
	
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
	;Exposuremeter.Height = ((BetterVampiresBloodMeterScale.GetValue()/100)*25.2) ; Default Scale is 100 with Height of 25.2
	;Exposuremeter.Width = ((BetterVampiresBloodMeterScale.GetValue()/100)*292.8) ; Default Scale is 100 with Width of 292.8
	
	ExposureMeter.SetPercent(meterPercent)
	
	;If VampireDynamicStages.GetValue() == 20000
	;	ExposureMeter.SetPercent((fThisBloodPointValue) / 100.0)
	;ElseIf VampireDynamicStages.GetValue() != 20000
	;	ExposureMeter.SetPercent((fThisBloodPointValue) / 300.0)
	;EndIf

	Int _primaryColor = 11141120
	;Int _primaryColor = 4259840
	
	;If VampireDynamicStages.GetValue() == 20000
	;	If VampireBloodPoints.GetValue() > 67
	;		_primaryColor	= 11141120
	;	ElseIf VampireBloodPoints.GetValue() > 37
	;		_primaryColor	= 6553600
	;	ElseIf VampireBloodPoints.GetValue() > 0
	;		_primaryColor	= 3276800
	;	EndIf
	;ElseIf VampireDynamicStages.GetValue() < 20000
	;	If VampireBloodPoints.GetValue() > 200
	;		_primaryColor	= 11141120
	;	ElseIf VampireBloodPoints.GetValue() > 100
	;		_primaryColor	= 6553600
	;	ElseIf VampireBloodPoints.GetValue() > 0
	;		_primaryColor	= 3276800
	;	EndIf	
	;EndIf		
	
	ExposureMeter.SetColors(_primaryColor, 3276800)
	
endFunction

