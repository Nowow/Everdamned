Scriptname ED_Perk_BloodDrainCleaner extends activemagiceffect


Event OnEffectStart(Actor akTarget, Actor akCaster)
	ED_Mechanics_BloodCost_Message_PowersFizzleOut.show()
	akTarget.addspell(CleanerSpell, false)
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.removespell(CleanerSpell)
Endevent


SPELL Property CleanerSpell Auto
message property ED_Mechanics_BloodCost_Message_PowersFizzleOut auto
