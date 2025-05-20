Scriptname ED_CIF_RecoilLargeNF_Script extends activemagiceffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.SendAnimationEvent(akCaster,"recoilLargeStart")
endevent
