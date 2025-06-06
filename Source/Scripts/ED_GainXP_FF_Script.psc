Scriptname ED_GainXP_FF_Script extends activemagiceffect  


float property XPgained auto
bool property InCombatOnly auto
actor property playerRef auto

Event OnEffectStart(Actor akTarget, Actor akCaster) 
	
	if InCombatOnly && !(playerRef.IsInCombat())
		return
	endif
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)

EndEvent
