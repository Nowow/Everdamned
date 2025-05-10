Scriptname ED_TeleportActivatorDash_Script extends ObjectReference  


import input

function OnLoad()
	
	int __currentTestHotkey = ED_Test_Hotkey.GetValue() as int
	
	if iskeypressed(__currentTestHotkey)
		bool __started = ED_Mechanics_Quest_WickedWindTargeting.Start()
		debug.Trace("Everdamned DEBUG: ww quest started: " + __started)
		if !__started
			ED_Mechanics_Message_WickedWindCooldown.Show()
		endif
	else
		ED_VampirePowers_WickedWind_Invis_Spell.Cast(PlayerRef as ObjectReference, none)
		Float XLoc = self.GetPositionX()
		Float YLoc = self.GetPositionY()
		Float ZLoc = self.GetPositionZ()
		PlayerRef.TranslateTo(XLoc, YLoc, ZLoc + 48 as Float, 0.000000, 0.000000, 0.000000, 50000.0, 0.000000)
		ED_Art_Imod_Grayish_DispelMagic.Apply(1.00000)
		ED_Art_SoundM_WickedWind_Slow.Play(self as ObjectReference)
	endif
	
	utility.Wait(5.00000)
	self.Delete()
endFunction

spell property ED_VampirePowers_WickedWind_Invis_Spell auto
imagespacemodifier property ED_Art_Imod_Grayish_DispelMagic auto
sound property ED_Art_SoundM_WickedWind_Slow auto

quest property ED_Mechanics_Quest_WickedWindTargeting auto
message property ED_Mechanics_Message_WickedWindCooldown auto
globalvariable property ED_Test_Hotkey auto

actor property playerRef auto
