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
	
	; TODO:
	;gives temporary faster levelling buff insead of flat points
	;based on skill difference
	;for non-unique PC skill vs target random(current, CalcMaxLVL) scaled skill
	;for unique on CalcMaxLVL
	;blue blood does give actual skill points
	;or just give TEMP BOOST ?
	
	int skillPerLevel = game.GetGameSettingInt("iAVDskillsLevelUp") as int
	int baseSkill = game.GetGameSettingInt("iAVDSkillStart") as int
	int targetLevel = akTarget.getlevel()

	int[] adjustedAVarray = ED_SKSEnativebindings.GetAdjustedAvForComparison(akTarget, targetLevel, skillPerLevel, baseSkill)
	
	int adjustedSkillLevel = adjustedAVarray[0]
	int maxWeightSkillNumber = adjustedAVarray[1]
	message _messageToShow
	
	if maxWeightSkillNumber == 0
        _skill = "OneHanded"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_OneHanded_Message
    elseif maxWeightSkillNumber == 1
        _skill = "TwoHanded"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_TwoHanded_Message
    elseif maxWeightSkillNumber == 2
        _skill = "Marksman"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Marksman_Message
    elseif maxWeightSkillNumber == 3
        _skill = "Block"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Block_Message
    elseif maxWeightSkillNumber == 4
        _skill = "Smithing"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Smithing_Message
    elseif maxWeightSkillNumber == 5
        _skill = "HeavyArmor"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_HeavyArmor_Message
    elseif maxWeightSkillNumber == 6
        _skill = "LightArmor"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_LightArmor_Message
    elseif maxWeightSkillNumber == 7
        _skill = "Pickpocket"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Pickpocket_Message
    elseif maxWeightSkillNumber == 8
        _skill = "Lockpicking"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Lockpicking_Message
    elseif maxWeightSkillNumber == 9
        _skill = "Sneak"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Sneak_Message
    elseif maxWeightSkillNumber == 10
        _skill = "Alchemy"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Alchemy_Message
    elseif maxWeightSkillNumber == 11
        _skill = "Speechcraft"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Speechcraft_Message
    elseif maxWeightSkillNumber == 12
        _skill = "Alteration"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Alteration_Message
    elseif maxWeightSkillNumber == 13
        _skill = "Conjuration"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Conjuration_Message
    elseif maxWeightSkillNumber == 14
        _skill = "Destruction"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Destruction_Message
    elseif maxWeightSkillNumber == 15
        _skill = "Illusion"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Illusion_Message
    elseif maxWeightSkillNumber == 16
        _skill = "Restoration"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Restoration_Message
    elseif maxWeightSkillNumber == 17
        _skill = "Enchanting"
        _messageToShow = ED_Mechanics_PsychicVampire_SkillAdvanced_Enchanting_Message
    endif
	
	_diff = Floor((adjustedSkillLevel - akCaster.GetBaseActorValue(_skill))/_threshold)
	if _diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + _skill + " by " + _diff)
		game.IncrementSkillBy(_skill, _diff)
		_messageToShow.show(_diff as float)
	else
		debug.Trace("Everdamned INFO: Psychic Vampire effect did not find any matching skill, adding to no trigger faction")
	endif

	akTarget.AddToFaction(ED_Mechanics_PsychicVampire_CheckPerformed_Fac)
endFunction
