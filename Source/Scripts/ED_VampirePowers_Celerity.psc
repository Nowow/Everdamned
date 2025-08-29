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
	
	;VOCShoutFXSlowTimeIn
	ED_Art_SoundM_CelerityIn.Play(akTarget)
	akTarget.placeatme(ED_Art_Explosion_TimeDilationShockwave)
	CeleritySP.cast(akTarget,akTarget)
		
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)

Endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	if !(akTarget.HasMagicEffect(ED_VampirePowers_Celerity_Effect_SlowTimeAb))
		debug.Trace("Everdamned DEBUG: Celerity controller ended when no celerity slow time effect present, doing nothing")
		return
	endif
	
	; outro moved to actual effect
	; because of feed km interaction
	
	;ED_Art_SoundM_CelerityOut.Play(akTarget)
	akTarget.DispelSpell(CeleritySP)
	;akTarget.placeatme(ED_Art_Explosion_TimeDilationShockwave)
	
	if ActiveNF == true
		akTarget.AddSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell)
	endif
	
	; reminder that second condition is a crutch for celerity hotkey
	If ActiveEP == true && !(__target.HasMagicEffect(ED_VampirePowers_Effect_ExtendedPerceptionTog))
		utility.wait(0.1)
		akTarget.AddSpell(ExtendedPerceptionSP, false)
	Endif
	
Endevent

float property XPgained auto
SPELL Property ExtendedPerceptionSP  Auto  
MagicEffect Property ExtendedPerceptionME  Auto  
MagicEffect Property ED_VampirePowers_Effect_ExtendedPerceptionTog  Auto
MagicEffect Property ED_VampirePowers_Celerity_Effect_SlowTimeAb  Auto

SPELL Property CeleritySP  Auto  
SPELL Property ED_VampirePowers_Pw_NecroticFlesh_Spell Auto  
explosion property ED_Art_Explosion_TimeDilationShockwave auto

sound property ED_Art_SoundM_CelerityIn auto
;sound property ED_Art_SoundM_CelerityOut auto
