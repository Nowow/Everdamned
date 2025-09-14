Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  



event OnEffectStart(Actor akTarget, Actor akCaster)

	ED_SKSEnativebindings.SetTimeSlowdown(0.25, 0.6)
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)

	ED_SKSEnativebindings.SetTimeSlowdown(0.0, 0.0)
endevent

;Function ScaleNode(actor akTarget, String spellNode, Float scale)
;	NetImmerse.SetNodeScale(akTarget, spellNode, scale, false)
;	NetImmerse.SetNodeScale(akTarget, spellNode, scale, true)
;EndFunction


float property FadeInTime = 1.0 auto
float property FadeOutTime = 1.0 auto