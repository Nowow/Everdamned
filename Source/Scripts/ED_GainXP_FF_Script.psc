Scriptname ED_GainXP_FF_Script extends activemagiceffect  

import CustomSkills

float property XPgained auto

Event OnEffectStart(Actor akTarget, Actor akCaster) 

	AdvanceSkill("EverdamnedMain", XPgained)

EndEvent
