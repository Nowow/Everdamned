Scriptname ED_HotKeys_Script extends Quest  


GlobalVariable Property ED_Test_Hotkey Auto

ED_HotkeyA_Script property HotkeyA_Script auto
ED_HotkeyB_Script property HotkeyB_Script auto

int __currentTestHotkey
Function InitializeHotkeys()

	HotkeyA_Script.RegisterHotkey()
	HotkeyB_Script.RegisterHotkey()

	__currentTestHotkey = ED_Test_Hotkey.GetValue() as int
	RegisterForKey(__currentTestHotkey)
EndFunction

Function UnRegisterHotkeys()
	HotkeyA_Script.UnregisterHotkey()
	HotkeyB_Script.UnregisterHotkey()

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
	
	If keyCode == __currentTestHotkey
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		;objectreference __targetThing = Game.GetCurrentConsoleRef()
		
		RegisterForAnimationEvent(playerRef, "JumpUp")
		
		utility.wait(1.0)
		
		int SpacebarKey = 57
		input.TapKey(SpacebarKey)


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


;Event OnKeyUp(Int KeyCode, Float HoldTime)
	
;endevent


action property ActionJump auto

actor property playerRef auto