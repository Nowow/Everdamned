Scriptname ED_ColdFlamePyreSummon_Script extends activemagiceffect  


spell[] property SummonSpells auto
float property XPgained auto

event oneffectstart(actor akTarget, actor akCaster)
	
	
	akTarget.placeatme(ED_Art_Hazard_ColdFlamePyre)
	utility.wait(1.5)
	ED_Art_Shader_ColdFlameAtronachFlameDeath.Play(akTarget)
	
	utility.wait(utility.RandomFloat(1.5, 3.5))
	
	;ED_Art_Shader_ColdFlameAtronachFlameDeath.Stop(akTarget)
	
	ED_Art_Shader_ColdFlameBodyPyreDisintegrate3.Play(akTarget)
	
	;akTarget.AttachAshPile(DefaultAshPile1)
	;akTarget.PlaceAtMe(ED_Art_ImpactSet_ColdFlameFirebolt as form, 1, false, false)

	
	utility.wait(2.1)
	
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	spell SummonToCast = SummonSpells[utility.randomint(0, SummonSpells.length - 1)]
	akCaster.DoCombatSpellApply(SummonToCast, akCaster)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endevent

effectshader property ED_Art_Shader_ColdFlameBodyPyreDisintegrate3 auto
effectshader property ED_Art_Shader_ColdFlameAtronachFlameDeath auto
activator property DefaultAshPile1 auto
hazard property ED_Art_Hazard_ColdFlamePyre auto
