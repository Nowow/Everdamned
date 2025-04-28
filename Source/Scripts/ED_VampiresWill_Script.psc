Scriptname ED_VampiresWill_Script extends activemagiceffect  


actor __currentTarget

Event OnEffectStart(Actor Target, Actor Caster)
	__currentTarget = ED_VampiresWillTarget1.GetReference() as actor
	ED_VampiresWillTarget1.ForceRefTo(Target)
	if __currentTarget && __currentTarget != Target
		__currentTarget.dispelspell(ED_VampirePowers_Pw_VampiresWill_Spell)
	endif
	
EndEvent


referencealias property ED_VampiresWillTarget1 auto
spell property ED_VampirePowers_Pw_VampiresWill_Spell auto 
