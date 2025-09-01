Scriptname ED_CIF_Recoil_Script extends activemagiceffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.SendAnimationEvent(akCaster,"recoilStart")
	debug.Trace("Everdamned DEBUG: AAA!")
endevent

actor property playerRef auto
