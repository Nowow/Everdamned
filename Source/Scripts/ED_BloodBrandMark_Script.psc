Scriptname ED_BloodBrandMark_Script extends activemagiceffect  

objectreference _target

function OnEffectStart(Actor akTarget, Actor akCaster)
	utility.wait(0.2)
	_target = akTarget
	ED_LastBloodBrandedActor.ForceRefTo(akTarget)
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	objectreference _current = ED_LastBloodBrandedActor.GetReference()
	if _current == _target
		ED_LastBloodBrandedActor.Clear()
	endif
endFunction

ReferenceAlias property ED_LastBloodBrandedActor auto
