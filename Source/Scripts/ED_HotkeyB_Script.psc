Scriptname ED_HotkeyB_Script extends Quest  

import input

int SpacebarKey = 0x39
int LShift = 0x2A

float property TapMaxLength = 0.3 auto


int chargeSoundInstance

int __currentHotkeyB
function RegisterHotkey()
	__currentHotkeyB = ED_Mechanics_Hotkeys_HotkeyB.GetValue() as int
	
	bool __hasPotence = playerRef.HasSpell(ED_VampirePowers_Power_DeadlyStrengthTog)
	bool __hasNF = playerRef.HasSpell(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell)
	
	if __hasPotence && __hasNF
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has both Potence and Necrotic Flesh")
		GoToState("KnowsPotenceAndNF")
		RegisterForKey(__currentHotkeyB)
	elseif __hasPotence
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has Potence, but not Necrotic Flesh")
		GoToState("KnowsOnlyPotence")
		RegisterForKey(__currentHotkeyB)
	elseif __hasNF
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has Necrotic Flesh, but not Potence")
		GoToState("KnowsOnlyNF")
		RegisterForKey(__currentHotkeyB)
	else
		debug.Trace("Everdamned INFO: Hotkey B Manager doesnt know neither Potence nor Necrotic Flesh, not registring")
	endif
	
endfunction

function UnregisterHotkey()
	GoToState("")
	UnRegisterForKey(__currentHotkeyB)
	__currentHotkeyB = 0
endfunction


bool __hotkeyBDown_lock
bool __hotkeyB_handled
bool __chargeJumpFlag
bool __releaseGate
int __jumpBonusLevel

bool __isLShiftPressed


hazard __hazardToPlaceOnJump
event OnUpdate()
	
	if !__hotkeyB_handled
		
		if __jumpBonusLevel < 3
			__jumpBonusLevel += 1
		endif
		
		debug.Trace("Everdamned DEBUG: Jump bonus will now be level: " + __jumpBonusLevel)
		
		__hazardToPlaceOnJump = JumpBonusHazardArray[__jumpBonusLevel]
		JumpBonusSpellArray[__jumpBonusLevel].Cast(playerRef)
		RegisterForSingleUpdate(0.3)
	endif	
	
endevent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	debug.Trace("Everdamned DEBUG: Animation event caught: " + asEventName)
	
	if !__hotkeyB_handled
		__releaseGate = False
		__hotkeyB_handled = true
		
		;charge release sound
		;dispel
		Sound.StopInstance(chargeSoundInstance)
		ED_Art_Imod_ExtendedPerception_Out.Apply()
		playerRef.placeatme(__hazardToPlaceOnJump)
		ED_Mechanics_PotenceJumpBonusCleanser_Spell.Cast(playerRef)
	endif
	
	;cant unregister in this event handler if dont wait
	utility.wait(0.1)
	UnRegisterForAnimationEvent(playerRef, "JumpUp")
endevent


