Scriptname ED_MCM_Quest_Script extends SKI_ConfigBase


Int BloodMeter_Enable
float property Default_BloodMeter_Enable auto
GlobalVariable Property ED_Mechanics_BloodMeter_Enable_Global Auto  

Int BloodMeter_X
float property Default_BloodMeter_X auto
GlobalVariable Property ED_Mechanics_BloodMeter_X_Global  Auto  

Int BloodMeter_Y
float property Default_BloodMeter_Y auto
GlobalVariable Property ED_Mechanics_BloodMeter_Y_Global  Auto

Int BloodMeter_Scale
float property Default_BloodMeter_Scale auto
GlobalVariable Property ED_Mechanics_BloodMeter_Scale_Global Auto

int BloodMeter_Opacity
float property Default_BloodMeter_Opacity auto
GlobalVariable property ED_Mechanics_BloodMeter_Opacity_Global auto

int BloodMeter_FillDirection
int property Default_BloodMeter_FillDirection auto
GlobalVariable property ED_Mechanics_BloodMeter_FillDirection_Global auto

int BloodMeter_DisplayTime
int property Default_BloodMeter_DisplayTime auto
GlobalVariable property ED_Mechanics_BloodMeter_DisplayTime_Global auto



; on pressing R for default i guess?
function OnOptionDefault(Int akOp)

	; ------------------------------------------------------------
	; Blood Meter
	If akOp == BloodMeter_X
		ED_Mechanics_BloodMeter_X_Global.SetValue(Default_BloodMeter_X as Float)
		self.SetSliderOptionValue(BloodMeter_X, Default_BloodMeter_X)
		
	elseif akOp == BloodMeter_Y
		ED_Mechanics_BloodMeter_Y_Global.SetValue(Default_BloodMeter_Y as Float)
		self.SetSliderOptionValue(BloodMeter_Y, Default_BloodMeter_Y)
		
	elseIf akOp == BloodMeter_Scale
		ED_Mechanics_BloodMeter_Scale_Global.SetValue(Default_BloodMeter_Scale as Float)
		self.SetSliderOptionValue(BloodMeter_Scale, Default_BloodMeter_Scale)
		
	elseIf akOp == BloodMeter_FillDirection
		ED_Mechanics_BloodMeter_FillDirection_Global.SetValue(Default_BloodMeter_FillDirection as Float)
		self.SetSliderOptionValue(BloodMeter_FillDirection, Default_BloodMeter_FillDirection as Float)
		
	elseIf akOp == BloodMeter_Opacity
		ED_Mechanics_BloodMeter_Opacity_Global.SetValue(Default_BloodMeter_Opacity as Float)
		self.SetSliderOptionValue(BloodMeter_Opacity, Default_BloodMeter_Opacity)
		
	elseIf akOp == BloodMeter_Enable
		ED_Mechanics_BloodMeter_Enable_Global.SetValue(Default_BloodMeter_Enable as Float)
		self.SetToggleOptionValue(BloodMeter_Enable, Default_BloodMeter_Enable as bool)
	
	elseIf akOp == BloodMeter_DisplayTime
		ED_Mechanics_BloodMeter_DisplayTime_Global.SetValue(Default_BloodMeter_DisplayTime as Float)
		self.SetSliderOptionValue(BloodMeter_DisplayTime, Default_BloodMeter_DisplayTime as Float)
	
	; ------------------------------------------------------------
	
	endif
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endfunction

function OnPageReset(String akPage)

	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	self.AddHeaderOption("Everdamned", 0)
	
	; ------------------------------------------------------------
	; Blood Meter
	
	BloodMeter_Enable = self.AddToggleOption("Enable blood pool bar", ED_Mechanics_BloodMeter_Enable_Global.GetValue() as Bool)
	
	BloodMeter_X = self.AddSliderOption("Blood pool bar X coordinate", ED_Mechanics_BloodMeter_X_Global.GetValue())
	BloodMeter_Y = self.AddSliderOption("Blood pool bar Y coordinate", ED_Mechanics_BloodMeter_Y_Global.GetValue())
	BloodMeter_Scale = self.AddSliderOption("Blood pool bar scale", ED_Mechanics_BloodMeter_Scale_Global.GetValue())
	BloodMeter_FillDirection = self.AddSliderOption("Blood pool bar fill direction", ED_Mechanics_BloodMeter_FillDirection_Global.GetValue())
	BloodMeter_Opacity = self.AddSliderOption("Blood pool bar opacity", ED_Mechanics_BloodMeter_Opacity_Global.GetValue())
	BloodMeter_DisplayTime = self.AddSliderOption("Seconds to fade when incative", ED_Mechanics_BloodMeter_DisplayTime_Global.GetValue())
	
	; ------------------------------------------------------------

