Scriptname DONOTINCLIDEed_test_me_script extends ActiveMagicEffect  




string AVName

float lastSkillExp

event OnEffectStart(Actor akTarget, Actor akCaster)

	;AVName = "Destruction"
		
	;currentAVInfo = ActorValueInfo.GetActorValueInfoByName(AVName)
	
	;debug.Trace("Everdamned DEBUG: Currently Checked AV: " + AVName)
	RegisterForUpdate(1.0)

endevent

function checkSkill(string skillName)

	actorvalueinfo currentAVInfo = ActorValueInfo.GetActorValueInfoByName(skillName)
	float currentSkillExp = currentAVInfo.GetSkillExperience()
	if currentSkillExp == lastSkillExp
		return
	endif
	
	int nextSkillLevel = currentAVInfo.GetCurrentValue(playerRef) as int + 1
	float nextLevelAt = currentAVInfo.GetExperienceForLevel(nextSkillLevel)
	float delta = currentSkillExp - lastSkillExp
	lastSkillExp = currentSkillExp
	
	debug.Trace("Everdamned DEBUG: New exp for skill " + skillName + ": " + currentSkillExp)
	debug.Trace("Everdamned DEBUG: Delta: " + delta + ", Next level " + nextSkillLevel + " at: " + nextLevelAt)
endfunction

event OnUpdate()

	checkSkill("Destruction")
	;checkSkill("Conjuration")
	;checkSkill("Alteration")
	
endevent
;Function ScaleNode(actor akTarget, String spellNode, Float scale)
;	NetImmerse.SetNodeScale(akTarget, spellNode, scale, false)
;	NetImmerse.SetNodeScale(akTarget, spellNode, scale, true)
;EndFunction


actor property playerRef auto
