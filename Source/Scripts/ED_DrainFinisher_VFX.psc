Scriptname ED_DrainFinisher_VFX extends ActiveMagicEffect  

float property TimeToPop auto ;= 6
float property VfxTaper auto ;= 3

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
	if _timeElapsed == TimeToPop
		
		_success = true
		debug.trace("Everdamned DEBUG: Exsanguinate KABOOoooOOOoooOOM!!!!!!")
		; TODO: proper VFX
		_target.kill(_player)
		_target.placeatme(ED_Art_Explosion_Exsanguinate)
		PlayerVampireQuest.EatThisActor(_target)
		_target.EndDeferredKill()
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
		
	; should not be reachable, but still...
	elseif _target.isDead()
		debug.Trace("Everdamned ERROR: Exsanguination happened, but target still not dead for some reason")
		DLC1VampBatsEatenByBatsSkinFXS.Play(Target, 5.0)
	endif
	
	;should end it anyway
	_target.EndDeferredKill()
	
EndEvent

float property XPgained auto
VisualEffect Property DLC1BatsAbsorbTargetVFX01 auto
ImpactDataSet Property BloodSprayBleedImpactSetRed auto
EffectShader Property DLC1BatsEatenBloodSplats Auto
EffectShader Property DLC1VampBatsEatenByBatsSkinFXS Auto
Explosion property ED_Art_Explosion_Exsanguinate Auto

PlayerVampireQuestScript property PlayerVampireQuest auto
