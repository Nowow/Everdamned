Scriptname ED_CIF_Recoil_Script extends activemagiceffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	;ed_Test_Art_Shader_MagicArmorEbonyFleshFXS.Play(akTarget)
	debug.SendAnimationEvent(akCaster,"recoilStart")
	debug.Trace("Everdamned DEBUG: AAA!")
endevent

effectshader property ed_Test_Art_Shader_MagicArmorEbonyFleshFXS auto
actor property playerRef auto