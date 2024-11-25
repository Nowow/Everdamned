Scriptname ED_PaintWallsRed_Script extends activemagiceffect  

objectreference _w
objectreference _a
objectreference _s
objectreference _d
objectreference _up
objectreference _source


actor _target

function OnEffectStart(Actor akTarget, Actor akCaster)
	_target = akTarget
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
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source,_target, _w)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source,_target, _a)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source,_target, _s)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source,_target, _d)
	ED_Misc_BloodDecalLarge_Spell.remotecast(_source,_target, _up)
endFunction


activator property FXEmptyActivator auto
spell property ED_Misc_BloodDecalLarge_Spell auto
