Scriptname ED_DrainFinisher_VFX extends ActiveMagicEffect  


string _gmtm

int _state = 0
int _duration = 6
int _vfxTaper = 3



actor _player 
actor _target
bool _noBleedoutRecovery 
float _effectDur
bool _success = false

Event OnEffectStart(Actor Target, Actor Caster)

	if Target.IsEssential() == true
		debug.Notification("Your target is protected by threads of fate...")
		self.Dispel()
	endif
	_player = Caster
	_target = Target
	; try deferred kill
	;ED_ExsanguinateTarget.ForceRefTo(Target)
	_noBleedoutRecovery = _target.GetNoBleedoutRecovery()
	;_target.SetNoBleedoutRecovery(true)
	_target.StartDeferredKill()
	
	registerforsingleupdate(2)
	_gmtm = utility.GameTimeToString(Utility.GetCurrentGameTime())
	debug.Trace("EVERDAMNED TEST " + _gmtm + ": DRAIN STARTED")
	
;	DLC1VampireBatsVFX.Play(Target,5.0,Caster)
EndEvent

Event OnUpdate()	
	_effectDur = (_duration + _vfxTaper - _state) as float
	DLC1BatsAbsorbTargetVFX01.Play(_target, _effectDur,_player)
	DLC1BatsEatenBloodSplats.Play(_target, _effectDur)
	;_target.PlayIdle(BleedOutStart)
	
	debug.trace("EVERDAMNED TEST: DRAIN STATE: " + _state)
	if _state == _duration
		
		_success = true
		debug.trace("EVERDAMNED TEST: BOOOOOOOOOOOM!!!!!!")
		;_target.SetNoBleedoutRecovery(_noBleedoutRecovery)
		_target.kill(_player)
		ExsanguinateExplosion.RemoteCast(_target, _player, none)
		_target.EndDeferredKill()
		PlayerVampireQuest.EatThisActor(_target)
		return
	endif
	_state = _state + 1
	RegisterForSingleUpdate(1)
endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	debug.Trace("EVERDAMNED TEST " + _gmtm + ": DRAIN FINISHED")
	if !_success
		debug.Trace("No success tho")
		DLC1BatsAbsorbTargetVFX01.Stop(_target)
		
	; should not be reachable, but still...
	elseif _target.isDead()
		DLC1VampBatsEatenByBatsSkinFXS.Play(Target,5.0)
	endif
	
	;_target.SetNoBleedoutRecovery(_noBleedoutRecovery)
	_target.EndDeferredKill()
	
EndEvent

idle property BleedOutStart auto
VisualEffect Property DLC1BatsAbsorbTargetVFX01 auto
ImpactDataSet Property BloodSprayBleedImpactSetRed auto
EffectShader Property DLC1BatsEatenBloodSplats Auto
EffectShader Property DLC1VampBatsEatenByBatsSkinFXS Auto
Spell property ExsanguinateExplosion Auto

PlayerVampireQuestScript property PlayerVampireQuest auto

ReferenceAlias Property ED_ExsanguinateTarget  Auto  
