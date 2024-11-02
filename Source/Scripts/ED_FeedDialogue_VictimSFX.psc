Scriptname ED_FeedDialogue_VictimSFX extends activemagiceffect  


actor _player
actor _target
float _beatDur = 1.2
float _currStr = 0.2

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_player = Game.GetPlayer()
	_target = akTarget
	ED_Mechanics_FeedDialogue_HeartbeatLongWindup_SoundM.PlayAndWait(_player)
	RegisterForSingleUpdate(0.1)
EndEvent

Event OnUpdate()
	ED_Mechanics_FeedDialogue_HeartbeatLongBeat_SoundM.Play(_player)
	ED_Mechanics_FeedDialogue_PulsingVeins_Shader.Play(_target, _beatDur)
	ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD.Apply(_currStr)
	RegisterForSingleUpdate(_beatDur)
	if _currStr < 0.95
		_currStr = _currStr + 0.1
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
EndEvent


Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongWindup_SoundM  Auto  

Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongBeat_SoundM  Auto  

ImageSpaceModifier Property ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD  Auto  

EffectShader Property ED_Mechanics_FeedDialogue_PulsingVeins_Shader  Auto  
