Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  

;ObjectReference TheBox
actor _player

function OnEffectStart(Actor akTarget, Actor akCaster)
	Flames.Cast(akTarget, akCaster)
endFunction

;event OnUpdate()
	
;endevent

;function OnEffectFinish(Actor akTarget, Actor akCaster)
	
;endFunction


Activator Property FXEmptyActivator  Auto  

SPELL Property Flames  Auto  

ReferenceAlias Property afflictedalias  Auto  


