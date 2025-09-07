Scriptname ED_BloodResonanceProc_Script extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	ED_Art_VFX_BloodResonance.Play(Caster, 1.0)
endevent

visualeffect property ED_Art_VFX_BloodResonance auto
