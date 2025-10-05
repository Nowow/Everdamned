Scriptname ED_WickedWindActivatorHotkeyed_Script extends ObjectReference  


float property BloodCost = 100.0 auto
float property XPgained = 200.0 auto


function OnLoad()

	;if playerRef.GetActorValue("ED_BloodPool") >= BloodCost
	if playerRef.HasMagicEffect(ED_VampirePowers_Celerity_Effect_SlowTimeAb)
		PlayerRef.DoCombatSpellApply(ED_Art_Spell_BackwardsShockwave, self)
		ED_VampirePowers_WickedWind_Invis_Spell.Cast(PlayerRef as ObjectReference, none)
		Float XLoc = self.GetPositionX()
		Float YLoc = self.GetPositionY()
		Float ZLoc = self.GetPositionZ()
		PlayerRef.TranslateTo(XLoc, YLoc, ZLoc + 48 as Float, 0.000000, 0.000000, 0.000000, 50000.0, 0.000000)
		ED_Art_Imod_Grayish_DispelMagic.Apply(1.00000)
		ED_Art_SoundM_WickedWind.Play(self as ObjectReference)
		
		;playerRef.DamageActorValue("ED_BloodPool", BloodCost)
		if playerRef.IsInCombat()
			CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
		endif
		
		utility.Wait(5.00000)
		self.Delete()
	else
		MAGFail.Play(playerRef)
		ED_Mechanics_Message_PowerCantBeUsed.Show()
	endif
endFunction

spell property ED_VampirePowers_WickedWind_Invis_Spell auto
spell property ED_Art_Spell_BackwardsShockwave auto
imagespacemodifier property ED_Art_Imod_Grayish_DispelMagic auto
sound property ED_Art_SoundM_WickedWind auto
sound property MAGFail auto
magiceffect property ED_VampirePowers_Celerity_Effect_SlowTimeAb auto

message property ED_Mechanics_Message_PowerCantBeUsed auto

actor property playerRef auto
