Scriptname ED_ChokeholdExsanguinate_Script extends activemagiceffect  


float property TimeToPop auto ;= 5
float property VfxTaper auto ;= 3
float property XPgained auto

float  _timeElapsed

actor _player 
actor _target
int currentSFX

float _vfxDuration
float _vfxDurationMax 
bool _success = false


Event OnEffectStart(Actor Target, Actor Caster)

	_vfxDurationMax = TimeToPop + VfxTaper
	
	_player = Caster
	_target = Target

	_target.StartDeferredKill()

	currentSFX = PulseSound_Array[(_timeElapsed as int)/2].Play(_player)
	sound.SetInstanceVolume(currentSFX, 100.0)
		
	ED_Art_SoundM_Exsanguinate_Intro.Play(_player)
	ED_Art_VFX_ExsanguinateBuildup.Play(_target, _vfxDuration)
	; length of first beat
	registerforsingleupdate(2.38)

EndEvent

Event OnUpdate()	
	_vfxDuration = _vfxDurationMax - _timeElapsed
	
	;stacking vfx
	DLC1BatsAbsorbTargetVFX01.Play(_target, _vfxDuration, _player)
	ED_Art_VFX_ExsanguinateBuildup.Play(_target, _vfxDuration)
	DLC1BatsEatenBloodSplats.Play(_target, _vfxDuration)
	ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD.Apply(1.0 - 1.0/(1.0+_timeElapsed))
	
	currentSFX = PulseSound_Array[(_timeElapsed as int)/2].Play(_player)
	sound.SetInstanceVolume(currentSFX, 100.0)
	
	debug.trace("Everdamned DEBUG: DRAIN STATE: " + _timeElapsed)
	if _timeElapsed == 4.0
		;DLC1VampireChangeFXS.Play(_target, _vfxDuration)
	elseif _timeElapsed == TimeToPop
		
		_success = true
		debug.trace("Everdamned DEBUG: Exsanguinate KABOOoooOOOoooOOM!!!!!!")
		
		_target.kill(_player)
		ED_Art_VFX_ExsanguinateExplosion.Play(_target,5.0)
		ED_Art_VFX_AbsorbBloodExsanguinate.Play(_player, 5.0, _target)
		_target.ApplyHavokImpulse(0.0, 0.0, 400.0, 100.0)
		_target.EndDeferredKill()

		utility.wait(0.3)
		
		debug.SendAnimationEvent(_player, "MLh_Equipped_Event")
		PlayerVampireQuest.EatThisActor(_target)
		CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)

		
		return
	endif
	_timeElapsed = _timeElapsed + 2.0
	
	; 2.38 - 0.103x
	RegisterForSingleUpdate(2.38 - 0.103*_timeElapsed)

endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	debug.Trace("Everdamned DEBUG: Exsanguinate effect finished, status: " + _success)
	
	;sound.StopInstance(a)
	
	;if ED_ExsanguinateTarget.GetReference() == _target
	;	ED_ExsanguinateTarget.Clear()
	;	debug.trace("Everdamned DEBUG: Exsanguinate is vacated upon effect finish")	
	;else
	;	debug.trace("Everdamned DEBUG: Exsanguinate effect finished but target not in ref")	
	;endif
	
	if _success
		
		DLC1VampireBatsVFX.Play(_target,1.0,Caster)
		DLC1VampBatsEatenByBatsSkinFXS.Play(_target,5.0)
		Utility.wait(0.4)
		DecalSpray(_target,2)
		
	else
		debug.Trace("Everdamned DEBUG: But no exsanguination took place")
		DLC1BatsAbsorbTargetVFX01.Stop(_target)
		DLC1BatsEatenBloodSplats.Stop(_target)
		
		Sound.StopInstance(currentSFX)
		ED_Art_SoundM_ExsanguinatePulse_Trail.Play(_player)
	endif
	
	_target.EndDeferredKill()
	
	
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


VisualEffect Property DLC1BatsAbsorbTargetVFX01 auto
VisualEffect Property ED_Art_VFX_AbsorbBloodExsanguinate auto
visualeffect property DLC1VampireBatsVFX auto
visualeffect property ED_Art_VFX_ExsanguinateExplosion auto
visualeffect property ED_Art_VFX_ExsanguinateBuildup auto

EffectShader Property DLC1BatsEatenBloodSplats Auto
EffectShader Property DLC1VampBatsEatenByBatsSkinFXS Auto
EffectShader Property DLC1VampireChangeFXS Auto

sound property ED_Art_SoundM_Exsanguinate_Intro auto
sound property ED_Art_SoundM_ExsanguinatePulse_Trail auto
sound[] property PulseSound_Array auto

impactdataset property BloodSprayBleedImpactSetRed auto

imagespacemodifier property ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD auto

PlayerVampireQuestScript property PlayerVampireQuest auto
