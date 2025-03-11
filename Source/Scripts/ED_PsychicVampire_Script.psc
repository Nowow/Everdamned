Scriptname ED_PsychicVampire_Script extends Quest  

import math

globalvariable property ED_Mechanics_PsychicVampire_PointGainThreshold_Global auto
faction property ED_Mechanics_PsychicVampire_CheckPerformed_Fac auto

message property ED_Mechanics_PsychicVampire_skillAdvanced_OneHanded_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_TwoHanded_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Marksman_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Block_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Smithing_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_HeavyArmor_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_LightArmor_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Pickpocket_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Lockpicking_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Sneak_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Alchemy_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Speechcraft_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Alteration_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Conjuration_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Destruction_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Illusion_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Restoration_Message auto
message property ED_Mechanics_PsychicVampire_skillAdvanced_Enchanting_Message auto



Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)

	actor __victim = akRef1 as actor
	
	if !__victim
		debug.Trace("Everdamned INFO: Psychic Vampire victim is none, stopping quest")
		stop()
		return
	endif
	
	debug.Trace("Everdamned INFO: Psychic Vampire quest started, target " + akRef1)
	
	float __threshold = ED_Mechanics_PsychicVampire_PointGainThreshold_Global.GetValue()
	string __skill
	int __diff
	
	; TODO:
	;gives temporary faster levelling buff insead of flat points
	;based on skill difference
	;for non-unique PC skill vs target random(current, CalcMaxLVL) scaled skill
	;for unique on CalcMaxLVL
	;blue blood does give actual skill points
	;or just give TEMP BOOST ?
	
	int skillPerLevel = game.GetGameSettingInt("iAVDskillsLevelUp") as int
	int baseSkill = game.GetGameSettingInt("iAVDSkillStart") as int
	int targetLevel = __victim.getlevel()

	int[] adjustedAVarray = ED_SKSEnativebindings.GetAdjustedAvForComparison(__victim, targetLevel, skillPerLevel, baseSkill)
	
	int adjustedSkillLevel = adjustedAVarray[0]
	int maxWeightSkillNumber = adjustedAVarray[1]
	message __messageToShow
	
	if maxWeightSkillNumber == 0
        __skill = "OneHanded"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_OneHanded_Message
    elseif maxWeightSkillNumber == 1
        __skill = "TwoHanded"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_TwoHanded_Message
    elseif maxWeightSkillNumber == 2
        __skill = "Marksman"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Marksman_Message
    elseif maxWeightSkillNumber == 3
        __skill = "Block"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Block_Message
    elseif maxWeightSkillNumber == 4
        __skill = "Smithing"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Smithing_Message
    elseif maxWeightSkillNumber == 5
        __skill = "HeavyArmor"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_HeavyArmor_Message
    elseif maxWeightSkillNumber == 6
        __skill = "LightArmor"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_LightArmor_Message
    elseif maxWeightSkillNumber == 7
        __skill = "Pickpocket"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Pickpocket_Message
    elseif maxWeightSkillNumber == 8
        __skill = "Lockpicking"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Lockpicking_Message
    elseif maxWeightSkillNumber == 9
        __skill = "Sneak"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Sneak_Message
    elseif maxWeightSkillNumber == 10
        __skill = "Alchemy"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Alchemy_Message
    elseif maxWeightSkillNumber == 11
        __skill = "Speechcraft"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Speechcraft_Message
    elseif maxWeightSkillNumber == 12
        __skill = "Alteration"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Alteration_Message
    elseif maxWeightSkillNumber == 13
        __skill = "Conjuration"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Conjuration_Message
    elseif maxWeightSkillNumber == 14
        __skill = "Destruction"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Destruction_Message
    elseif maxWeightSkillNumber == 15
        __skill = "Illusion"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Illusion_Message
    elseif maxWeightSkillNumber == 16
        __skill = "Restoration"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Restoration_Message
    elseif maxWeightSkillNumber == 17
        __skill = "Enchanting"
        __messageToShow = ED_Mechanics_PsychicVampire_skillAdvanced_Enchanting_Message
    endif
	
	__diff = Floor((adjustedSkillLevel - playerRef.GetBaseActorValue(__skill))/__threshold)
	if __diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + __skill + " by " + __diff)
		game.IncrementSkillBy(__skill, __diff)
		__messageToShow.show(__diff as float)
	else
		debug.Trace("Everdamned INFO: Psychic Vampire effect did not find any matching skill")
	endif

	__victim.AddToFaction(ED_Mechanics_PsychicVampire_CheckPerformed_Fac)
	stop()
endevent

actor property playerRef auto
