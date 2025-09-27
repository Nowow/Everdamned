Scriptname ED_GrantSkillXP_Script extends activemagiceffect  


float property XPgained auto
bool property InCombatOnly auto
actor property playerRef auto
string property SkillName auto

Event OnEffectStart(Actor akTarget, Actor akCaster) 
	
	if InCombatOnly && !(playerRef.IsInCombat())
		return
	endif
	Game.AdvanceSkill(SkillName, XPgained)

EndEvent
