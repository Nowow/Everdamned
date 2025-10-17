Scriptname ED_DrainFinisher_VFX extends ActiveMagicEffect  

float property TimeToPop auto ;= 5
float property VfxTaper auto ;= 3
float property XPgained auto

float  _timeElapsed = 0.0

actor _player 
actor _target
int currentSFX

float _vfxDuration
float _vfxDurationMax 
bool _success = false

int a 
Event OnEffectStart(Actor Target, Actor Caster)

	_vfxDurationMax = TimeToPop + VfxTaper
	
	_player = Caster
	_target = Target

	_target.StartDeferredKill()
	
	; using Essential alias instead of deferred kill because 
	; deferred kill fs with paralysis... 
	;ED_ExsanguinateTarget.ForceRefTo(Target)
	
	currentSFX = PulseSound_Array[(_timeElapsed as int)/2].Play(_player)
	sound.SetInstanceVolume(currentSFX, 100.0)
	
	;a = QSTWaystoneMagicBarrierLPMDUPLICATE001.Play(_player)
	
	ED_Art_SoundM_Exsanguinate_Intro.Play(_player)
	
	; length of first beat
	registerforsingleupdate(2.38)

EndEvent

Event OnUpdate()	
	_vfxDuration = _vfxDurationMax - _timeElapsed
	
	;stacking vfx
	DLC1BatsEatenBloodSplats.Play(_target, _vfxDuration)
	ED_Art_VFX_Halo_Outward.Play(_target, 1.0)
	ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD.Apply(1.0 - 1.0/(1.0+_timeElapsed))
	
	currentSFX = PulseSound_Array[(_timeElapsed as int)/2].Play(_player)
	sound.SetInstanceVolume(currentSFX, 100.0)
	
	debug.trace("Everdamned DEBUG: DRAIN STATE: " + _timeElapsed)
	if _timeElapsed == 4.0
		;DLC1VampireChangeFXS.Play(_target, _vfxDuration)
	elseif _timeElapsed == TimeToPop
		
		_success = true
		debug.trace("Everdamned DEBUG: Exsanguinate KABOOoooOOOoooOOM!!!!!!")
		
		;if ED_ExsanguinateTarget.GetReference() == _target
		;	debug.trace("Everdamned DEBUG: Exsanguinate alias is filled correctly, proceeding")
			
		;	ED_ExsanguinateTarget.Clear()
			_target.kill(_player)
			
			;ED_Art_SoundM_HellsBells.Play(_player)
			_target.placeatme(ED_Art_Explosion_Exsanguinate)
			_target.ApplyHavokImpulse(0.0, 0.0, 400.0, 100.0)
			
			_target.EndDeferredKill()
			
			
			;_target.SetCriticalStage(_target.CritStage_DisintegrateStart)
			;_target.SetAlpha(0.000000, true)
			;_target.AttachAshPile(ED_Art_Ashpile_RedGoo as form)
			;_target.SetCriticalStage(_target.CritStage_DisintegrateEnd)
			
			utility.wait(0.3)
			ED_Art_VFX_AbsorbBloodExsanguinate.Play(_player, 5.0, _target)
		
			DLC1VampireBatsVFX.Play(_target,1.0,_player)
			DLC1VampBatsEatenByBatsSkinFXS.Play(_target,5.0)
			Utility.wait(0.4)
			DecalSpray(_target,2)
			
			PlayerVampireQuest.EatThisActor(_target)
			CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
		;else
		;	debug.trace("Everdamned DEBUG: Exsanguinate alias was NOT filled with this target" + _target + ", doing nothing ")
		;endif
		
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
		
		
	else
		debug.Trace("Everdamned DEBUG: But no exsanguination took place")
		DLC1BatsEatenBloodSplats.Stop(_target)
		
		Sound.StopInstance(currentSFX)
		ED_Art_SoundM_ExsanguinatePulse_Trail.Play(_player)
	endif
	
	ED_Mechanics_Spell_GetUpWatcher.Cast(_player, _target)
	
	; VERY IMPORTANT WAIT
	; OR CORPSES WILL RISE
	
	utility.wait(0.3)
	
	;if _target.GetActorValue("Health") <= 0.0
	;	_target.kill(_player)
	;endif
	;_target.placeatme(ED_Art_Explosion_Exsanguinate)
	;_target.ApplyHavokImpulse(0.0, 0.0, 400.0, 100.0)
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


referencealias property ED_ExsanguinateTarget auto

activator property ED_Art_Ashpile_RedGoo auto

VisualEffect Property DLC1BatsAbsorbTargetVFX01 auto
VisualEffect Property ED_Art_VFX_AbsorbBloodExsanguinate auto
visualeffect property DLC1VampireBatsVFX auto
visualeffect property ED_Art_VFX_Flaywind auto
visualeffect property ED_Art_VFX_Halo_Outward auto

spell property ED_Mechanics_Spell_GetUpWatcher auto

EffectShader Property DLC1BatsEatenBloodSplats Auto
EffectShader Property DLC1VampBatsEatenByBatsSkinFXS Auto
EffectShader Property DLC1VampireChangeFXS Auto


sound property ED_Art_SoundM_Exsanguinate_Intro auto
sound property QSTAlduinDeathExplosionA auto
sound property ED_Art_SoundM_HellsBells auto
sound property ED_Art_SoundM_SuperFleshyBurst auto
sound property ED_Art_SoundM_ExsanguinateBuildup auto
sound property ED_Art_SoundM_ExsanguinatePulse_Trail auto
sound[] property PulseSound_Array auto

explosion property ED_Art_Explosion_BloodStorm auto
Explosion property ED_Art_Explosion_Exsanguinate Auto

impactdataset property BloodSprayBleedImpactSetRed auto

imagespacemodifier property ED_Mechanics_FeedDialogue_HeartbeatSFX_IMAD auto

PlayerVampireQuestScript property PlayerVampireQuest auto
