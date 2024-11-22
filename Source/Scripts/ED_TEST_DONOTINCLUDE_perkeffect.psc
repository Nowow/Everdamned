Scriptname ED_TEST_DONOTINCLUDE_perkeffect extends ActiveMagicEffect  

VisualEffect Property DLC1VampireBatsVFX auto
ImpactDataSet Property BloodSprayBleedImpactSetRed auto
EffectShader Property DLC1BatsEatenBloodSplats Auto
EffectShader Property DLC1VampBatsEatenByBatsSkinFXS Auto

Event OnEffectStart(Actor Target, Actor Caster)
	Utility.wait(0.9)
	DLC1VampireBatsVFX.Play(Target,5.0,Caster)
EndEvent

function DecalSpray(Actor BleedingActor, int xTimes)
	Float VectorX
	Float VectorY
	while xTimes > 0
		VectorX = (Utility.RandomFloat(-0.6, 0.6))
		VectorY = (Utility.RandomFloat(-0.6, 0.6))
		BleedingActor.ApplyHavokImpulse(VectorX, VectorY, 0.7, 50.0)
		BleedingActor.PlayImpactEffect(BloodSprayBleedImpactSetRed,"MagicEffectsNode",VectorX, VectorY, -0.9, 512, false, false)
		Utility.wait(0.28)
		BleedingActor.ApplyHavokImpulse(VectorY, VectorX, 0.7, 45.0)
		Utility.wait(0.38)
		xTimes = (xTimes - 1)
	endwhile
endfunction
