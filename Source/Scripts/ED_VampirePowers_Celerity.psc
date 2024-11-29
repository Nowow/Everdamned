Scriptname ED_VampirePowers_Celerity extends ActiveMagicEffect

Bool Property ActiveEP Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	ActiveEP = FALSE

	If akTarget.HasMagicEffect(ExtendedPerceptionME)
		ActiveEP = TRUE
		akTarget.RemoveSpell(ExtendedPerceptionSP)
	Endif
	
	utility.wait(0.1)
	CeleritySP.cast(akTarget,akTarget)

Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.DispelSpell(CeleritySP)
	;akTarget.RemoveSpell(CeleritySP)
	
	utility.wait(0.1)
	If ActiveEP == TRUE
		akTarget.AddSpell(ExtendedPerceptionSP, false)
	Endif
Endevent

SPELL Property ExtendedPerceptionSP  Auto  
MagicEffect Property ExtendedPerceptionME  Auto  
SPELL Property CeleritySP  Auto  

