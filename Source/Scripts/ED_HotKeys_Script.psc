Scriptname ED_HotKeys_Script extends Quest  

int __currentTestHotkey

Function RegisterHotkeys()
	__currentTestHotkey = ED_Test_Hotkey.GetValue() as int
	RegisterForKey(__currentTestHotkey)
EndFunction

Function UnRegisterHotkeys()
	UnRegisterForKey(__currentTestHotkey)
	__currentTestHotkey = 0
EndFunction

;debug
scene property ED_Wounded_Distraction_Scene auto
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	;If keyCode == __currentTestHotkey
	;	;Debug.MessageBox("Everdamned DEBUG: test key was pressed!")
	;	debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
	;	
	;	ED_Wounded_Distraction_Scene.Stop()
	;	
	;Endif
	
	debug.sendAnimationEvent(Game.GetPlayer(), "SkyIdles_Crouch")
	
EndEvent

GlobalVariable Property ED_Test_Hotkey Auto
