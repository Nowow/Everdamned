Scriptname ED_BloodAnkh_Detonate extends ActiveMagicEffect  

visualeffect property ED_Art_VFX_BloodAnkh auto
activator property AshPile auto
spell property ED_VampireSpells_BloodAnkh_Proc_Spell auto

Float _freezeDelay = 0.25
Float _popDelay = 2.50
Float _havokImpulseForce = 500.0

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function OnEffectStart(Actor akTarget, Actor akCaster)

	ED_Art_VFX_BloodAnkh.Play(akTarget as objectreference, -1.00000, none)
	akTarget.SetGhost(true)
	akTarget.ApplyHavokImpulse(0 as Float, 0 as Float, 400 as Float, _havokImpulseForce)
	utility.Wait(_freezeDelay)
	akTarget.EnableAI(false)
	utility.Wait(_popDelay)
	ED_VampireSpells_BloodAnkh_Proc_Spell.RemoteCast(akTarget as objectreference, akCaster, none)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	akTarget.SetAlpha(0.000000, true)
	akTarget.AttachAshPile(AshPile as form)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	akTarget.EnableAI(true)
	akTarget.SetGhost(false)
endFunction

