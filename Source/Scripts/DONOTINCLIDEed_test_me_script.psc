Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  

ShaderParticleGeometry property PSGD auto
float property FadeInTime = 1.0 auto
float property FadeOutTime = 1.0 auto


actor _player

function OnEffectStart(Actor akTarget, Actor akCaster)
	_player = akCaster
	;Debug.Trace("EdTestVar value at start: " + akCaster.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at start: " + akCaster.getactorvalue("VampireSkill"))
	
	;RegisterForSingleUpdate(2.0)
	PSGD.apply(FadeInTime)
	
	
endFunction

event OnUpdate()
	;Debug.Trace("EdTestVar value at during: " + _player.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at during: " + _player.getactorvalue("VampireSkill"))
endevent


function OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Trace("EdTestVar value at end: " + akCaster.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at end: " + akCaster.getactorvalue("VampireSkill"))
	
	PSGD.remove(FadeOutTime)
endFunction


