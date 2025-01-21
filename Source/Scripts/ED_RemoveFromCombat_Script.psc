Scriptname ED_RemoveFromCombat_Script extends activemagiceffect  

function OnEffectStart(Actor akTarget, Actor akCaster)

	if akTarget.GetCombatTarget() == akCaster
		akTarget.StopCombat()
	endIf
endFunction
