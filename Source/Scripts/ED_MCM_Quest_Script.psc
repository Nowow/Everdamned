Scriptname ED_MCM_Quest_Script extends SKI_ConfigBase


Int BloodPoolWidgetX
float property Default_BloodPoolWidgetX auto
GlobalVariable Property ED_BloodMeterX  Auto  

Int BloodPoolWidgetY
float property Default_BloodPoolWidgetY auto
GlobalVariable Property ED_BloodMeterY  Auto



; on pressing R for default i guess?
function OnOptionDefault(Int akOp)

	; ------------------------------------------------------------
	; Blood Meter
	If akOp == BloodPoolWidgetX
		ED_BloodMeterX.SetValue(Default_BloodPoolWidgetX as Float)
		self.SetSliderOptionValue(BloodPoolWidgetX, Default_BloodPoolWidgetX)
	elseif akOp == BloodPoolWidgetY
		ED_BloodMeterY.SetValue(Default_BloodPoolWidgetY as Float)
		self.SetSliderOptionValue(BloodPoolWidgetY, Default_BloodPoolWidgetY)
	
	; ------------------------------------------------------------
	
	endif	
endfunction


function OnPageReset(String akPage)

	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	self.AddHeaderOption("Everdamned", 0)
	
	; ------------------------------------------------------------
	; Blood Meter
	BloodPoolWidgetX = self.AddSliderOption("Blood pool widget X coordinate", ED_BloodMeterX.GetValue())
	BloodPoolWidgetY = self.AddSliderOption("Blood pool widget Y coordinate", ED_BloodMeterY.GetValue())
	; ------------------------------------------------------------

endFunction

function OnOptionSliderOpen(Int akOp)
	
	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodPoolWidgetX
		self.SetSliderDialogStartValue(ED_BloodMeterX.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodPoolWidgetX)
		self.SetSliderDialogRange(0.0000, 1000.0000)
		self.SetSliderDialogInterval(2.00000)
	elseIf akOp == BloodPoolWidgetY
		self.SetSliderDialogStartValue(ED_BloodMeterY.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodPoolWidgetY)
		self.SetSliderDialogRange(50.000000, 700.0000)
		self.SetSliderDialogInterval(2.00000)

	; ------------------------------------------------------------
	
	endIf	
endFunction

function OnOptionSliderAccept(Int akOp, Float akValue)

	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodPoolWidgetX
		ED_BloodMeterX.SetValue(akValue)
		self.SetSliderOptionValue(BloodPoolWidgetX, akValue)
	elseIf akOp == BloodPoolWidgetY
		ED_BloodMeterY.SetValue(akValue)
		self.SetSliderOptionValue(BloodPoolWidgetY, akValue)
	; ------------------------------------------------------------
	
	endif
endFunction


; proper description of the option when you highlight it with a mouse
; displayed somewhere
function OnOptionHighlight(Int akOp)

	; ------------------------------------------------------------
	; Blood Meter
	If akOp == BloodPoolWidgetX
		self.SetInfoText("TEST: Intricate Description of X coordinate")
	elseif akOp == BloodPoolWidgetY
		self.SetInfoText("TEST: Intricate Description of Y coordinate")
		
	; ------------------------------------------------------------
	
	endif
endfunction

