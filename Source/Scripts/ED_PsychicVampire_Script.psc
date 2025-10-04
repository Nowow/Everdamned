Scriptname ED_PsychicVampire_Script extends Quest  

import math


message[] property skillMessageArray auto
string[] property skillNameArray auto


	;gives temporary faster levelling buff insead of flat points
	;based on skill difference
	;for non-unique PC skill vs target random(current, CalcMaxLVL) scaled skill
	;for unique on CalcMaxLVL
	;blue blood does give actual skill points
	;or just give TEMP BOOST ?

Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)

	actor __victim = akRef1 as actor
	
	if !__victim
		debug.Trace("Everdamned INFO: Psychic Vampire victim is none, stopping quest")
		stop()
		return
	endif
	
	debug.Trace("Everdamned INFO: Psychic Vampire quest started, target " + __victim)
	
	float __threshold = ED_Mechanics_PsychicVampire_PointGainThreshold_Global.GetValue()
	int skillPerLevel = game.GetGameSettingInt("iAVDskillsLevelUp") as int
	int baseSkill = game.GetGameSettingInt("iAVDSkillStart") as int
	int targetLevel = __victim.getlevel()
	int[] adjustedAVarray = ED_SKSEnativebindings.GetAdjustedAvForComparison(__victim, targetLevel, skillPerLevel, baseSkill)
	
	int adjustedSkillLevel = adjustedAVarray[0]
	int maxWeightSkillNumber = adjustedAVarray[1]
	string __skill = skillNameArray[maxWeightSkillNumber]
	message __messageToShow = skillMessageArray[maxWeightSkillNumber]

	int __diff
	
	if __victim.IsInFaction(JobTrainerFaction)
		debug.Trace("Everdamned INFO: Eaten Actor was a trainer")
		__diff = Ceiling((adjustedSkillLevel - playerRef.GetBaseActorValue(__skill))/__threshold)
	else
		__diff = Floor((adjustedSkillLevel - playerRef.GetBaseActorValue(__skill))/__threshold)
	endif
	
	if __diff > 0
		debug.Trace("Everdamned INFO: Psychic Vampire will increase " + __skill + " by " + __diff)
		game.IncrementSkillBy(__skill, __diff)
		__messageToShow.show(__diff as float)
	else
		debug.Trace("Everdamned INFO: Psychic Vampire effect did not find any matching skill that would be high enough")
	endif

	__victim.AddToFaction(ED_Mechanics_PsychicVampire_CheckPerformed_Fac)
	stop()
endevent

actor property playerRef auto

globalvariable property ED_Mechanics_PsychicVampire_PointGainThreshold_Global auto
faction property ED_Mechanics_PsychicVampire_CheckPerformed_Fac auto
faction property JobTrainerFaction auto
