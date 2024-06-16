Scriptname ED_VampirePowers_Celerity extends ActiveMagicEffect

Bool Property ActiveEP Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;ActiveEP = FALSE

	;If akTarget.HasSpell(ExtendedPerceptionSP)
	;	ActiveEP = TRUE
	;	akTarget.RemoveSpell(ExtendedPerceptionSP)
	;Endif
	
	utility.wait(0.1)
	akTarget.AddSpell(CeleritySP, false)

Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemoveSpell(CeleritySP)
	akTarget.DispelSpell(CeleritySP)
	
	;utility.wait(0.1)
	;If ActiveEP == TRUE
	;	akTarget.AddSpell(ExtendedPerceptionSP, false)
	;Endif
Endevent

SPELL Property ExtendedPerceptionSP  Auto  
SPELL Property CeleritySP  Auto  

