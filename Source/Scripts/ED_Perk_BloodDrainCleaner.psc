Scriptname ED_Perk_BloodDrainCleaner extends activemagiceffect

import debug

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.notification("Drain Cleaner Activator effect started!")
	akTarget.addspell(CleanerSpell)
Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.notification("Drain Cleaner Activator effect FINISHED!")
	akTarget.removespell(CleanerSpell)
Endevent


SPELL Property CleanerSpell Auto
