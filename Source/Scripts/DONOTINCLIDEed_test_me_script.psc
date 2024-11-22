Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  

ObjectReference TheBox
actor _player

function OnEffectStart(Actor akTarget, Actor akCaster)
	_player = akCaster
	TheBox = akCaster.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
	TheBox.enable()
	utility.wait(1.0)
	TheBox.MoveTo(akCaster as ObjectReference, 100 as Float, 0 as Float, 0 as Float, true)
	self.RegisterForUpdate(1.0)
endFunction

event OnUpdate()
	TheBox.SetAngle(utility.RandomInt(-180, 180) as Float, utility.RandomInt(-180, 180) as Float, utility.RandomInt(-180, 180) as Float)
	Flames.Cast(TheBox)
endevent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	TheBox.delete()
	; Empty function
endFunction


Activator Property FXEmptyActivator  Auto  

SPELL Property Flames  Auto  
