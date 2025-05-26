Scriptname ED_VampirePowers_Celerity extends ActiveMagicEffect

Bool Property ActiveEP Auto
Bool Property ActiveNF Auto

actor __target
Event OnEffectStart(Actor akTarget, Actor akCaster)
	ActiveEP = FALSE
	ActiveNF = FALSE
	__target = akTarget
	
	if akTarget.HasSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell)
		ActiveNF = true
		akTarget.RemoveSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell)
	endif
	
	If akTarget.HasMagicEffect(ExtendedPerceptionME)
		ActiveEP = TRUE
		akTarget.RemoveSpell(ExtendedPerceptionSP)
		utility.wait(0.1)
	Endif
	
	CeleritySP.cast(akTarget,akTarget)

Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.DispelSpell(CeleritySP)
	
	if ActiveNF == true
		akTarget.AddSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell)
	endif
	
	; reminder that second condition is a crutch for celerity hotkey
	If ActiveEP == true && !(__target.HasMagicEffect(ED_VampirePowers_Effect_ExtendedPerceptionTog))
		utility.wait(0.1)
		akTarget.AddSpell(ExtendedPerceptionSP, false)
	Endif
	
Endevent

SPELL Property ExtendedPerceptionSP  Auto  
MagicEffect Property ExtendedPerceptionME  Auto  
MagicEffect Property ED_VampirePowers_Effect_ExtendedPerceptionTog  Auto  
SPELL Property CeleritySP  Auto  
SPELL Property ED_VampirePowers_Pw_NecroticFlesh_Spell Auto  

