Scriptname ED_BloodBoil_BurnScript extends activemagiceffect  

actor _target
actor _caster

function OnEffectStart(Actor akTarget, Actor akCaster)

	if (ED_BloodBoilTarget.GetReference()) as Actor != None
		ED_Mechanics_Message_BloodBoil_FailAliasFilled.ShowAsHelpMessage("ed_bloodboil_limit", 3.0, 5.0, 1)
		Message.ResetHelpMessage("ed_bloodboil_limit")
		self.dispel()
		return
	endif
	ED_Art_SoundM_MasterSpellHit.Play(akTarget)
	_target = akTarget
	_caster = akCaster
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
	; doing it in papyrus because dont trust spell side conditions, feels like they might give start+stops
	; also because dont trust papyrus functions to be equivalent to CK 
	if _target.GetActorValuePercentage("Health") < 0.51
		debug.Trace("Everdamned DEBUG:  Blood Boil BURN casts BURST right away!")
		_caster.DoCombatSpellApply(ED_VampireSpells_BloodBoil_Burst_Spell, _target)
		self.dispel()
		return
	endif
	RegisterForUpdate(1.0) ; unregisters are handled automatically
endfunction

event OnUpdate()
	float _percent = _target.GetActorValuePercentage("Health")
	debug.Trace("Everdamned DEBUG:  Blood Boil BURN updates, hp percent: " + _percent)
	if _target.GetActorValuePercentage("Health") < 0.51
		debug.Trace("Everdamned DEBUG: Blood Boil BURN casts BURST from update!")
		_caster.DoCombatSpellApply(ED_VampireSpells_BloodBoil_Burst_Spell, _target)
		self.dispel()
	endif
endevent

float property XPgained auto
Spell Property ED_VampireSpells_BloodBoil_Burst_Spell auto
ReferenceAlias Property ED_BloodBoilTarget  Auto
Message property ED_Mechanics_Message_BloodBoil_FailAliasFilled auto
sound property ED_Art_SoundM_MasterSpellHit auto


