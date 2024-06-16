Scriptname ED_VampireDrain_CloakActuator extends activemagiceffect  

import Debug
import Utility

Actor property PlayerRef auto
Actor property Caster auto


Event OnEffectStart(Actor akTarget, Actor akCaster)

	Caster = akCaster
	Caster.AddSpell(DrainCloakSpell, false)
	RegisterForSingleUpdate(1)
	
Endevent

; when rapidly switching drain targets cloak might not reapply 
Event OnUpdate()

	Caster.AddSpell(DrainCloakSpell, false)

endEvent



Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Caster.RemoveSpell(DrainCloakSpell)
	Caster.DispelSpell(DrainCloakSpell)
	UnregisterForUpdate()
Endevent

SPELL Property DrainCloakSpell Auto
