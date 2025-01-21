Scriptname ED_StartScene_Script extends activemagiceffect  


scene property ED_Scene auto

function OnEffectStart(Actor akTarget, Actor akCaster)
	ED_Scene.Start()
endFunction
