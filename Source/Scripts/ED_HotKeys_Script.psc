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
keyword property ED_Mechanics_Keyword_StartMesmerizeQuest auto
spell property Firebolt auto
activator property FXEmptyActivator auto
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentTestHotkey
		;Debug.MessageBox("Everdamned DEBUG: test key was pressed!")
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		;objectreference __aThing = Game.GetCurrentConsoleRef()
		;debug.Trace("Everdamned DEBUG: Current angle: " + __aThing.GetAngleZ())
		;debug.Trace("Everdamned DEBUG: Current angle sin: " + math.sin(__aThing.GetAngleZ()))
		;debug.Trace("Everdamned DEBUG: Current angle cos: " + math.cos(__aThing.GetAngleZ()))
		
		objectreference __targetThing = Game.GetCurrentConsoleRef()
		objectreference __activator = __targetThing.PlaceAtMe(FXEmptyActivator)

		;float zOffset  = __activator.GetHeadingAngle(akSpeaker)
		;__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activator.GetAngleZ() + zOffset)

		while !(__activator.Is3DLoaded())
			debug.Trace("Everdamned DEBUG: FXEmptyActivator 3d is not yet loaded!")
			utility.wait(0.1)
		endwhile

		float __activatorAngleZ = __activator.GetAngleZ()
		__activator.MoveTo(__targetThing, 100.0*math.sin(__activatorAngleZ), 100.0*math.cos(__activatorAngleZ), 100.0)
		__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activatorAngleZ + 180.0)

		Firebolt.RemoteCast(__activator, __targetThing as actor, __targetThing)
		
		;ED_Mechanics_Keyword_StartMesmerizeQuest.SendStoryEvent(akRef1 = Game.GetCurrentConsoleRef())
		
	Endif
	
	
	
EndEvent


GlobalVariable Property ED_Test_Hotkey Auto
