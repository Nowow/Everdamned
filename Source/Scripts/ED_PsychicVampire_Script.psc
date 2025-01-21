Scriptname ED_PsychicVampire_Script extends activemagiceffect  

import math

globalvariable property ED_Mechanics_PsychicVampire_PointGainThreshold_Global auto
faction property ED_Mechanics_PsychicVampire_CheckPerformed_Fac auto

message property ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_TwoHanded_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Marksman_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Block_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Smithing_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_HeavyArmor_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_LightArmor_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Pickpocket_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Lockpicking_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Sneak_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Alchemy_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Speechcraft_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Alteration_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Conjuration_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Destruction_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Illusion_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Restoration_Message auto
message property ED_Mechanics_PsychicVampire_SkillAdvanced_Enchanting_Message auto
	

function OnEffectStart(Actor akTarget, Actor akCaster)

	debug.Trace("Everdamned INFO: Psychic Vampire effect activated on target " + akTarget)
	float _threshold = ED_Mechanics_PsychicVampire_PointGainThreshold_Global.GetValue()
	
	string _skill
	int _diff
	
	_skill = "OneHanded"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "TwoHanded"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Marksman"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Block"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Smithing"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "HeavyArmor"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "LightArmor"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Pickpocket"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Lockpicking"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Sneak"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Alchemy"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Speechcraft"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Alteration"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Conjuration"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Destruction"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Illusion"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Restoration"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	_skill = "Enchanting"
	_diff = Floor((akTarget.GetBaseActorValue(_skill) - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message.Show(_diff as float)
		return
	endif
	
	debug.Trace("Everdamned INFO: Psychic Vampire effect did not find any matching skill, adding to no trigger faction")
	akTarget.AddToFaction(ED_Mechanics_PsychicVampire_CheckPerformed_Fac)
endFunction
