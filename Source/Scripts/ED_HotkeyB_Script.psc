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
int __jumpBonusLevel
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	if __hotkeyBDown_lock
		return
	endif
	__hotkeyBDown_lock = True
	__chargeJumpFlag = False
	
	debug.Trace("Everdamned DEBUG: Hotkey B was pressed! ---------------------------------------------")
	
	if __hotkeyB_handled
		__hotkeyB_handled = false
		debug.Trace("Everdamned WARNING: Hotkey B press event happened after release event done did it, returning")
		return
	endif
	
	utility.wait(TapMaxLength)
	
	__jumpBonusLevel = 0
	RegisterForAnimationEvent(playerRef, "JumpUp")

	; pressing long enough to start charging jump
	if !__hotkeyB_handled
		__chargeJumpFlag = true
		; play sound
		; VTMB blood purge good sound
		
		ED_Mechanics_PotenceJumpBonus1_Spell.Cast(playerRef)
		RegisterForSingleUpdate(0.3)
	
	; work is already done, invalidate
	else
		UnRegisterForAnimationEvent(playerRef, "JumpUp")
		__hotkeyB_handled = false
	endif
	
	__hotkeyBDown_lock = false

endevent


Event OnKeyUp(Int KeyCode, Float HoldTime)
	if !__hotkeyB_handled
		__hotkeyB_handled = true
		
		; jump
		if __chargeJumpFlag
			TapKey(SpacebarKey)
			UnRegisterForUpdate()

		; toggle Deadly Strength
		else
			playerRef.DoCombatSpellApply(ED_VampirePowers_Power_DeadlyStrengthTog, None)
		endif
		
	else
		__hotkeyB_handled = false
	endif
endevent


globalvariable property ED_Mechanics_Hotkeys_HotkeyB auto

spell property ED_VampirePowers_Power_DeadlyStrengthTog auto
spell[] property JumpBonusSpellArray auto
spell property ED_Mechanics_PotenceJumpBonus1_Spell auto

actor property playerRef auto
