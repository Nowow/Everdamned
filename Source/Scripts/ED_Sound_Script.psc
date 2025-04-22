Scriptname ED_Sound_Script extends activemagiceffect  


function OnEffectStart(Actor akTarget, Actor akCaster)
	ED_Sound.Play(akTarget)
endFunction


sound property ED_Sound auto
