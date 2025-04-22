Scriptname ED_Confuse_Script extends activemagiceffect  


event OnEffectStart(Actor Target, Actor Caster)

	if Target.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_VampiresCommandImmune)
		debug.Trace("Everdamned DEBUG: Vampire's Command through Will will not be applied due to immunity")
		ED_Mechanics_Message_VampiresCommandImmune.Show()
		return
	endif
	
	int __commandChoice
	__commandChoice = ED_Mechanics_Message_VampriesWill_ConfusePrompt.Show()
		
	if __commandChoice == 0
		debug.Trace("Everdamned DEBUG: Vampires Will casts ED_Mechanics_Apparation_Spell on target " + Target)
		ED_Mechanics_Apparation_Spell.Cast(Target, Target)
	endif
endevent

keyword property ED_Mechanics_Keyword_VampiresCommandImmune auto
message property ED_Mechanics_Message_VampiresCommandImmune auto
message property ED_Mechanics_Message_VampriesWill_ConfusePrompt auto
spell property ED_Mechanics_Apparation_Spell auto
