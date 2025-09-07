Scriptname ED_CIFRecoilShader_Script extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	ShaderToAppyToTarget.Play(akTarget, 2.95)
endevent


effectshader property ShaderToAppyToTarget auto
