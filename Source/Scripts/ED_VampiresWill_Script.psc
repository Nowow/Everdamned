Scriptname ED_VampiresWill_Script extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	actor __currentTarget = ED_VampiresWillTarget1.GetReference() as actor
	if __currentTarget
		__currentTarget.dispelspell(ED_VampirePowers_Pw_VampiresWill_Spell)
	endif
	ED_VampiresWillTarget1.ForceRefTo(Target)
EndEvent


referencealias property ED_VampiresWillTarget1 auto
spell property ED_VampirePowers_Pw_VampiresWill_Spell auto 
