Scriptname ED_BloodBoil_Script extends activemagiceffect  

bool _inserted
actor _target

objectreference _w
objectreference _a
objectreference _s
objectreference _d
objectreference _up
objectreference _source


function OnEffectStart(Actor akTarget, Actor akCaster)
	_target = akTarget
	_inserted = ED_BloodBoilTarget.ForceRefIfEmpty(akTarget)
	if !_inserted
		ED_Mechanics_Message_BloodBoil_FailAliasFilled.ShowAsHelpMessage("ed_bloodboil_limit", 3.0, 5.0, 1)
		Message.ResetHelpMessage("ed_bloodboil_limit")
		self.dispel()
		return
	endif
	akTarget.setghost(true)
	
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
	
	
	
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	if !_inserted || _target.isdead()
		debug.trace("Everdamned DEBUG: Blood Boil spell on " + _target + "ended doing nothing because alias was already filled or target dead")
		return
	endif
	_target.setghost(false)
	ED_VampireSpells_BloodBoil_AoeDmgExplosion_Spell.Cast(akCaster, _target)
	ED_Misc_BloodDecalLarge_Spell_Supermassive.remotecast(_target, akCaster)
	_target.Kill(akCaster)
	_target.PlaceAtMe(ED_Art_Hazard_Bones as form, 1, false, false)
	_target.SetAlpha(0.000000, true)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, akCaster, _w)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, akCaster, _a)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, akCaster, _s)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, akCaster, _d)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source, akCaster, _up)
	_target.AttachAshPile(AshPile as form)
	_target.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	ED_BloodBoilTarget.Clear()
	_w.Delete()
	_a.Delete()
	_s.Delete()
	_d.Delete()
	_up.Delete()
	_source.Delete()
endFunction


Spell property ED_VampireSpells_BloodBoil_AoeDmgExplosion_Spell auto
Hazard property ED_Art_Hazard_Bones auto
idle property IdleSnowElfPrinceAscension auto
activator property AshPile auto
actor property playerRef auto
ReferenceAlias Property ED_BloodBoilTarget  Auto
Message property ED_Mechanics_Message_BloodBoil_FailAliasFilled auto
activator property FXEmptyActivator auto 

spell property ED_Misc_BloodDecalLarge_Spell auto
spell property ED_Misc_BloodDecalLarge_Spell_Supermassive auto
topicinfo property ScreamTopic auto

