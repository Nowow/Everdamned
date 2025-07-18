Scriptname ED_VampiresSight_Toggle_Script extends activemagiceffect  


int LShift = 0x2A

Event OnEffectStart(Actor Target, Actor Caster)
	;given automatically at age 2
	bool __HasPV = ED_Mechanics_VampireAge.value >= 2
	bool __isLShiftPressed = Input.IsKeyPressed(LShift)
	bool __hasSightME = Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect)
	bool __hasPVME = Caster.HasMagicEffect(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Effect)
	
	; check if Predator Vision interaction
	if __HasPV && __isLShiftPressed
		
		; turn off Predator Vision, keep Sight
		if __hasPVME
			debug.Trace("Everdamned DEBUG: Night Eye Actuator removes Blood Sense")
			Caster.removespell(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell)
		
		; add Predator Vision
		else
			;add sight if has no sight
			if !__hasSightME
				debug.Trace("Everdamned DEBUG: Night Eye Actuator adds Night Vision")
				Caster.addspell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual, false)
			endif
			debug.Trace("Everdamned DEBUG: Night Eye Actuator adds Blood Sense")
			Caster.addspell(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell, false)
		endif

	; regular Sight interation
	else
		if __hasSightME
			debug.Trace("Everdamned DEBUG: Night Eye Actuator removes Night Vision")
			Caster.removespell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual)
			if __hasPVME
				debug.Trace("Everdamned DEBUG: Night Eye Actuator removes Blood Sense")
				Caster.removespell(ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell)
			endif
			
		else
			debug.Trace("Everdamned DEBUG: Night Eye Actuator adds Night Vision")
			Caster.addspell(ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual, false)
		endif
	endif

endevent

spell property ED_BeingVampire_Vanilla_Pw_VampiresSight_Spell_Actual auto
spell property ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Spell auto
magiceffect property ED_BeingVampire_Vanilla_Pw_VampiresSight_Effect auto
magiceffect property ED_BeingVampire_Vanilla_Pw_PredatorVision_Cloak_Effect auto

globalvariable property ED_Mechanics_VampireAge auto