state KnowsOnlyPotence
	Event OnKeyDown(int keyCode)
		if Utility.IsInMenuMode()
			return
		endif
		if keyCode == __currentHotkeyB
			if __hotkeyBDown_lock
				return
			endif
			__releaseGate = True
			__hotkeyB_handled = false
			__hotkeyBDown_lock = True
			__chargeJumpFlag = False
			
			debug.Trace("Everdamned DEBUG: Hotkey B was pressed in KnowsOnlyPotence state! ---------------------------------------------")
			
			;TODO: handle player having or not having certain spells for hotkeys
			
			
			if __hotkeyB_handled
				__releaseGate = False
				__hotkeyB_handled = false
				debug.Trace("Everdamned WARNING: Hotkey B press event happened after release event done did it, returning")
				__hotkeyBDown_lock = false
				return
			endif
			
			utility.wait(TapMaxLength)
			
			__jumpBonusLevel = 0
			__hazardToPlaceOnJump = None
			RegisterForAnimationEvent(playerRef, "JumpUp")

			; pressing long enough to start charging jump
			if !__hotkeyB_handled
				debug.Trace("Everdamned DEBUG: setting __chargeJumpFlag to true")
				__chargeJumpFlag = true

				chargeSoundInstance = ED_Art_SoundM_JumpCharge.Play(playerRef)
				ED_Mechanics_PotenceJumpBonus1_Spell.Cast(playerRef)
				RegisterForSingleUpdate(0.3)
			
			; work is already done, invalidate
			else
				UnRegisterForAnimationEvent(playerRef, "JumpUp")
				__releaseGate = False
				__hotkeyB_handled = false
			endif
			
			__hotkeyBDown_lock = false
		endif

	endevent


	Event OnKeyUp(Int KeyCode, Float HoldTime)
		bool __inMenuMode = Utility.IsInMenuMode()
		if !__chargeJumpFlag && __inMenuMode
			return
		endif
		if __releaseGate && keyCode == __currentHotkeyB 
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B got released!")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				; jump
				if __chargeJumpFlag
					debug.Trace("Everdamned DEBUG: Hotkey B release taps jump key")
					
					; wait waits for menu mode to end
					; releasing in menu mode doesnt work as intended
					if __inMenuMode
						utility.wait(0.01)
					endif
					
					ED_Art_Imod_ExtendedPerception_Out.Apply()
					TapKey(SpacebarKey)
					Sound.StopInstance(chargeSoundInstance)
					playerRef.placeatme(__hazardToPlaceOnJump)
					utility.wait(0.1)
					
					ED_Mechanics_PotenceJumpBonusCleanser_Spell.Cast(playerRef)
					UnRegisterForUpdate()
					
				; toggle Deadly Strength	
				else
					playerRef.DoCombatSpellApply(ED_VampirePowers_Power_DeadlyStrengthTog, None)
					debug.Trace("Everdamned DEBUG: Hotkey B release toggles deadly strength")
				endif
			
			endif
			

		endif
	endevent
	
	
endstate


state KnowsOnlyNF
	Event OnKeyDown(int keyCode)
		if Utility.IsInMenuMode()
			return
		endif
		if keyCode == __currentHotkeyB
			if __hotkeyBDown_lock
				return
			endif
			__releaseGate = True
			__hotkeyB_handled = false
			__hotkeyBDown_lock = True
			
			debug.Trace("Everdamned DEBUG: Hotkey B was pressed in KnowsOnlyNF state! ---------------------------------------------")
			
			;TODO: handle player having or not having certain spells for hotkeys
			
			__isLShiftPressed = IsKeyPressed(LShift)
			
			if __hotkeyB_handled
				__releaseGate = False
				__hotkeyB_handled = false
				debug.Trace("Everdamned WARNING: Hotkey B press event happened after release event done did it, returning")
				__hotkeyBDown_lock = false
				return
			endif
			
			if __isLShiftPressed
				__releaseGate = False
				__hotkeyB_handled = True
				playerRef.DoCombatSpellApply(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell, None)
				
				__hotkeyBDown_lock = false
				return
			endif
			
			__hotkeyBDown_lock = false
			
		endif

	endevent


	Event OnKeyUp(Int KeyCode, Float HoldTime)
		if Utility.IsInMenuMode()
			return
		endif
		if keyCode == __currentHotkeyB && __releaseGate
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B got released!")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				__isLShiftPressed = IsKeyPressed(LShift)
				
				if __isLShiftPressed
					playerRef.DoCombatSpellApply(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell, None)
					debug.Trace("Everdamned DEBUG: Hotkey B release applies Necrotic Flesh! Unlikely event, but ok")
				endif
			
			endif
			
		endif
	endevent
endstate


