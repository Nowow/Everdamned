Scriptname ED_Perk_BloodDrainCleaner extends activemagiceffect


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
		akTarget.InterruptCast()
		CleanerSound.Play(akTarget)
		ED_Art_Imod_DrainCleaner_DesaturatedLonger.Apply()
		if akTarget.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_DrainsBloodPool)
			ED_Mechanics_BloodCost_Message_PowersFizzleOut.show()
		endif
		CleanerSpell.cast(akTarget, akTarget)
		Game.ShakeCamera(akTarget)
	
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.removespell(CleanerSpell)
Endevent


SPELL Property CleanerSpell Auto
message property ED_Mechanics_BloodCost_Message_PowersFizzleOut auto
sound property CleanerSound auto
imagespacemodifier property ED_Art_Imod_DrainCleaner_DesaturatedLonger auto
keyword property ED_Mechanics_Keyword_DrainsBloodPool auto
