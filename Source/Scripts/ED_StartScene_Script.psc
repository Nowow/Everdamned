Scriptname ED_StartScene_Script extends activemagiceffect  


scene property ED_Scene auto
keyword property MagicInfluence auto
spell property ED_Mechanics_VampiresCommandImmunity_Spell auto

actor TheTarget

function OnEffectStart(Actor akTarget, Actor akCaster)
	TheTarget = akTarget
	ED_Scene.Start()
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	utility.wait(2)
	if !(TheTarget.HasMagicEffectWithKeyword(MagicInfluence))
		debug.Trace("Everdamned DEBUG: Vampires Command scene ended, and no MagicInfluence detected, making target immune for x sec")
		ED_Mechanics_VampiresCommandImmunity_Spell.Cast(TheTarget, TheTarget)
	endif
endfunction
