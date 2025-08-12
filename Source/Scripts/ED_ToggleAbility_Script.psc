Scriptname ED_ToggleAbility_Script extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget.HasMagicEffect(MagicEffectToTest)
		if ToggleOffSound
			ToggleOffSound.Play(akTarget)
		endif
		akTarget.RemoveSpell(AbilityToToggle)
	else
		; for cases like automatic ability wipe with drain cleaner
		; because it dispells the effect, but does not remove the spell
		akTarget.RemoveSpell(AbilityToToggle)
		if ToggleOnSound
			ToggleOnSound.Play(akTarget)
		endif
		akTarget.AddSpell(AbilityToToggle)
	endif
endevent

spell property AbilityToToggle auto
magiceffect property MagicEffectToTest auto

sound property ToggleOnSound auto
sound property ToggleOffSound auto
