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
spell property FireRune auto
activator property FXEmptyActivator auto
quest property ED_Mechanics_Quest_WickedWindTargeting auto
message property ED_Mechanics_Message_WickedWindCooldown auto
spell property ED_VampirePowers_WickedWind_Spell auto
actor property playerRef auto
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentTestHotkey
		;Debug.MessageBox("Everdamned DEBUG: test key was pressed!")
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		;objectreference __targetThing = Game.GetCurrentConsoleRef()
		
		; it handles rest
		playerRef.DoCombatSpellApply(ED_VampirePowers_WickedWind_Spell, None)
		
		;bool __started = ED_Mechanics_Quest_WickedWindTargeting.Start()
		;debug.Trace("Everdamned DEBUG: ww quest started: " + __started)
		;if !__started
		;	ED_Mechanics_Message_WickedWindCooldown.Show()
		;endif

		
		;(flameCloak).Cast(__targetThing, __targetThing)
		
		;FireRune.Cast(__targetThing)
		
		;objectreference __targetThing = Game.GetCurrentConsoleRef()
		;objectreference __activator = __targetThing.PlaceAtMe(FXEmptyActivator)

		;while !(__activator.Is3DLoaded())
		;	debug.Trace("Everdamned DEBUG: FXEmptyActivator 3d is not yet loaded!")
		;	utility.wait(0.1)
		;endwhile

		;float __activatorAngleZ = __activator.GetAngleZ()
		;__activator.MoveTo(__targetThing, 100.0*math.sin(__activatorAngleZ), 100.0*math.cos(__activatorAngleZ), 100.0)
		;__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activatorAngleZ + 180.0)

		;Firebolt.RemoteCast(__activator, __targetThing as actor, __targetThing)
		
		;ED_Mechanics_Keyword_StartMesmerizeQuest.SendStoryEvent(akRef1 = Game.GetCurrentConsoleRef())
		
	Endif
	
	
	
EndEvent


GlobalVariable Property ED_Test_Hotkey Auto
