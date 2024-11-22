Scriptname ED_MCM_Quest_Script extends SKI_ConfigBase


Int BloodPoolWidgetX
Int BloodPoolWidgetY

function OnPageReset(String akPage)

	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	self.AddHeaderOption("Everdamned", 0)
	BloodPoolWidgetX = self.AddSliderOption("Blood pool widget X coordinate", ED_BloodMeterX.GetValue())
	BloodPoolWidgetY = self.AddSliderOption("Blood pool widget Y coordinate", ED_BloodMeterY.GetValue())

endFunction

function OnOptionSliderOpen(Int akOp)

	if akOp == BloodPoolWidgetX
		self.SetSliderDialogStartValue(ED_BloodMeterX.GetValue())
		self.SetSliderDialogDefaultValue(62.0000)
		self.SetSliderDialogRange(0.0000, 1000.0000)
		self.SetSliderDialogInterval(2.00000)
	elseIf akOp == BloodPoolWidgetY
		self.SetSliderDialogStartValue(ED_BloodMeterY.GetValue())
		self.SetSliderDialogDefaultValue(640)
		self.SetSliderDialogRange(50.000000, 700.0000)
		self.SetSliderDialogInterval(2.00000)
	endIf
	
endFunction

function OnOptionSliderAccept(Int akOp, Float akValue)

	if akOp == BloodPoolWidgetX
		ED_BloodMeterX.SetValue(akValue)
		self.SetSliderOptionValue(BloodPoolWidgetX, akValue)
	elseIf akOp == BloodPoolWidgetY
		ED_BloodMeterY.SetValue(akValue)
		self.SetSliderOptionValue(BloodPoolWidgetY, akValue)
	endif
	
endFunction


GlobalVariable Property ED_BloodMeterX  Auto  

GlobalVariable Property ED_BloodMeterY  Auto  
