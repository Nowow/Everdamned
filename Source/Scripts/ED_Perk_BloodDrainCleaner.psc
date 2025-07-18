Scriptname ED_Perk_BloodDrainCleaner extends activemagiceffect


Event OnEffectStart(Actor akTarget, Actor akCaster)
	;debug.SendAnimationEvent(akTarget, "InterruptCast")
	akTarget.InterruptCast()
	ED_Mechanics_BloodCost_Message_PowersFizzleOut.show()
	CleanerSpell.cast(akTarget, akTarget)
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.removespell(CleanerSpell)
Endevent


SPELL Property CleanerSpell Auto
message property ED_Mechanics_BloodCost_Message_PowersFizzleOut auto
