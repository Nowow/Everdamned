Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  

import ED_SKSEnativebindings

ShaderParticleGeometry property PSGD auto
String property LandStart = "LandStart" auto

activator property FXEmptyActivator auto
spell property ConjureFlameAtronach auto
idle property WolfIdleWarn auto
visualeffect property ED_TEST_Vfx auto
idle property ed_testidle auto
spell property SCS_VampireSpells_VampireLord_Spell_Power04_Tremble auto
actor property playerRef auto

actor _player
actor _target

actor _summonedActor

formlist property ED_TEST_formlist auto

keyword property ED_Mechanics_Keyword_DistractionSceneQuestStart auto

function OnEffectStart(Actor akTarget, Actor akCaster)
	_player = akCaster
	_target = akTarget

	
	ED_Mechanics_Keyword_DistractionSceneQuestStart.SendStoryEvent(akRef1 = akTarget, aiValue1 = 3)
	
	
	;SendModEvent("ed_RefreshCommandEffectDuration", "", akTarget.GetFormID() as float)
	;RegisterForSingleUpdate(10.0)
	
	
	;ScaleNode(akTarget, "NPC Head [Head]", 3.0)
	;NetImmerse.SetNodeScale(akTarget, "NPC Head [Head]", 3.0, false)
	;Debug.Trace("EdTestVar value at start: " + akCaster.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at start: " + akCaster.getactorvalue("VampireSkill"))
	
	;RegisterForSingleUpdate(2.0)
	;PSGD.apply(FadeInTime)
	
	;_activator = _player.placeatme(FXEmptyActivator, 1)
	;utility.wait(0.2)
	;ConjureFlameAtronach.cast(_activator, _activator)
	
	;akTarget.playidle(WolfIdleWarn)
	
	
	;ConjureFlameAtronach.Cast(_player,_player)

	;debug.MessageBox(ED_SKSEnativebindings.GetProvidedSpellName(ConjureFlameAtronach))
	;debug.MessageBox(ED_SKSEnativebindings.PapyrusNativeFunctionBinding(22233))
	
	;_summonedActor = ED_SKSEnativebindings.GetActiveEffectCommandedActor(self)
	;debug.Trace("Summoned actor was the guy: " + _summonedActor)
	;debug.Trace("Caster actor, from the oven: " + GetCasterActor())
	;debug.Trace("Target actor, from the oven: " + GetTargetActor())
	
	;utility.wait(5.0)
	;debug.Trace("WAIT FINISHED")
	
	;_summonedActor = ED_SKSEnativebindings.GetActiveEffectCommandedActor(self)
	;debug.Trace("Caster actor, from the oven: " + GetCasterActor())
	;debug.Trace("Target actor, from the oven: " + GetTargetActor())
	;debug.Trace("Summoned actor was the guy: " + _summonedActor)
	
	;ED_SKSEnativebindings.IncreaseActiveEffectDuration(self, 100.0)
	;debug.MessageBox(ED_SKSEnativebindings.GetActiveEffectCommandedActor(self))
	

	;RegisterForSingleUpdate(2.0)
endFunction

function OnAnimationEvent(objectreference akActor, String akEventName)

	debug.Trace("Everdamned DEBUG: test effect script caught animevent")
	if akEventName == LandStart
		SCS_VampireSpells_VampireLord_Spell_Power04_Tremble.Cast(playerRef, playerRef)
	endif
		
		
endfunction

event OnUpdate()
	
	;_player.modactorvalue("EdTestVar", 10.0)
	;_player.setactorvalue("VampireSkill", 10.0)
	;Debug.Trace("EdTestVar value at during: " + _player.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at during: " + _player.getactorvalue("VampireSkill"))
	
	Debug.Trace("Target has LOS of player: " + _target.HasLOS(_player))
	
	;debug.Trace("Everdamned TEST: activator can see player: " + _activator.haslos	)
	;debug.Trace("Current duration   : " + self.GetDuration())
	;debug.Trace("Curent time elapsed: " + self.GetTimeElapsed())
	RegisterForSingleUpdate(2.0)
	
	;self.RegisterForAnimationEvent(playerRef, LandStart)

endevent


function OnEffectFinish(Actor akTarget, Actor akCaster)

	debug.Trace("Test Effect ended")
	;ScaleNode(akTarget, "NPC Head [Head]", 1.0)
	;Debug.Trace("EdTestVar value at end: " + akCaster.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at end: " + akCaster.getactorvalue("VampireSkill"))
	
	;PSGD.remove(FadeOutTime)
	
	;_activator.disable()
	;_activator.delete()
	
	
endFunction


Function ScaleNode(actor akTarget, String spellNode, Float scale)
	NetImmerse.SetNodeScale(akTarget, spellNode, scale, false)
	NetImmerse.SetNodeScale(akTarget, spellNode, scale, true)
EndFunction


float property FadeInTime = 1.0 auto
float property FadeOutTime = 1.0 auto