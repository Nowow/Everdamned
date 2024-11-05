Scriptname ED_FeedDialogue_VictimSFX extends activemagiceffect  


actor _player
actor _target

float _beatDur = 1.2
float _beatRampup = -0.1
float _beatFloor = 1.01

float _currImodStr = 0.2
float _imodStrRampup = 0.1
float _imodStrCeiling = 0.65

bool _lastSceneStarted = false

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_player = Game.GetPlayer()
	_target = akTarget
	RegisterForModEvent("feedDialogue_last_scene_started","OnFeedDgLastSceneStart")
	ED_Mechanics_FeedDialogue_HeartbeatLongWindup_SoundM.PlayAndWait(_player)
	RegisterForSingleUpdate(0.01)
EndEvent

Event OnFeedDgLastSceneStart(string eventName, string strArg, float numArg, Form sender)
	debug.Trace("OnFeedDgLastSceneStart got called!")
	if _lastSceneStarted
		return
	endif
	_lastSceneStarted = true
	_beatFloor = 0.61
	_beatRampup = -0.132
	_imodStrCeiling = 0.95
EndEvent

Event OnUpdate()
	ED_Mechanics_FeedDialogue_HeartbeatLongBeat_SoundM.Play(_player)
	ED_Mechanics_FeedDialogue_PulsingVeins_Shader.Play(_target, _beatDur)
	ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD.Apply(_currImodStr)
	if _beatDur > _beatFloor
		_beatDur = _beatDur + _beatRampup
	endif
	RegisterForSingleUpdate(_beatDur)
	if _currImodStr < _imodStrCeiling
		_currImodStr = _currImodStr + _imodStrRampup
	endif
	debug.Trace("Current str val: " + _currImodStr + ", current beat dur: " + _beatDur)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ED_Mechanics_FeedDialogue_HeartbeatLongWinddown_SoundM.Play(_player)
	ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD.Apply(0.5)
EndEvent

Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongWindup_SoundM  Auto  

Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongBeat_SoundM  Auto  

ImageSpaceModifier Property ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD  Auto  

EffectShader Property ED_Mechanics_FeedDialogue_PulsingVeins_Shader  Auto  

Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongWinddown_SoundM  Auto  
