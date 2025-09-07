Scriptname ED_BloodAnkhReanimated_Script extends activemagiceffect  


float property XPgained auto
Float _popDelay = 3.0


function OnEffectStart(Actor akTarget, Actor akCaster)

	ED_Art_VFX_BloodAnkh.Play(akTarget as objectreference, -1.00000, none)
	
	utility.wait(_popDelay)
	
	ED_VampireSpells_BloodAnkh_Proc_Spell.RemoteCast(akTarget, akCaster, none)
	akTarget.Kill()
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	akTarget.SetAlpha(0.000000, true)
	akTarget.AttachAshPile(AshPile as form)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endFunction


visualeffect property ED_Art_VFX_BloodAnkh auto
activator property AshPile auto
spell property ED_VampireSpells_BloodAnkh_Proc_Spell auto
