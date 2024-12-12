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
	ScaleNode("NPC Head [Head]", 3.0)
	
	
endFunction

event OnUpdate()
	;Debug.Trace("EdTestVar value at during: " + _player.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at during: " + _player.getactorvalue("VampireSkill"))
endevent


function OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Trace("EdTestVar value at end: " + akCaster.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at end: " + akCaster.getactorvalue("VampireSkill"))
	
	PSGD.remove(FadeOutTime)
	ScaleNode("NPC Head [Head]", 1.0)
endFunction


Function ScaleNode(String spellNode, Float scale)
	NetImmerse.SetNodeScale(_player, spellNode, scale, false)
	NetImmerse.SetNodeScale(_player, spellNode, scale, true)
EndFunction
