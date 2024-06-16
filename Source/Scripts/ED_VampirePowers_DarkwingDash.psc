Scriptname ED_VampirePowers_DarkwingDash extends activemagiceffect  

;The purpose of this script is to
;1) delay actual effects, making it look like it takes time for character to dissipate
;2) suppress already present shaders on target, otherwise they are visible during invis and look ugley
import utility

function OnEffectStart(actor akTarget, actor akCaster)

	utility.wait(0.1)
	akTarget.DoCombatSpellApply(RealDarkwingDashEffects, akTarget)
	
endFunction


SPELL Property RealDarkwingDashEffects Auto 