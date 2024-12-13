Scriptname ED_RoyalGuardian_Script extends activemagiceffect  


function OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest: Passive Ability effect started, calling start ED_Mechanics_Quest_RoyalGuardian")
	ED_Mechanics_Quest_RoyalGuardian.start()
endfunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest: Passive Ability effect ended, calling stop ED_Mechanics_Quest_RoyalGuardian")
	ED_Mechanics_Quest_RoyalGuardian.stop()
endfunction

Quest property ED_Mechanics_Quest_RoyalGuardian auto
