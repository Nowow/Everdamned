Scriptname ED_ImodInOut_Script extends activemagiceffect  


float property FadeIn_Seconds auto
float property FadeOut_Seconds auto


;Event OnEffectStart(Actor Target, Actor Caster)
;	IMOD.ApplyCrossFade(FadeIn_Seconds)
;endevent

;Event OnEffectFinish(Actor Target, Actor Caster)
;	imagespacemodifier.RemoveCrossFade(FadeOut_Seconds)
;endevent

imagespacemodifier property IMOD auto
