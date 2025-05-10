Scriptname ED_VampireSeductionApply_Script extends activemagiceffect  

; because a lot of things are dependent on vanilla Vampire Seduction magic effects
; but they are not Target Actor and a world of pain to cast from papyrus
Event OnEffectStart(Actor akTarget, Actor akCaster)
	;ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell.Cast(playerRef, akTarget)
	playerRef.DoCombatSpellApply(ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell, akTarget)
	self.Dispel()
endevent

actor property playerRef auto
spell property ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell auto
