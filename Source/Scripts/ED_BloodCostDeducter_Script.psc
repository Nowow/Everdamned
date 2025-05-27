Scriptname ED_BloodCostDeducter_Script extends ReferenceAlias  

Event OnSpellCast(Form akSpell)

	;debug.Trace("Everdamned DEBUG: Blood Cost deducter caught spell cast")

	if !akSpell || !(akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy))
		return
	endif
	
	;debug.Trace("Everdamned DEBUG: Le spell is hemomancy!" + akSpell)
	
	; each hemomancy spell has casting perk, which is used to store a dummy EP,
	; which stores spell's blood point cost
	;float __cost = 
	;debug.Trace("Everdamned DEBUG: Le cost is: " + __cost)	
	;debug.Trace("Everdamned DEBUG: AV before: " + playerRef.GetActorValue("ED_BloodPool"))	
	playerRef.DamageActorValue("ED_BloodPool", ((akSpell as spell).GetPerk().GetNthEntryPriority(0) * 10) as float)
	;debug.Trace("Everdamned DEBUG: AV after: " + playerRef.GetActorValue("ED_BloodPool"))	
	
endevent

keyword property ED_Mechanics_Keyword_Hemomancy auto
actor property playerRef auto
