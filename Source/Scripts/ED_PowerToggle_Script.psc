Scriptname ED_PowerToggle_Script extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	if ED_Mechanics_Quest_NecroticFlesh.IsStopped()
		ED_Mechanics_Quest_NecroticFlesh.Start()
	else
		ED_Mechanics_Quest_NecroticFlesh.Stop()
	endif


	;bool hasME = akTarget.HasMagicEffect(PowerActualEffect)
	;if hasME
	;	akTarget.RemoveSpell(PowerAbility)
	;	ED_NecroticFleshKeywordHolder.Clear()
	;else
	;	akTarget.RemoveSpell(PowerAbility)       ; its here in case spell gets dispelled by Drain Cleaner effect
	;	akTarget.AddSpell(PowerAbility, false)   ; in that case magic effect ends, but spell is still in players spell list for some reason
	;	ED_NecroticFleshKeywordHolder.ForceRefTo(akTarget)
	;	
	;endif
Endevent

;referencealias property ED_NecroticFleshKeywordHolder auto 
;SPELL Property PowerAbility Auto
;MagicEffect Property PowerActualEffect Auto
quest property ED_Mechanics_Quest_NecroticFlesh auto
