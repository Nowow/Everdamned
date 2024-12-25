Scriptname ED_RoyalGuardianAmbush_Script extends ActiveMagicEffect  

Event OnEffectStart(actor Target, actor Caster)
	Caster.DispelSpell(ED_Misc_Spell_DogAmbushKnockbackEnabled)
	Caster.PushActorAway(Target, PushForce)
EndEvent

int Property PushForce  Auto  
spell Property ED_Misc_Spell_DogAmbushKnockbackEnabled Auto
