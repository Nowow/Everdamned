Scriptname ED_WickedWindActivatorHotkeyed_Script extends ObjectReference  



function OnLoad()
	

	ED_VampirePowers_WickedWind_Invis_Spell.Cast(PlayerRef as ObjectReference, none)
	Float XLoc = self.GetPositionX()
	Float YLoc = self.GetPositionY()
	Float ZLoc = self.GetPositionZ()
	PlayerRef.TranslateTo(XLoc, YLoc, ZLoc + 48 as Float, 0.000000, 0.000000, 0.000000, 50000.0, 0.000000)
	ED_Art_Imod_Grayish_DispelMagic.Apply(1.00000)
	ED_Art_SoundM_WickedWind_Slow.Play(self as ObjectReference)

	
	utility.Wait(5.00000)
	self.Delete()
endFunction

spell property ED_VampirePowers_WickedWind_Invis_Spell auto
imagespacemodifier property ED_Art_Imod_Grayish_DispelMagic auto
sound property ED_Art_SoundM_WickedWind_Slow auto


actor property playerRef auto
