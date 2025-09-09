Scriptname ED_BloodCostDeducter_Script extends ReferenceAlias  

Event OnSpellCast(Form akSpell)

	if !akSpell || !(akSpell.haskeyword(ED_Mechanics_Keyword_DeductBloodCost))
		return
	endif
	
	playerRef.DamageActorValue("ED_BloodPool", ((akSpell as spell).GetPerk().GetNthEntryPriority(0) * 10) as float)
	
endevent

; called on racechange in main quest alias script
; and on perk aquisition
state UnearthlyWill
	event OnBeginState()
		debug.Trace("Everdamned DEBUG: Blood Cost Deducter switched to UnearthlyWill state")
	endevent
	event OnEndState()
		debug.Trace("Everdamned DEBUG: Blood Cost Deducter NO LONGER in UnearthlyWill state")
	endevent

	Event OnSpellCast(Form akSpell)

		if !akSpell || !(akSpell.haskeyword(ED_Mechanics_Keyword_DeductBloodCost))
			return
		endif
		
		playerRef.DamageActorValue("ED_BloodPool", ((akSpell as spell).GetPerk().GetNthEntryPriority(0) * 5) as float)
		
	endevent
endstate

keyword property ED_Mechanics_Keyword_DeductBloodCost auto
actor property playerRef auto
