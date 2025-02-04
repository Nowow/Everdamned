Scriptname ED_ChoiceGlobal_Script extends activemagiceffect  


globalvariable property ED_Global auto
message property ED_Message auto


function OnEffectFinish(Actor akTarget, Actor akCaster)

	ED_Global.SetValue(-1 as Float)
endFunction

function OnEffectStart(Actor akTarget, Actor akCaster)

	Int Choice = ED_Message.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	ED_Global.SetValue(Choice as Float)
endFunction
