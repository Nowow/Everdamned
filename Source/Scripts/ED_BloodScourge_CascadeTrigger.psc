Scriptname ED_BloodScourge_CascadeTrigger extends activemagiceffect  


float property XPgained auto
spell property Nova auto

Actor TheCaster
Actor TheTarget


function OnDying(Actor akKiller)

	Nova.RemoteCast(TheTarget as objectreference, TheCaster, none)
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	self.Dispel()
endFunction

function OnEffectStart(Actor akTarget, Actor akCaster)

	TheCaster = akCaster
	TheTarget = akTarget
	
endFunction
