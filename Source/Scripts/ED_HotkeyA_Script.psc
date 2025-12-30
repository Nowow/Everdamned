Scriptname ED_HotkeyA_Script extends Quest  


import input

int LShift = 0x2A

float property TapMaxLength = 0.3 auto

bool __hasDash
int __currentHotkeyA
function RegisterHotkey()
	__currentHotkeyA = ED_Mechanics_Hotkeys_HotkeyA.GetValue() as int
	
	bool __hasExtendedPerception = playerRef.HasSpell(ED_VampirePowers_Power_ExtendedPerceptionTog)
	bool __hasCelerity = playerRef.HasSpell(ED_VampirePowers_Power_Celerity)
	bool __hasWickedWind = playerRef.HasSpell(ED_VampirePowers_WickedWind_Spell)
	__hasDash = playerRef.HasSpell(ED_VampirePowers_DarkwingDash_Init_Power)
	
	if __hasWickedWind
		GoToState("KnowsWickedWind")
		RegisterForKey(__currentHotkeyA)
		debug.Trace("Everdamned INFO: Hotkey A Manager determined player has Wicked Wind, meaning he has all Celerity spells")		
	elseif __hasCelerity
		GoToState("KnowsCelerity")
		RegisterForKey(__currentHotkeyA)
		debug.Trace("Everdamned INFO: Hotkey A Manager determined player has Celerity and Extended Perception by extension")		
	elseif __hasExtendedPerception
		GoToState("KnowsExtendedPerception")
		RegisterForKey(__currentHotkeyA)
		debug.Trace("Everdamned INFO: Hotkey A Manager determined player only has Extended Perception")		
	elseif __hasDash
		GoToState("KnowsOnlyDash")
		RegisterForKey(__currentHotkeyA)
		debug.Trace("Everdamned INFO: Hotkey A Manager determined player only has Dash")		
	else
		debug.Trace("Everdamned INFO: Hotkey A Manager determined player has no Celerity skills, not registering")		
	endif
	
endfunction

function UnregisterHotkey()
	GoToState("")
	UnRegisterForKey(__currentHotkeyA)
	__currentHotkeyA = 0	
endfunction


bool __playerHasCelerity
bool __hotkeyADown_lock
bool __hotkeyA_handled
bool __releaseGate
bool __isLShiftPressed


state KnowsOnlyDash
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	if keyCode == __currentHotkeyA
		if __hotkeyADown_lock
			return
		endif
		__hotkeyADown_lock = True

		debug.Trace("Everdamned DEBUG: Hotkey A was pressed in KnowsOnlyDash state! ---------------------------------------------")
		
		if IsKeyPressed(LShift)
			debug.Trace("Everdamned DEBUG: Hotkey A pressed, casting Dash")
			playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
		endif

		__hotkeyADown_lock = false
	endif
endevent
endstate


state KnowsExtendedPerception
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	if keyCode == __currentHotkeyA
		if __hotkeyADown_lock
			return
		endif
		__hotkeyADown_lock = True

		debug.Trace("Everdamned DEBUG: Hotkey A was pressed in KnowsExtendedPerception state! ---------------------------------------------")
		
		__isLShiftPressed = IsKeyPressed(LShift)
		
		if __isLShiftPressed && __hasDash
			playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
			__hotkeyADown_lock = false
			return
		endif
	
		utility.wait(TapMaxLength)
		
		if isKeyPressed(__currentHotkeyA)
			debug.Trace("Everdamned DEBUG: Hotkey A pressed long enough, casting Extended Perception")
			playerRef.DoCombatSpellApply(ED_VampirePowers_Power_ExtendedPerceptionTog, None)
		endif

		__hotkeyADown_lock = false
	endif
endevent
endstate


state KnowsCelerity
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
		
		debug.Trace("Everdamned DEBUG: Hotkey A was pressed in KnowsCelerity state! ---------------------------------------------")
		
		__isLShiftPressed = IsKeyPressed(LShift)
		
		; if somehow release event got to it faster
		; rare race condition i guess
		if __hotkeyA_handled
			__hotkeyA_handled = false
			__releaseGate = false
			
			debug.Trace("Everdamned WARNING: Hotkey A press event happened after release event done did it, returning")
			__hotkeyADown_lock = false
			return
		endif
		
		if __isLShiftPressed && __hasDash
			__releaseGate = False
			__hotkeyA_handled = True
			playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
			
			__hotkeyADown_lock = false
			return
		endif
	
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
			
			__isLShiftPressed = IsKeyPressed(LShift)
				
			if __isLShiftPressed && __hasDash
				playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
				debug.Trace("Everdamned DEBUG: Hotkey A release applies Darkwing Dash! Unlikely event, but ok")
			
			elseif !playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
				playerRef.DoCombatSpellApply(ED_VampirePowers_Power_Celerity, None)
				debug.Trace("Everdamned DEBUG: Hotkey A released and applied celerity!")
			endif
		else
			debug.Trace("Everdamned DEBUG: Hotkey A released, but work is already done")
		endif

	endif
endevent
endstate


state KnowsWickedWind
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
		
		debug.Trace("Everdamned DEBUG: Hotkey A was pressed in KnowsWickedWind state! ---------------------------------------------")
		
		__isLShiftPressed = IsKeyPressed(LShift)
		
		; if somehow release event got to it faster
		; rare race condition i guess
		if __hotkeyA_handled
			__hotkeyA_handled = false
			__releaseGate = false
			
			debug.Trace("Everdamned WARNING: Hotkey A press event happened after release event done did it, returning")
			__hotkeyADown_lock = false
			return
		endif
		
		if __isLShiftPressed && __hasDash
			__releaseGate = False
			__hotkeyA_handled = True
			playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
			
			__hotkeyADown_lock = false
			return
		endif
	
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
			
			__isLShiftPressed = IsKeyPressed(LShift)
				
			if __isLShiftPressed && __hasDash
				playerRef.DoCombatSpellApply(ED_VampirePowers_DarkwingDash_Init_Power, None)
				debug.Trace("Everdamned DEBUG: Hotkey A release applies Darkwing Dash! Unlikely event, but ok")
			
			elseif playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
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
endstate


globalvariable property ED_Mechanics_Hotkeys_HotkeyA auto

spell property ED_VampirePowers_WickedWind_Spell auto
spell property ED_VampirePowers_Power_Celerity auto
spell property ED_VampirePowers_Power_ExtendedPerceptionTog auto
spell property ED_VampirePowers_DarkwingDash_Init_Power auto
magiceffect property ED_VampirePowers_Effect_CelerityTime auto

actor property playerRef auto 
