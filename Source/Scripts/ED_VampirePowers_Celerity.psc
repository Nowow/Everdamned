Scriptname ED_VampirePowers_Celerity extends ActiveMagicEffect

Bool Property ActiveEP Auto

actor __target
Event OnEffectStart(Actor akTarget, Actor akCaster)
	ActiveEP = FALSE
	__target = akTarget
	If akTarget.HasMagicEffect(ExtendedPerceptionME)
		ActiveEP = TRUE
		akTarget.RemoveSpell(ExtendedPerceptionSP)
		utility.wait(0.1)
	Endif
	
	CeleritySP.cast(akTarget,akTarget)

Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.DispelSpell(CeleritySP)
	;akTarget.RemoveSpell(CeleritySP)
	
	If ActiveEP == TRUE && !(__target.HasMagicEffect(ED_VampirePowers_Effect_ExtendedPerceptionTog))
	utility.wait(0.1)
	
		akTarget.AddSpell(ExtendedPerceptionSP, false)
	Endif
Endevent

SPELL Property ExtendedPerceptionSP  Auto  
MagicEffect Property ExtendedPerceptionME  Auto  
MagicEffect Property ED_VampirePowers_Effect_ExtendedPerceptionTog  Auto  
SPELL Property CeleritySP  Auto  

