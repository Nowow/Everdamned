Scriptname ED_HotkeyB_Script extends Quest  

import input

int SpacebarKey = 0x39
int LShift = 0x2A

float property TapMaxLength = 0.3 auto


int __currentHotkeyB
function RegisterHotkey()
	__currentHotkeyB = ED_Mechanics_Hotkeys_HotkeyB.GetValue() as int
	
	bool __hasPotence = playerRef.HasSpell(ED_VampirePowers_Power_DeadlyStrengthTog)
	bool __hasDash = playerRef.HasSpell(ED_VampirePowers_DarkwingDash_Init_Power)
	
	if __hasPotence && __hasDash
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has both Potence and Darkwing Dash")
		GoToState("KnowsPotenceAndDash")
		RegisterForKey(__currentHotkeyB)
	elseif __hasPotence
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has Potence, but not Darkwing Dash")
		GoToState("KnowsOnlyPotence")
		RegisterForKey(__currentHotkeyB)
	elseif __hasDash
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has Darkwing Dash, but not Potence")
		GoToState("KnowsOnlyDash")
		RegisterForKey(__currentHotkeyB)
	else
		debug.Trace("Everdamned INFO: Hotkey B Manager doesnt know neither Potence nor Darkwing Dash, not registring")
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



event OnUpdate()
	
	if !__hotkeyB_handled
		
		if __jumpBonusLevel < 3
			__jumpBonusLevel += 1
		endif
		
		debug.Trace("Everdamned DEBUG: Jump bonus will now be level: " + __jumpBonusLevel)
		
		JumpBonusSpellArray[__jumpBonusLevel].Cast(playerRef)
		RegisterForSingleUpdate(0.3)
	endif	
	
endevent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	debug.Trace("Everdamned DEBUG: Animation event caught: " + asEventName)
	
	if !__hotkeyB_handled
		__releaseGate = False
		__hotkeyB_handled = true
	endif
	
	;charge release sound
	;dispel
	ED_Mechanics_PotenceJumpBonusCleanser_Spell.Cast(playerRef)
	
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
			RegisterForAnimationEvent(playerRef, "JumpUp")

			; pressing long enough to start charging jump
			if !__hotkeyB_handled
				debug.Trace("Everdamned DEBUG: setting __chargeJumpFlag to true")
				__chargeJumpFlag = true
				; play sound
				; VTMB blood purge good sound
				
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
		if Utility.IsInMenuMode()
			return
		endif
		if keyCode == __currentHotkeyB && __releaseGate
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B got released!")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				; jump
				if __chargeJumpFlag
					debug.Trace("Everdamned DEBUG: Hotkey B release taps jump key")
					TapKey(SpacebarKey)
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


state KnowsOnlyDash
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
			
			debug.Trace("Everdamned DEBUG: Hotkey B was pressed in KnowsOnlyDash state! ---------------------------------------------")
			
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
				playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
				
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
					playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
					debug.Trace("Everdamned DEBUG: Hotkey B release applies Darkwing Dash! Unlikely event, but ok")
				endif
			
			endif
			
		endif
	endevent
endstate


state KnowsPotenceAndDash
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
			
			debug.Trace("Everdamned DEBUG: Hotkey B was pressed in KnowsPotenceAndDash state! ---------------------------------------------")
			
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
				playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
				
				__hotkeyBDown_lock = false
				return
			endif
			
			utility.wait(TapMaxLength)
			
			__jumpBonusLevel = 0
			RegisterForAnimationEvent(playerRef, "JumpUp")

			; pressing long enough to start charging jump
			if !__hotkeyB_handled
				debug.Trace("Everdamned DEBUG: setting __chargeJumpFlag to true")
				__chargeJumpFlag = true
				; play sound
				; VTMB blood purge good sound
				
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
		if Utility.IsInMenuMode()
			return
		endif
		if keyCode == __currentHotkeyB && __releaseGate
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B got released!")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				__isLShiftPressed = IsKeyPressed(LShift)
				
				; jump
				if __chargeJumpFlag
					debug.Trace("Everdamned DEBUG: Hotkey B release taps jump key")
					TapKey(SpacebarKey)
					UnRegisterForUpdate()
					
				elseif __isLShiftPressed
					playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
					debug.Trace("Everdamned DEBUG: Hotkey B release applies Darkwing Dash! Unlikely event, but ok")
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
spell property ED_VampirePowers_DarkwingDash_Init_Power auto

actor property playerRef auto
