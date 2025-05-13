Scriptname ED_HotkeyB_Script extends Quest  

import input

int SpacebarKey = 57
float property TapMaxLength = 0.3 auto

int __currentHotkeyB
function RegisterHotkey()
	__currentHotkeyB = ED_Mechanics_Hotkeys_HotkeyB.GetValue() as int
	RegisterForKey(__currentHotkeyB)
endfunction

function UnregisterHotkey()
	UnRegisterForKey(__currentHotkeyB)
	__currentHotkeyB = 0
endfunction


bool __hotkeyBDown_lock
bool __hotkeyB_handled
bool __chargeJumpFlag
bool __releaseGate
int __jumpBonusLevel
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
		
		debug.Trace("Everdamned DEBUG: Hotkey B was pressed! ---------------------------------------------")
		
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
				debug.Trace("Everdamned DEBUG: Hotkey B release toggles deadly strength")
				playerRef.DoCombatSpellApply(ED_VampirePowers_Power_DeadlyStrengthTog, None)
			endif
		
		endif
		

	endif
endevent


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


globalvariable property ED_Mechanics_Hotkeys_HotkeyB auto

spell property ED_VampirePowers_Power_DeadlyStrengthTog auto
spell[] property JumpBonusSpellArray auto
spell property ED_Mechanics_PotenceJumpBonus1_Spell auto
spell property ED_Mechanics_PotenceJumpBonusCleanser_Spell auto

actor property playerRef auto
