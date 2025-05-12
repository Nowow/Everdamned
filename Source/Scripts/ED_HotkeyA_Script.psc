Scriptname ED_HotkeyA_Script extends Quest  


float property TapMaxLength = 0.3 auto

int __currentHotkeyA
function RegisterHotkey()
	__currentHotkeyA = ED_Mechanics_Hotkeys_HotkeyA.GetValue() as int
	RegisterForKey(__currentHotkeyA)
endfunction

function UnregisterHotkey()
	UnRegisterForKey(__currentHotkeyA)
	__currentHotkeyA = 0	
endfunction


bool __playerHasCelerity
bool __hotkeyADown_lock
bool __hotkeyA_handled
int __hotkeyAUP_gate = 1

Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	if __hotkeyADown_lock
		return
	endif
	__hotkeyADown_lock = True
	
	debug.Trace("Everdamned DEBUG: Hotkey A was pressed! ---------------------------------------------")
	
	__playerHasCelerity = playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
	
	; if somehow release event got to it faster
	; rare race condition i guess
	if __hotkeyA_handled
		__hotkeyA_handled = false
		__hotkeyAUP_gate = 1
		debug.Trace("Everdamned WARNING: Hotkey A press event happened after release event done did it, returning")
		return
	endif
	
	if __playerHasCelerity
		__hotkeyA_handled = true
		playerRef.DoCombatSpellApply(ED_VampirePowers_WickedWind_Spell, None)
		debug.Trace("Everdamned DEBUG: Hotkey A pressed under Celerity, casted Wicked Wind")
	
	else
		utility.wait(TapMaxLength)
		
		; if not yet handled, means OnKeyUp has not yet fired
		; do the work and let OnKeyUp invalidate
		if !__hotkeyA_handled
			__hotkeyA_handled = true
			playerRef.DoCombatSpellApply(ED_VampirePowers_Power_ExtendedPerceptionTog, None)
			
		; work is already done, invalidate
		else
			__hotkeyA_handled = false
		endif
		
	endif
	__hotkeyADown_lock = false
	__hotkeyAUP_gate = 1
endevent


Event OnKeyUp(Int KeyCode, Float HoldTime)
	If __hotkeyAUP_gate > 0
		__hotkeyAUP_gate -= 1
		
		; if not yet handled, means OnKeyDown is on wait still
		; which also means it is NOT Wicked Wind cast
		; do the work and let OnKeyDown invalidate
		if !__hotkeyA_handled
			__hotkeyA_handled = true
			
			if playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
				playerRef.DoCombatSpellApply(ED_VampirePowers_WickedWind_Spell, None)
				debug.Trace("Everdamned DEBUG: Hotkey A released under Celerity, casted Wicked Wind")
			else
				playerRef.DoCombatSpellApply(ED_VampirePowers_Power_Celerity, None)
				debug.Trace("Everdamned DEBUG: Hotkey A released and applied celerity!")
			endif
		; work is already done, invalidate
		else
			__hotkeyA_handled = false
			debug.Trace("Everdamned DEBUG: Hotkey A released, but press was already handled!")
		endif
	endif
endevent


globalvariable property ED_Mechanics_Hotkeys_HotkeyA auto

spell property ED_VampirePowers_WickedWind_Spell auto
spell property ED_VampirePowers_Power_Celerity auto
spell property ED_VampirePowers_Power_ExtendedPerceptionTog auto
magiceffect property ED_VampirePowers_Effect_CelerityTime auto

actor property playerRef auto 
