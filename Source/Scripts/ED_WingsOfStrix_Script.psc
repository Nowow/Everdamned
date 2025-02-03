Scriptname ED_WingsOfStrix_Script extends activemagiceffect  


globalvariable property ED_Mechanics_Global_StrixBaseGravity auto
globalvariable property ED_Mechanics_Global_StrixNewGravity auto


function OnEffectStart(Actor akTarget, Actor akCaster)

	utility.SetIniFloat("fInAirFallingCharGravityMult:Havok", ED_Mechanics_Global_StrixNewGravity.GetValue())
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)

	utility.SetIniFloat("fInAirFallingCharGravityMult:Havok", ED_Mechanics_Global_StrixBaseGravity.GetValue())
endFunction
