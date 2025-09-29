Scriptname ED_BloodTentacleHitProc_Script extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	objectreference pushPoint = ED_TentacleAnchor.GetReference()
	pushPoint.PushActorAway(akTarget, 5.0)
endevent

ReferenceAlias property ED_TentacleAnchor auto

