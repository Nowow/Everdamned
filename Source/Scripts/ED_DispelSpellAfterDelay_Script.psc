Scriptname ED_DispelSpellAfterDelay_Script extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	utility.wait(DelayBeforeDispel)
	akTarget.DispelSpell(SpellToDispel)
endevent


spell property SpellToDispel auto
float property DelayBeforeDispel auto
