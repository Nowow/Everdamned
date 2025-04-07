Scriptname ED_VampireDrain_CloakActuator extends activemagiceffect  


Actor Caster
bool __finished

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Caster = akCaster
	Caster.AddSpell(DrainCloakSpell, false)
	RegisterForSingleUpdate(1)
	
Endevent

; when rapidly switching drain targets cloak might get dispelled by old effect
; before new effect starts, so applying twice
Event OnUpdate()
	
	if __finished
		return
	endif
	Caster.AddSpell(DrainCloakSpell, false)
	
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	
	__finished = true
	Caster.RemoveSpell(DrainCloakSpell)
	
Endevent

SPELL Property DrainCloakSpell Auto
