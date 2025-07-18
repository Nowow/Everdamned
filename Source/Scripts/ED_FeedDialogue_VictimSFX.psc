Scriptname ED_FeedDialogue_VictimSFX extends activemagiceffect  


float BeatIntervalStart = 1.2
float BeatIntervalFloor_State0 = 1.01
float BeatIntervalFloor_State1 = 0.61
float BeatRampup_State0 = -0.1
float BeatRampup_State1 = -0.132

float ImodStrength_Start = 0.2
float ImodStrengthMax_State0 = 0.65
float ImodStrengthMax_State1 = 0.95
float ImodStrengthRampup_State0 = 0.1
float ImodStrengthRampup_State1 = 0.1
float ImodStrengthRampup_State2 = -0.4

float BeatVolume = 1.0
float BeatVolumeRampdown = -0.25

float BeatInterval_Current
float BeatIntervalFloor_Current
float BeatRampup_Current

float ImodStrength_Current
float ImodStrengthMax_Current
float ImodStrengthRampup_Current


; 0 - before starting the feed
; 1 - social feed started
; 2 - social feed ended/dialogue exited/used mesmerize
int __state


Event OnEffectStart(Actor akTarget, Actor akCaster)
	Target = akTarget
	RegisterForModEvent("feedDialogue_SocialFeedStarted","OnSocialFeedStart")
	RegisterForModEvent("feedDialogue_SocialFeedFinished","OnSocialFeedEnd")
	
	BeatInterval_Current = BeatIntervalStart
	BeatIntervalFloor_Current = BeatIntervalFloor_State0
	BeatRampup_Current = BeatRampup_State0

	ImodStrength_Current = ImodStrength_Start
	ImodStrengthMax_Current = ImodStrengthMax_State0
	ImodStrengthRampup_Current = ImodStrengthRampup_State0
	
	ED_Mechanics_FeedDialogue_HeartbeatLongWindup_SoundM.PlayAndWait(playerRef)
	RegisterForSingleUpdate(0.01)
EndEvent

int __playbackInstance
Event OnUpdate()

	__playbackInstance = ED_Mechanics_FeedDialogue_HeartbeatLongBeat_SoundM.Play(playerRef)
	Sound.SetInstanceVolume(__playbackInstance, BeatVolume)
	ED_Mechanics_FeedDialogue_PulsingVeins_Shader.Play(Target, BeatInterval_Current)
	ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD.Apply(ImodStrength_Current)
	
	
	if BeatInterval_Current > BeatIntervalFloor_Current
		BeatInterval_Current += BeatRampup_Current
	endif
	
	if ImodStrength_Current < ImodStrengthMax_Current || __state == 2
		ImodStrength_Current += ImodStrengthRampup_Current
	endif
	
	if __state == 2
		BeatVolume += BeatVolumeRampdown
	endif
	
	if BeatVolume > 0.01
		RegisterForSingleUpdate(BeatInterval_Current)
	else
		Dispel()
		debug.Trace("Everdamned DEBUG: Feed Dialogue VICTIM SFX effect finished")
	endif
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue VICTIM SFX state: " + __state + ", current beat interval: " + BeatInterval_Current + ", current str val: " + ImodStrength_Current)
EndEvent

Event OnSocialFeedStart(string eventName, string strArg, float numArg, Form sender)
	
	__state = 1
	
	BeatIntervalFloor_Current = BeatIntervalFloor_State1
	BeatRampup_Current = BeatRampup_State1
	ImodStrengthMax_Current = ImodStrengthMax_State1
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue VICTIM SFX got OnSocialFeedStart call")
EndEvent

Event OnSocialFeedEnd(string eventName, string strArg, float numArg, Form sender)
	
	__state = 2
	
	; winding imad strength down
	ImodStrengthRampup_Current = ImodStrengthRampup_State2
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue VICTIM SFX got OnSocialFeedEnd call")
endevent


actor Target

actor property playerRef auto

Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongWindup_SoundM  Auto  
Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongBeat_SoundM  Auto  
;Sound Property ED_Mechanics_FeedDialogue_HeartbeatLongWinddown_SoundM  Auto  
ImageSpaceModifier Property ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD  Auto  
EffectShader Property ED_Mechanics_FeedDialogue_PulsingVeins_Shader  Auto  

