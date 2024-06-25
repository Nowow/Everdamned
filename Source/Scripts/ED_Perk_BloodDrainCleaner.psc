Scriptname ED_Perk_BloodDrainCleaner extends activemagiceffect

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.notification("With a last drop of blood your powers fizzle out...")
	akTarget.addspell(CleanerSpell, false)
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.removespell(CleanerSpell)
Endevent


SPELL Property CleanerSpell Auto
