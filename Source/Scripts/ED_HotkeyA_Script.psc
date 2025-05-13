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
bool __releaseGate
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	if keyCode == __currentHotkeyA
		if __hotkeyADown_lock
			return
		endif
		__hotkeyADown_lock = True
		__releaseGate = True
		__hotkeyA_handled = False
		
		debug.Trace("Everdamned DEBUG: Hotkey A was pressed! ---------------------------------------------")
		
		__playerHasCelerity = playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
		
		; if somehow release event got to it faster
		; rare race condition i guess
		if __hotkeyA_handled
			__hotkeyA_handled = false
			__releaseGate = false
			
			debug.Trace("Everdamned WARNING: Hotkey A press event happened after release event done did it, returning")
			__hotkeyADown_lock = false
			return
		endif
		
		if __playerHasCelerity
			__hotkeyA_handled = true
			__releaseGate = False
			playerRef.DoCombatSpellApply(ED_VampirePowers_WickedWind_Spell, None)
			debug.Trace("Everdamned DEBUG: Hotkey A pressed under Celerity, casted Wicked Wind")
		
		else
			utility.wait(TapMaxLength)
			
			; if not yet handled, means OnKeyUp has not yet fired
			; do the work and let OnKeyUp invalidate
			if !__hotkeyA_handled
				__hotkeyA_handled = true
				__releaseGate = false
				debug.Trace("Everdamned DEBUG: Hotkey A pressed long enough, casting Extended Perception")
				playerRef.DoCombatSpellApply(ED_VampirePowers_Power_ExtendedPerceptionTog, None)
				
			; work is already done, invalidate
			else
				debug.Trace("Everdamned DEBUG: Hotkey A press found out release already did the job")

			endif
			
		endif
		__hotkeyADown_lock = false
	endif
endevent


Event OnKeyUp(Int KeyCode, Float HoldTime)
	if Utility.IsInMenuMode()
		return
	endif
	
	if keyCode == __currentHotkeyA  && __releaseGate
		debug.Trace("Everdamned DEBUG: Hotkey A release button fired through gate!")

		__releaseGate = False
		
		if !__hotkeyA_handled
			__hotkeyA_handled = true
			if playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
				playerRef.DoCombatSpellApply(ED_VampirePowers_WickedWind_Spell, None)
				debug.Trace("Everdamned DEBUG: Hotkey A released under Celerity, casted Wicked Wind")
			else
				playerRef.DoCombatSpellApply(ED_VampirePowers_Power_Celerity, None)
				debug.Trace("Everdamned DEBUG: Hotkey A released and applied celerity!")
			endif
		else
			debug.Trace("Everdamned DEBUG: Hotkey A released, but work is already done")
		endif

	endif
endevent


globalvariable property ED_Mechanics_Hotkeys_HotkeyA auto

spell property ED_VampirePowers_WickedWind_Spell auto
spell property ED_VampirePowers_Power_Celerity auto
spell property ED_VampirePowers_Power_ExtendedPerceptionTog auto
magiceffect property ED_VampirePowers_Effect_CelerityTime auto

actor property playerRef auto 
