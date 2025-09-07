Scriptname ED_ChokeholdApplyAnkh_Script extends ActiveMagicEffect  

visualeffect property ED_Art_VFX_BloodBrand auto
visualeffect property ED_Art_VFX_WellingBlood auto
visualeffect property ED_Art_VFX_BloodScourge auto
activator property AshPile auto
spell property ED_VampireSpells_BloodAnkh_Proc_Spell auto

actor _target
actor _caster
function OnEffectStart(Actor akTarget, Actor akCaster)
	_target = akTarget
	_caster = akCaster
	
	;SCS_RestorationBlood_Cloak
	
	utility.wait(0.3)
	ED_Art_VFX_BloodBrand.Play(akTarget, -1.00000, none)
	utility.wait(1.0)
	ED_Art_VFX_WellingBlood.Play(akTarget, -1.00000, none)
	utility.wait(1.5)
	ED_Art_VFX_BloodScourge.Play(akTarget, -1.00000, none)
	utility.Wait(1.0)
	
	;need to retarget ashpile, because corpses blown up in the air spawn ashpile midair
	ED_PartingGiftLastTarget.ForceRefTo(akTarget)
	
	ED_VampireSpells_BloodAnkh_Proc_Spell.RemoteCast(akTarget, akCaster, none)
	
	ED_VampireSpellsVL_Chokehold_PartingGift_AttachAshpileAnchor_Spell.Cast(akTarget)
	
	;akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	;akTarget.SetAlpha(0.000000, true)
	;akTarget.AttachAshPile(AshPile as form)
	;akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)

	
endFunction

event OnRelease()
	
	float Dangle = _caster.getanglez()
	float Zangle = _caster.getanglex() + 90.0
	float Yshare = math.COS(Dangle)*math.SIN(Zangle)
	float Xshare = math.SIN(Dangle)*math.SIN(Zangle)
	float Zshare = math.cos(Zangle) + 0.3
	_target.applyhavokimpulse(Xshare, Yshare, Zshare, 1300.0)
	
	
endevent


referencealias property ED_PartingGiftLastTarget auto
spell property ED_VampireSpellsVL_Chokehold_PartingGift_AttachAshpileAnchor_Spell auto
