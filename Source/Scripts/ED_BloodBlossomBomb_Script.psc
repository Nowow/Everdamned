Scriptname ED_BloodBlossomBomb_Script extends activemagiceffect  


actor __target
bool __wasHit

Event OnEffectStart(Actor Target, Actor Caster)
	__target = Target
endevent

event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
	
	if !__wasHit && abPowerAttack && __target.GetActorValue("ED_BloodBlossom") <= 0.0 
	
		__wasHit = true
		dispel()
		debug.Trace("Everdamned DEBUG: Blood Garden Bomb detected powerattack")
	endif
	
endevent

Event OnEffectFinish(Actor Target, Actor Caster)

	if __wasHit || __target.GetActorValuePercentage("Health") <= 0.25
		ED_VampireSpells_BloodBrand_Blossoms_Proc.Cast(Caster, Target)
		utility.wait(0.5)
		ED_VampireSpells_BloodBrand_Blossoms_Proc_Cleanser.Cast(Caster, Target)
	endif
	
endevent


spell property ED_VampireSpells_BloodBrand_Blossoms_Proc auto
spell property ED_VampireSpells_BloodBrand_Blossoms_Proc_Cleanser auto