state KnowsPotenceAndNF
	Event OnKeyDown(int keyCode)
		if Utility.IsInMenuMode()
			return
		endif
		if keyCode == __currentHotkeyB
			if __hotkeyBDown_lock
				return
			endif
			__releaseGate = True
			__hotkeyB_handled = false
			__hotkeyBDown_lock = True
			__chargeJumpFlag = False
			
			debug.Trace("Everdamned DEBUG: Hotkey B was pressed in KnowsPotenceAndNF state! ---------------------------------------------")
			
			;TODO: handle player having or not having certain spells for hotkeys
			
			__isLShiftPressed = IsKeyPressed(LShift)
			
			if __hotkeyB_handled
				__releaseGate = False
				__hotkeyB_handled = false
				debug.Trace("Everdamned WARNING: Hotkey B press event happened after release event done did it, returning")
				__hotkeyBDown_lock = false
				return
			endif
			
			
			if __isLShiftPressed
				__releaseGate = False
				__hotkeyB_handled = True
				playerRef.DoCombatSpellApply(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell, None)
				
				__hotkeyBDown_lock = false
				return
			endif
			
			utility.wait(TapMaxLength)
			
			__jumpBonusLevel = 0
			__hazardToPlaceOnJump = None
			RegisterForAnimationEvent(playerRef, "JumpUp")

			; pressing long enough to start charging jump
			if !__hotkeyB_handled
				debug.Trace("Everdamned DEBUG: setting __chargeJumpFlag to true")
				__chargeJumpFlag = true
				
				chargeSoundInstance = ED_Art_SoundM_JumpCharge.Play(playerRef)
				ED_Mechanics_PotenceJumpBonus1_Spell.Cast(playerRef)
				RegisterForSingleUpdate(0.3)
			
			; work is already done, invalidate
			else
				UnRegisterForAnimationEvent(playerRef, "JumpUp")
				__releaseGate = False
				__hotkeyB_handled = false
			endif
			
			__hotkeyBDown_lock = false
		endif

	endevent


	Event OnKeyUp(Int KeyCode, Float HoldTime)
		bool __inMenuMode = Utility.IsInMenuMode()
		if !__chargeJumpFlag && __inMenuMode
			return
		endif
		if __releaseGate && keyCode == __currentHotkeyB 
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B got released!")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				__isLShiftPressed = IsKeyPressed(LShift)
				
				; jump
				if __chargeJumpFlag
					debug.Trace("Everdamned DEBUG: Hotkey B release taps jump key")
					
					; wait waits for menu mode to end
					; releasing in menu mode doesnt work as intended
					if __inMenuMode
						utility.wait(0.01)
					endif
					
					ED_Art_Imod_ExtendedPerception_Out.Apply()
					TapKey(SpacebarKey)
					Sound.StopInstance(chargeSoundInstance)
					playerRef.placeatme(__hazardToPlaceOnJump)
					utility.wait(0.1)
					
					ED_Mechanics_PotenceJumpBonusCleanser_Spell.Cast(playerRef)
					UnRegisterForUpdate()
					
				elseif __isLShiftPressed
					playerRef.DoCombatSpellApply(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell, None)
					debug.Trace("Everdamned DEBUG: Hotkey B release applies Necrotic Flesh! Unlikely event, but ok")
				; toggle Deadly Strength	
				else
					playerRef.DoCombatSpellApply(ED_VampirePowers_Power_DeadlyStrengthTog, None)
					debug.Trace("Everdamned DEBUG: Hotkey B release toggles deadly strength")
				endif
			
			endif
			
		endif
	endevent
endstate




globalvariable property ED_Mechanics_Hotkeys_HotkeyB auto

spell property ED_VampirePowers_Power_DeadlyStrengthTog auto
spell[] property JumpBonusSpellArray auto
spell property ED_Mechanics_PotenceJumpBonus1_Spell auto
spell property ED_Mechanics_PotenceJumpBonusCleanser_Spell auto
spell property ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell auto
hazard[] property JumpBonusHazardArray auto

sound property ED_Art_SoundM_JumpCharge auto
imagespacemodifier property ED_Art_Imod_ExtendedPerception_Out auto

actor property playerRef auto
