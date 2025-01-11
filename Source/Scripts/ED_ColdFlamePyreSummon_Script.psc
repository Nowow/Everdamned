Scriptname ED_ColdFlamePyreSummon_Script extends activemagiceffect  

spell property ED_ColdFlame_ConjureAtronach_Spell auto
effectshader property ED_Art_Shader_ColdFlameBodyPyreDisintegrate3 auto
effectshader property ED_Art_Shader_ColdFlameAtronachFlameDeath auto
activator property DefaultAshPile1 auto

event oneffectstart(actor akTarget, actor akCaster)
	
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	
	ED_Art_Shader_ColdFlameAtronachFlameDeath.Play(akTarget)
	
	utility.wait(utility.RandomFloat(3.0, 5.0))
	
	;ED_Art_Shader_ColdFlameAtronachFlameDeath.Stop(akTarget)
	
	ED_Art_Shader_ColdFlameBodyPyreDisintegrate3.Play(akTarget)
	
	;akTarget.AttachAshPile(DefaultAshPile1)
	;akTarget.PlaceAtMe(ED_Art_ImpactSet_ColdFlameFirebolt as form, 1, false, false)

	
	utility.wait(2.1)
	
	akCaster.DoCombatSpellApply(ED_ColdFlame_ConjureAtronach_Spell, akCaster)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
endevent

