Scriptname ED_HotkeyA_Script extends Quest  


import input

float property TapMaxLength = 0.3 auto


int __currentHotkeyA
function RegisterHotkey()
	__currentHotkeyA = ED_Mechanics_Hotkeys_HotkeyA.GetValue() as int
	
	bool __hasExtendedPerception = playerRef.HasSpell(ED_VampirePowers_Power_ExtendedPerceptionTog)
	bool __hasCelerity = playerRef.HasSpell(ED_VampirePowers_Power_Celerity)
	bool __hasWickedWind = playerRef.HasSpell(ED_VampirePowers_WickedWind_Spell)
	
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
		
		; if somehow release event got to it faster
		; rare race condition i guess
		if __hotkeyA_handled
			__hotkeyA_handled = false
			__releaseGate = false
			
			debug.Trace("Everdamned WARNING: Hotkey A press event happened after release event done did it, returning")
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
			if !playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
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
		
		; if somehow release event got to it faster
		; rare race condition i guess
		if __hotkeyA_handled
			__hotkeyA_handled = false
			__releaseGate = false
			
			debug.Trace("Everdamned WARNING: Hotkey A press event happened after release event done did it, returning")
			__hotkeyADown_lock = false
			return
		endif
		
		;if __playerHasCelerity
		;	__hotkeyA_handled = true
		;	__releaseGate = False
		;	playerRef.DoCombatSpellApply(ED_VampirePowers_WickedWind_Spell, None)
		;	debug.Trace("Everdamned DEBUG: Hotkey A pressed under Celerity, casted Wicked Wind")
		
	
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
endstate


globalvariable property ED_Mechanics_Hotkeys_HotkeyA auto

spell property ED_VampirePowers_WickedWind_Spell auto
spell property ED_VampirePowers_Power_Celerity auto
spell property ED_VampirePowers_Power_ExtendedPerceptionTog auto
magiceffect property ED_VampirePowers_Effect_CelerityTime auto

actor property playerRef auto 
