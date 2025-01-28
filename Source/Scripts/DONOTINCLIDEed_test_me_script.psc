Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  

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
actor _dog

actor _summonedActor

formlist property ED_TEST_formlist auto

function OnEffectStart(Actor akTarget, Actor akCaster)
	_player = akCaster
	debug.Trace("Test Effect started")
	
	ED_TEST_formlist.addform(FXEmptyActivator)
	ED_TEST_formlist.addform(ConjureFlameAtronach)
	ED_TEST_formlist.addform(ED_TEST_Vfx)
	ED_TEST_formlist.addform(playerRef)
	
	debug.Trace("Test form list has size:" + ED_TEST_formlist.GetSize())
	
	
	int i = 0
	while i < ED_TEST_formlist.GetSize()
		
		debug.Trace("Test form is: " + ED_TEST_formlist.GetAt(i))

		i += 1
	endWhile
	
	ED_TEST_formlist.removeaddedform(ED_TEST_Vfx)
	
	utility.wait(2)
	
	debug.Trace("Test form list has size:" + ED_TEST_formlist.GetSize())
	
	i = 0
	while i < ED_TEST_formlist.GetSize()
		
		debug.Trace("Test form is: " + ED_TEST_formlist.GetAt(i))

		i += 1
	endWhile
	
	
	;SendModEvent("ed_RefreshCommandEffectDuration", "", akTarget.GetFormID() as float)
	;RegisterForSingleUpdate(10.0)
	
	
	;ScaleNode(akTarget, "NPC Head [Head]", 3.0)
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
	;Debug.Trace("EdTestVar value at during: " + _player.getactorvalue("EdTestVar"))
	;Debug.Trace("VampireSkill value at during: " + _player.getactorvalue("VampireSkill"))
	
	;debug.Trace("Everdamned TEST: activator can see player: " + _activator.haslos	)
	debug.Trace("Current duration   : " + self.GetDuration())
	debug.Trace("Curent time elapsed: " + self.GetTimeElapsed())
	;RegisterForSingleUpdate(2.0)
	
	self.RegisterForAnimationEvent(playerRef, LandStart)

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