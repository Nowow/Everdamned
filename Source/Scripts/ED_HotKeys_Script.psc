Scriptname ED_HotKeys_Script extends Quest  


GlobalVariable Property ED_Test_Hotkey Auto

ED_HotkeyA_Script property HotkeyA_Script auto
ED_HotkeyB_Script property HotkeyB_Script auto

int __currentTestHotkey
Function InitializeHotkeys()

	HotkeyA_Script.RegisterHotkey()
	HotkeyB_Script.RegisterHotkey()

	;__currentTestHotkey = ED_Test_Hotkey.GetValue() as int
	;RegisterForKey(__currentTestHotkey)
EndFunction

Function UnRegisterHotkeys()
	HotkeyA_Script.UnregisterHotkey()
	HotkeyB_Script.UnregisterHotkey()

	;UnRegisterForKey(__currentTestHotkey)
	;__currentTestHotkey = 0
EndFunction

Function RegisterHotkeys()
	UnRegisterHotkeys()
	InitializeHotkeys()
endfunction