endFunction

function OnOptionSliderOpen(Int akOp)
	
	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodMeter_X
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_X_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_X)
		self.SetSliderDialogRange(0.0000, 1000.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_Y
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Y_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_Y)
		self.SetSliderDialogRange(50.000000, 700.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_Scale
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Scale_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_Scale)
		self.SetSliderDialogRange(10.000000, 200.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_FillDirection
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_FillDirection_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_FillDirection as float)
		self.SetSliderDialogRange(0.000000, 2.0000)
		self.SetSliderDialogInterval(1.00000)
		
	elseIf akOp == BloodMeter_Opacity
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Opacity_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_Opacity)
		self.SetSliderDialogRange(0.000000, 100.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_DisplayTime
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_DisplayTime_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_DisplayTime as Float)
		self.SetSliderDialogRange(0.000000, 20.0000)
		self.SetSliderDialogInterval(1.0)

	; ------------------------------------------------------------
	
	endIf
endFunction

function OnOptionSliderAccept(Int akOp, Float akValue)

	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodMeter_X
		ED_Mechanics_BloodMeter_X_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_X, akValue)
	
	elseIf akOp == BloodMeter_Y
		ED_Mechanics_BloodMeter_Y_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_Y, akValue)
		
	elseIf akOp == BloodMeter_Scale
		ED_Mechanics_BloodMeter_Scale_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_Scale, akValue)
	
	elseIf akOp == BloodMeter_FillDirection
		ED_Mechanics_BloodMeter_FillDirection_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_FillDirection, akValue)
		
	elseIf akOp == BloodMeter_Opacity
		ED_Mechanics_BloodMeter_Opacity_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_Opacity, akValue)
	
	elseIf akOp == BloodMeter_DisplayTime
		ED_Mechanics_BloodMeter_DisplayTime_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_DisplayTime, akValue)
		
	; ------------------------------------------------------------
	
	endif
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endFunction


function OnOptionSelect(Int akOp)
	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodMeter_Enable
		ED_Mechanics_BloodMeter_Enable_Global.SetValue(1 as Float - ED_Mechanics_BloodMeter_Enable_Global.GetValue())
		self.SetToggleOptionValue(BloodMeter_Enable, ED_Mechanics_BloodMeter_Enable_Global.GetValue() as Bool)
	
	; ------------------------------------------------------------
	
	endif
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endfunction


; proper description of the option when you highlight it with a mouse
; displayed somewhere
function OnOptionHighlight(Int akOp)

	; ------------------------------------------------------------
	; Blood Meter
	If akOp == BloodMeter_X
		self.SetInfoText("TEST: Intricate Description of X coordinate")
	elseif akOp == BloodMeter_Y
		self.SetInfoText("TEST: Intricate Description of Y coordinate")
	elseIf akOp == BloodMeter_Scale
		self.SetInfoText("TEST: Intricate Description of meter scale")
	elseIf akOp == BloodMeter_FillDirection
		self.SetInfoText("The position at which the meter fills from, 0 = right, 1 = center, 2 = left. Default: right")
	elseIf akOp == BloodMeter_Opacity
		self.SetInfoText("TEST: Intricate Description of opacity")
	elseIf akOp == BloodMeter_Enable
		self.SetInfoText("Enable blood bar")
	elseIf akOp == BloodMeter_DisplayTime
		self.SetInfoText("How much seconds before blood bar fades after displaying last change. Setting to 0 disables fading. May not be exact amount of seconds due to bar update rate")
		
		
	; ------------------------------------------------------------
	
	endif
endfunction

ED_BloodMeterUpdate property ED_BloodMeter_Quest auto
