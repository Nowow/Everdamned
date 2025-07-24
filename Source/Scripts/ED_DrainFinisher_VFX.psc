Scriptname ED_DrainFinisher_VFX extends ActiveMagicEffect  

float property TimeToPop auto ;= 6
float property VfxTaper auto ;= 3
float property XPgained auto

float  _timeElapsed = 0.0

actor _player 
actor _target

float _vfxDuration
float _vfxDurationMax 
bool _success = false

Event OnEffectStart(Actor Target, Actor Caster)

	_vfxDurationMax = TimeToPop + VfxTaper
	
	_player = Caster
	_target = Target

	_target.StartDeferredKill()
	registerforsingleupdate(2)

EndEvent

Event OnUpdate()	
	_vfxDuration = _vfxDurationMax - _timeElapsed
	
	;stacking vfx
	DLC1BatsAbsorbTargetVFX01.Play(_target, _vfxDuration, _player)
	DLC1BatsEatenBloodSplats.Play(_target, _vfxDuration)
	
	debug.trace("Everdamned DEBUG: DRAIN STATE: " + _timeElapsed)
	if _timeElapsed == 4.0
		DLC1VampireChangeFXS.Play(_target, _vfxDuration)
	elseif _timeElapsed == TimeToPop
		
		_success = true
		debug.trace("Everdamned DEBUG: Exsanguinate KABOOoooOOOoooOOM!!!!!!")
		
		ED_Art_SoundM_SuperFleshyBurst.play(_target)
		_target.kill(_player)
		_target.placeatme(ED_Art_Explosion_Exsanguinate)
		_target.placeatme(ED_Art_Explosion_BloodStorm)
		
		_target.EndDeferredKill()
		_target.SetCriticalStage(_target.CritStage_DisintegrateStart)
		_target.SetAlpha(0.000000, true)
		_target.AttachAshPile(ED_Art_Ashpile_RedGoo as form)
		_target.SetCriticalStage(_target.CritStage_DisintegrateEnd)
		
		
		PlayerVampireQuest.EatThisActor(_target)
		CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
		return
	endif
	_timeElapsed = _timeElapsed + 1
	RegisterForSingleUpdate(1)
endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	debug.Trace("Everdamned DEBUG: Exsanguinate effect finished")
	
	if !_success
		debug.Trace("Everdamned DEBUG: But no exsanguination took place")
		DLC1BatsAbsorbTargetVFX01.Stop(_target)
		DLC1BatsEatenBloodSplats.Stop(_target)
	endif
	
	;should end it anyway
	_target.EndDeferredKill()
	
EndEvent


activator property ED_Art_Ashpile_RedGoo auto
VisualEffect Property DLC1BatsAbsorbTargetVFX01 auto
EffectShader Property DLC1BatsEatenBloodSplats Auto
EffectShader Property DLC1VampBatsEatenByBatsSkinFXS Auto
EffectShader Property DLC1VampireChangeFXS Auto

sound property ED_Art_SoundM_SuperFleshyBurst auto

explosion property ED_Art_Explosion_BloodStorm auto
Explosion property ED_Art_Explosion_Exsanguinate Auto

PlayerVampireQuestScript property PlayerVampireQuest auto
