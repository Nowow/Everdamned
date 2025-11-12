Scriptname ED_HotkeyB_Script extends Quest  

import input

int SpacebarKey = 0x39
int LShift = 0x2A

float property TapMaxLength = 0.3 auto
float property JumpChargeUpdateRate = 0.45 auto

int chargeSoundInstance

; using existing events for VL and WW skeletons because dont want to
; go through the pain of adding new events to non-humanoid skeletons
function RegisterAnimationEvents()
	race __currentPlayerRace = playerRef.GetRace()
	if     __currentPlayerRace == DLC1VampireBeastRace
		RegisterForAnimationEvent(playerRef, "SpecialFeeding")
		debug.Trace("Everdamned INFO: Hotkey B Manager registers animations for VL")
		
	elseif __currentPlayerRace == ED_FeralBeast_Fleder_Race
		RegisterForAnimationEvent(playerRef, "Event00")
		debug.Trace("Everdamned INFO: Hotkey B Manager registers animations for Fleder")
		
	else
		RegisterForAnimationEvent(playerRef, "ed_chargedjumpstart")
		debug.Trace("Everdamned INFO: Hotkey B Manager registers animations for mortal")
	endif

endfunction

function UnregisterAnimationEvents()
	UnRegisterForAnimationEvent(playerRef, "SpecialFeeding")
	UnRegisterForAnimationEvent(playerRef, "Event00")
	UnRegisterForAnimationEvent(playerRef, "ed_chargedjumpstart")
endfunction

int __currentHotkeyB
function RegisterHotkey()
	__currentHotkeyB = ED_Mechanics_Hotkeys_HotkeyB.GetValue() as int
	
	bool __hasPotence = playerRef.HasSpell(ED_VampirePowers_Power_DeadlyStrengthTog)
	bool __hasNF = playerRef.HasSpell(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell)
	
	if __hasPotence && __hasNF
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has both Potence and Necrotic Flesh")
		RegisterAnimationEvents()
		;Event00 ww
		;SpecialFeeding VL
		GoToState("KnowsPotenceAndNF")
		RegisterForKey(__currentHotkeyB)
	elseif __hasPotence
		debug.Trace("Everdamned INFO: Hotkey B Manager determined player has Potence, but not Necrotic Flesh")
		RegisterAnimationEvents()
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
	UnregisterAnimationEvents()
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
		RegisterForSingleUpdate(JumpChargeUpdateRate)
	endif	
	
endevent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	
	ED_Art_Imod_ExtendedPerception_Out.Apply()
	playerRef.placeatme(__hazardToPlaceOnJump)
	ED_Mechanics_PotenceJumpBonusCleanser_Spell.Cast(playerRef)
	
	debug.Trace("Everdamned DEBUG: Hotkey B Animation Event: was caught: " + asEventName)

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
			
			debug.Trace("Everdamned DEBUG: Hotkey B Press Event: was pressed in KnowsOnlyPotence state! ---------------------------------------------")

			if __hotkeyB_handled
				__releaseGate = False
				__hotkeyB_handled = false
				debug.Trace("Everdamned WARNING: Hotkey B Press Event: happened after release event done did it, returning")
				__hotkeyBDown_lock = false
				return
			endif
			
			utility.wait(TapMaxLength)
			
			if !__hotkeyB_handled
				__jumpBonusLevel = 0
				__hazardToPlaceOnJump = JumpBonusHazardArray[0]
				__chargeJumpFlag = true
				
				;losing thread
				ED_Mechanics_PotenceJumpBonus1_Spell.Cast(playerRef)
				RegisterForSingleUpdate(JumpChargeUpdateRate)
				debug.Trace("Everdamned DEBUG: Hotkey B Press Event: was handling long tap to start Charged Jump")
			else
				; Deadly Strength was toggled at release
				; probably redundant
				__releaseGate = False
				debug.Trace("Everdamned DEBUG: Hotkey B Press Event: found out that it was already handled")
			endif
			
			__hotkeyBDown_lock = false

		endif

	endevent


	Event OnKeyUp(Int KeyCode, Float HoldTime)
		;bool __inMenuMode = Utility.IsInMenuMode()
		;if !__chargeJumpFlag && __inMenuMode
		;	return
		;endif
		if __releaseGate && keyCode == __currentHotkeyB 
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B got released!")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				; jump
				if __chargeJumpFlag
								
					; update event would trip over __hotkeyB_handled = true
					UnRegisterForUpdate()
					;Sound.StopInstance(chargeSoundInstance)
								
					debug.Trace("Everdamned DEBUG: Hotkey B Release Event: Stops jump charging")

				; toggle Deadly Strength	
				else
					playerRef.DoCombatSpellApply(ED_VampirePowers_Power_DeadlyStrengthTog, None)
					debug.Trace("Everdamned DEBUG: Hotkey B Release Event: toggles deadly strength")
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
				__hotkeyBDown_lock = false
				debug.Trace("Everdamned WARNING: Hotkey B Press Event: happened after release event done did it, returning")
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
			
			if !__hotkeyB_handled
				__jumpBonusLevel = 0
				__hazardToPlaceOnJump = JumpBonusHazardArray[0]
				__chargeJumpFlag = true
				
				;losing thread
				ED_Mechanics_PotenceJumpBonus1_Spell.Cast(playerRef)
				RegisterForSingleUpdate(JumpChargeUpdateRate)
				debug.Trace("Everdamned DEBUG: Hotkey B Press Event: was handling long tap to start Charged Jump")
			else
				; Deadly Strength was toggled at release
				; probably redundant
				__releaseGate = False
				debug.Trace("Everdamned DEBUG: Hotkey B Press Event: found out that it was already handled")
			endif
			
			__hotkeyBDown_lock = false
		endif

	endevent


	Event OnKeyUp(Int KeyCode, Float HoldTime)
		if __releaseGate && keyCode == __currentHotkeyB 
			__releaseGate = False
			debug.Trace("Everdamned DEBUG: Hotkey B Release Event: fired")
			if !__hotkeyB_handled
				
				__hotkeyB_handled = true
				
				__isLShiftPressed = IsKeyPressed(LShift)
				
				; jump
				if __chargeJumpFlag
								
					; update event would trip over __hotkeyB_handled = true
					UnRegisterForUpdate()
					;Sound.StopInstance(chargeSoundInstance)
								
					debug.Trace("Everdamned DEBUG: Hotkey B Release Event: Stops jump charging")
					
				elseif __isLShiftPressed
					playerRef.DoCombatSpellApply(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell, None)
					debug.Trace("Everdamned DEBUG: Hotkey B Release Event: applies Necrotic Flesh! Unlikely event, but ok")
				; toggle Deadly Strength	
				else
					playerRef.DoCombatSpellApply(ED_VampirePowers_Power_DeadlyStrengthTog, None)
					debug.Trace("Everdamned DEBUG: Hotkey B Release Event: toggles deadly strength")
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

race property DLC1VampireBeastRace auto
race property ED_FeralBeast_Fleder_Race auto

hazard[] property JumpBonusHazardArray auto
imagespacemodifier property ED_Art_Imod_ExtendedPerception_Out auto

actor property playerRef auto
