Scriptname ED_BloodBoil_BurnScript extends activemagiceffect  

actor _target
actor _caster

function OnEffectStart(Actor akTarget, Actor akCaster)


	ED_Art_SoundM_MasterSpellHit.Play(akTarget)
	
	_target = akTarget
	_caster = akCaster
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
	; doing it in papyrus because dont trust spell side conditions, feels like they might give start+stops
	; also because dont trust papyrus functions to be equivalent to CK 
	if _target.GetActorValuePercentage("Health") < 0.51
		if ED_Mechanics_Quest_BloodBoil.IsStopped()
			debug.Trace("Everdamned DEBUG: Blood Boil Burn starts Burst quest right away!")
			ED_Mechanics_Keyword_BloodBoil_StartQuest.SendStoryEvent(None, _target)
			self.dispel()
			return
		else
			ED_Mechanics_Message_BloodBoil_FailAliasFilled.ShowAsHelpMessage("ed_bloodboil_limit", 3.0, 5.0, 1)
			Message.ResetHelpMessage("ed_bloodboil_limit")
			debug.Trace("Everdamned DEBUG: Blood Boil Burn cant start quest because it is not stopped, aborting")
			self.dispel()
			return
		endif
	endif
	
	RegisterForSingleUpdate(1.0) ; unregisters are handled automatically
endfunction

event OnUpdate()

	if _target.GetActorValuePercentage("Health") < 0.51
		debug.Trace("Everdamned DEBUG: Blood Boil Burn starts Burst quest!")
		ED_Mechanics_Keyword_BloodBoil_StartQuest.SendStoryEvent(None, _target)
		self.dispel()
		return
	endif
	
	RegisterForSingleUpdate(1.0)
endevent

float property XPgained auto

ReferenceAlias Property ED_BloodBoilTarget  Auto
Message property ED_Mechanics_Message_BloodBoil_FailAliasFilled auto
sound property ED_Art_SoundM_MasterSpellHit auto
quest property ED_Mechanics_Quest_BloodBoil auto
keyword property ED_Mechanics_Keyword_BloodBoil_StartQuest auto
