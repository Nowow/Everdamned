Scriptname ED_HotKeys_Script extends Quest  


GlobalVariable Property ED_Test_Hotkey Auto

int __currentTestHotkey
Function InitializeHotkeys()

	(GetOwningQuest() as ED_HotkeyA_Script).RegisterHotkey()
	(GetOwningQuest() as ED_HotkeyB_Script).RegisterHotkey()

	RegisterForKey(__currentHotkeyB)
EndFunction

Function UnRegisterHotkeys()
	(GetOwningQuest() as ED_HotkeyA_Script).UnregisterHotkey()
	(GetOwningQuest() as ED_HotkeyB_Script).UnregisterHotkey()

	UnRegisterForKey(__currentTestHotkey)
	__currentTestHotkey = 0
EndFunction

Function RegisterHotkeys()
	UnRegisterHotkeys()
	InitializeHotkeys()
endfunction

Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentHotkeyA
		if __hotkeyADown_lock
			return
		endif
		__hotkeyADown_lock = True
		
		debug.Trace("Everdamned DEBUG: Hotkey A was pressed! ---------------------------------------------")
		
		__playerHasCelerity = playerRef.HasMagicEffect(ED_VampirePowers_Effect_CelerityTime)
		
		; somehow release event got to it faster
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
		
	elseif keyCode == __currentHotkeyB
		
		if __hotkeyBDown_lock
			return
		endif
		__hotkeyBDown_lock = True
		__chargeJumpFlag = False
		
		debug.Trace("Everdamned DEBUG: Hotkey B was pressed! ---------------------------------------------")
		
		if __hotkeyB_handled
			__hotkeyB_handled = false
			;__hotkeyBUP_gate = 1
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
		__hotkeyBUP_gate = 1
		
	elseIf keyCode == __currentTestHotkey
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		;objectreference __targetThing = Game.GetCurrentConsoleRef()
		
		RegisterForAnimationEvent(playerRef, "JumpUp")
		
		utility.wait(1.0)
		
		TapKey(SpacebarKey)


		;while !(__activator.Is3DLoaded())
		;	debug.Trace("Everdamned DEBUG: FXEmptyActivator 3d is not yet loaded!")
		;	utility.wait(0.1)
		;endwhile

		;float __activatorAngleZ = __activator.GetAngleZ()
		;__activator.MoveTo(__targetThing, 100.0*math.sin(__activatorAngleZ), 100.0*math.cos(__activatorAngleZ), 100.0)
		;__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activatorAngleZ + 180.0)

		;Firebolt.RemoteCast(__activator, __targetThing as actor, __targetThing)
		
		
	Endif
EndEvent


Event OnKeyUp(Int KeyCode, Float HoldTime)

	
	If keyCode == __currentHotkeyA && __hotkeyAUP_gate > 0
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
	
	elseIf keyCode == __currentHotkeyB
		
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
		
	endif
	
endevent


event OnUpdate()
	
	if !__hotkeyB_handled
		
		if __jumpBonusLevel < 3
			__jumpBonusLevel += 1
		endif
		
		JumpBonusSpellArray[__jumpBonusLevel].Cast(playerRef)
		RegisterForSingleUpdate(0.3)
	endif	
	
endevent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	debug.Trace("Everdamned DEBUG: Animation event caught: " + asEventName)
endevent

action property ActionJump auto

actor property playerRef auto