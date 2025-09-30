Scriptname ED_ColdFlamePyreSummon_Script extends activemagiceffect  


float property XPgained auto
float property ValueSummonHealthThreshold = 100.0 auto

event oneffectstart(actor akTarget, actor akCaster)
	
	bool __betterQuality = (akTarget.GetBaseActorValue("Health") > ValueSummonHealthThreshold) || \
							akTarget.HasKeyword(ActorTypeNPC)
	
	;ED_Art_Shader_ColdFlameAtronachFlameDeath.Play(akTarget)
	utility.wait(1.5)
	akTarget.placeatme(ED_Art_Hazard_ColdFlamePyre)
	
	utility.wait(utility.RandomFloat(1.5, 3.5))
	
	;ED_Art_Shader_ColdFlameAtronachFlameDeath.Stop(akTarget)
	
	ED_Art_Shader_ColdFlameBodyPyreDisintegrate3.Play(akTarget)
	akTarget.placeatme(ED_Art_Activator_ColdFlameBanishFX)
	
	utility.wait(2.1)
	
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	
	spell SummonToCast
	if __betterQuality
		SummonToCast = SummonSpells[utility.randomint(0, SummonSpells.length - 1)]
	else
		SummonToCast = ED_VampireSpellsVL_FoglingUncap_Spell
		XPgained = XPgained / 2.0
	endif
	
	akCaster.DoCombatSpellApply(SummonToCast, akCaster)
	akTarget.AttachAshPile()
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endevent

effectshader property ED_Art_Shader_ColdFlameBodyPyreDisintegrate3 auto
effectshader property ED_Art_Shader_ColdFlameAtronachFlameDeath auto
activator property DefaultAshPile1 auto
hazard property ED_Art_Hazard_ColdFlamePyre auto
activator property ED_Art_Activator_ColdFlameBanishFX auto
keyword property ActorTypeNPC auto

spell[] property SummonSpells auto
spell property ED_VampireSpellsVL_FoglingUncap_Spell auto
