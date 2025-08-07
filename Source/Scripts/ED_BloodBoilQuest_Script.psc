Scriptname ED_BloodBoilQuest_Script extends Quest  


float property BoilingDuration = 6.0 auto


function Setup()
	
	_target = BoilTarget.GetReference() as actor
	EssentialHolder.ForceRefTo(_target)
	_caster = Game.GetPlayer()
	
	debug.Trace("Everdamned DEBUG: Blood Boil Quest started on target: " + _target + "!")
	
	; do a bloody paint job on walls and ceiling
	_w = _target.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_a = _target.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_s = _target.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_d = _target.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_up = _target.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_source = _target.PlaceAtMe(FXEmptyActivator, 1, false, false)
	
	_w.MoveTo(_target, 0, -100, 100) 
	_a.MoveTo(_target, 100, 0, 100) 
	_s.MoveTo(_target, 0, 100, 100) 
	_d.MoveTo(_target, -100, 0, 100) 
	_up.MoveTo(_target, 0, 0, 400) 
	_source.MoveTo(_target, 0, 0, 100)

	RegisterForSingleUpdate(0.1)
endfunction


function StartScene()

	ED_Art_SoundM_Wassail.Play(_target)
	_caster.DoCombatSpellApply(ED_VampireSpells_BloodBoil_Burst_Spell, _target)
	
	;_target.setghost(true)
	
	;debug.Trace("Everdamned DEBUG: BLood boil quest IS RUNNING: " + isrunning())
	;debug.Trace("Everdamned DEBUG: BLood boil quest IS STARTING: " + isstarting())
	;debug.Trace("Everdamned DEBUG: BLood boil quest IS STOPPING: " + isstopping())
	;debug.Trace("Everdamned DEBUG: BLood boil quest IS STOPPED: " + isstopped())
	;debug.Trace("Everdamned DEBUG: BLood boil quest IS RUNNING: " + isrunning())
	;debug.Trace("Everdamned DEBUG: BLood boil quest STAGE: " + GetCurrentStageID())
	;debug.Trace("Everdamned DEBUG: BLood boil Boil REF: " + BoilTarget.GetReference())
	;debug.Trace("Everdamned DEBUG: BLood boil ESSENTIAL REF: " + EssentialHolder.GetReference())
	
	ED_BoilingScene.ForceStart()
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endfunction


event OnUpdate()
	debug.Trace("Everdamned DEBUG: Blood Boil Quest UPDATE event, about to blow up!")
	
	; like this to deal with wierd stuff about quest NOT YET RUNNING 
	if GetCurrentStageID() == 0
		StartScene()
		SetCurrentStageID(10)
		RegisterForSingleUpdate(BoilingDuration)
		return
	endif
	
	if _target.isdead()
		debug.trace("Everdamned DEBUG: Blood Boil Quest determined that target is dead, not blowing up. Should not be, because essential")
		SetCurrentStageID(100)
		return
	endif
	
	_target.setghost(false)
	_caster.DoCombatSpellApply(ED_VampireSpells_BloodBoil_AoeDmgExplosion_Spell, _target)
	ED_Misc_BloodDecalLarge_Spell_Supermassive.remotecast(_target, _caster)
	
	EssentialHolder.Clear()
	_target.Kill(_caster)
	_target.PlaceAtMe(ED_Art_Hazard_Bones as form, 1, false, false)
	_target.SetCriticalStage(_target.CritStage_DisintegrateStart)
	_target.SetAlpha(0.000000, true)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _w)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _a)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _s)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _d)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _up)
	_target.AttachAshPile(AshPile as form)
	_target.SetCriticalStage(_target.CritStage_DisintegrateEnd)
	
	SetCurrentStageID(100)
	
endevent

function Shutdown()
	_w.Delete()
	_a.Delete()
	_s.Delete()
	_d.Delete()
	_up.Delete()
	_source.Delete()
	
	Stop()
endfunction

float property XPgained auto


ReferenceAlias Property BoilTarget Auto
ReferenceAlias Property EssentialHolder Auto

Spell property ED_VampireSpells_BloodBoil_AoeDmgExplosion_Spell auto
spell property ED_Misc_BloodDecalLarge_Spell auto
spell property ED_Misc_BloodDecalLarge_Spell_Supermassive auto
spell property ED_VampireSpells_BloodBoil_Burst_Spell auto

activator property AshPile auto
activator property FXEmptyActivator auto

scene property ED_BoilingScene auto
Hazard property ED_Art_Hazard_Bones auto
Message property ED_Mechanics_Message_BloodBoil_FailAliasFilled auto
sound property ED_Art_SoundM_Wassail auto

actor _target
actor _caster

objectreference _w
objectreference _a
objectreference _s
objectreference _d
objectreference _up
objectreference _source
