Scriptname ED_ColdFlamePyreSummon_Script extends activemagiceffect  

effectshader property ED_Art_Shader_ColdFlameBodyPyreDisintegrate3 auto
effectshader property ED_Art_Shader_ColdFlameAtronachFlameDeath auto
activator property DefaultAshPile1 auto

spell[] property SummonSpells auto

float property XPgained auto

event oneffectstart(actor akTarget, actor akCaster)
	
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	
	ED_Art_Shader_ColdFlameAtronachFlameDeath.Play(akTarget)
	
	utility.wait(utility.RandomFloat(3.0, 5.0))
	
	;ED_Art_Shader_ColdFlameAtronachFlameDeath.Stop(akTarget)
	
	ED_Art_Shader_ColdFlameBodyPyreDisintegrate3.Play(akTarget)
	
	;akTarget.AttachAshPile(DefaultAshPile1)
	;akTarget.PlaceAtMe(ED_Art_ImpactSet_ColdFlameFirebolt as form, 1, false, false)

	
	utility.wait(2.1)
	
	spell SummonToCast = SummonSpells[utility.randomint(0, SummonSpells.length - 1)]
	akCaster.DoCombatSpellApply(SummonToCast, akCaster)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endevent

;spell property ED_ColdFlame_ConjureAtronach_Spell auto
;spell property ED_VampireSpellsVL_ConjureGargoyleUncap_Spell auto
