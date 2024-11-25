Scriptname ED_BloodBoil_Script extends activemagiceffect  

bool _inserted
actor _target
actor _caster

objectreference _w
objectreference _a
objectreference _s
objectreference _d
objectreference _up
objectreference _source


function OnEffectStart(Actor akTarget, Actor akCaster)
	
	_inserted = ED_BloodBoilTarget.ForceRefIfEmpty(akTarget)
	if !_inserted
		debug.Trace("Everdamned ERROR: Blood Boil BURST effect started while alias filled, should not be this way")
		ED_Mechanics_Message_BloodBoil_FailAliasFilled.ShowAsHelpMessage("ed_bloodboil_limit", 3.0, 5.0, 1)
		Message.ResetHelpMessage("ed_bloodboil_limit")
		self.dispel()
		return
	endif
	
	_target = akTarget
	_caster = akCaster
	
	akTarget.setghost(true)
	BoilingScene.ForceStart()
	; do a bloody paint job on walls and ceiling
	_w = akTarget.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_a = akTarget.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_s = akTarget.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_d = akTarget.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_up = akTarget.PlaceAtMe(FXEmptyActivator, 1, false, false)
	_source = akTarget.PlaceAtMe(FXEmptyActivator, 1, false, false)
	
	_w.MoveTo(akTarget, 0, -100, 100) 
	_a.MoveTo(akTarget, 100, 0, 100) 
	_s.MoveTo(akTarget, 0, 100, 100) 
	_d.MoveTo(akTarget, -100, 0, 100) 
	_up.MoveTo(akTarget, 0, 0, 400) 
	_source.MoveTo(akTarget, 0, 0, 100)
	RegisterForSingleUpdate(6.0)
	
	
endFunction

event OnUpdate()
	debug.Trace("Everdamned DEBUG: Blood Boil UPDATE event!")
	
	if !_inserted || _target.isdead()
		debug.trace("Everdamned DEBUG: IDK why are we here, because target is either dead or didnt fill the alias and this OnUpdate event should not have fired")
		self.dispel()
		return
	endif
	
	if _target.isessential()
		debug.trace("Everdamned DEBUG: LOL why is target essential now... someone was really (un)fortunate!")
		self.dispel()
		return
	endif
	
	_target.setghost(false)
	ED_VampireSpells_BloodBoil_AoeDmgExplosion_Spell.Cast(_caster, _target)
	ED_Misc_BloodDecalLarge_Spell_Supermassive.remotecast(_target, _caster)
	_target.Kill(_caster)
	_target.PlaceAtMe(ED_Art_Hazard_Bones as form, 1, false, false)
	_target.SetAlpha(0.000000, true)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _w)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _a)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _s)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _d)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, _caster, _up)
	_target.AttachAshPile(AshPile as form)
	_target.SetCriticalStage(_target.CritStage_DisintegrateEnd)
	
endevent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	_target.setghost(false)
	_w.Delete()
	_a.Delete()
	_s.Delete()
	_d.Delete()
	_up.Delete()
	_source.Delete()
	
	if !_inserted
		return
	endif 
	
	bool _cleared = ED_BloodBoilTarget.TryToClear()
	debug.Trace("Everdamned DEBUG: BLOOD BOIL BURST EFFECT cleared alias: " + _cleared )

endFunction

ReferenceAlias Property ED_BloodBoilTarget  Auto
activator property AshPile auto

Spell property ED_VampireSpells_BloodBoil_AoeDmgExplosion_Spell auto
spell property ED_Misc_BloodDecalLarge_Spell auto
spell property ED_Misc_BloodDecalLarge_Spell_Supermassive auto
Hazard property ED_Art_Hazard_Bones auto
activator property FXEmptyActivator auto
scene property BoilingScene auto

Message property ED_Mechanics_Message_BloodBoil_FailAliasFilled auto
