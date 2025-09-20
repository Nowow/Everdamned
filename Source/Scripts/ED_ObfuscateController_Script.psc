Scriptname ED_ObfuscateController_Script extends activemagiceffect  

actor __target
bool __sneaking

float property AgeToAllowWalking auto

Event OnEffectStart(Actor Target, Actor Caster)
	__target = Target
	; at certain age dont have to crouch 
	if Target.IsSneaking() || ED_Mechanics_VampireAge.value >= AgeToAllowWalking
		ED_VampirePowers_Pw_Obfuscate_Insiv_Spell.cast(Target, Target)
		__sneaking = true
	endif
	
	; at certain age dont have to crouch 
	if ED_Mechanics_VampireAge.value < AgeToAllowWalking 
		RegisterForAnimationEvent(__target, "tailSneakIdle")
		RegisterForAnimationEvent(__target, "tailSneakLocomotion")
		RegisterForAnimationEvent(__target, "tailMTIdle")
		RegisterForAnimationEvent(__target, "tailMTLocomotion")
		RegisterForAnimationEvent(__target, "tailCombatIdle")
		RegisterForAnimationEvent(__target, "tailCombatLocomotion")
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
EndEvent

event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if !__sneaking
		if asEventName == "tailSneakIdle" || asEventName == "tailSneakLocomotion"
			__sneaking = true
			ED_VampirePowers_Pw_Obfuscate_Insiv_Spell.cast(__target, __target)
		endif
	else
		if !(asEventName == "tailSneakIdle" || asEventName == "tailSneakLocomotion")	
			__sneaking = false
			__target.dispelspell(ED_VampirePowers_Pw_Obfuscate_Insiv_Spell)
		endif
	endif
	
endevent

event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if abHitBlocked
		return
	endif
	
	spell spellHit = akSource as spell
	if spellHit && !(spellHit.IsHostile())
		return
	endif
	
	__target.dispelspell(ED_VampirePowers_Pw_Obfuscate_Insiv_Spell)
	self.dispel()
endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	__target.dispelspell(ED_VampirePowers_Pw_Obfuscate_Insiv_Spell)
endevent

float property XPgained auto
spell property ED_VampirePowers_Pw_Obfuscate_Insiv_Spell auto
globalvariable property ED_Mechanics_VampireAge auto
