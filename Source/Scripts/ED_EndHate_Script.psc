Scriptname ED_EndHate_Script extends activemagiceffect  

playervampirequestscript property PlayerVampireQuest auto

function OnEffectStart(Actor akTarget, Actor akCaster)

	PlayerVampireQuest.StopHate(akTarget, true)
endFunction
