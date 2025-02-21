Scriptname ED_HotKeys_Script extends Quest  

int __currentTestHotkey

Function RegisterHotkeys()
	__currentTestHotkey = ED_Test_Hotkey.GetValue() as int
	RegisterForKey(__currentTestHotkey)
EndFunction

Function UnRegisterHotkeys()
	UnRegisterForKey(__currentTestHotkey)
	__currentTestHotkey = 0
EndFunction


;DEBUG
actorvalueinfo avi
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentTestHotkey
		Debug.MessageBox("Everdamned DEBUG: test key was pressed!")
		
		debug.Trace("Everdamned DEBUG: ---------------------------------------------")
		
		;debug.Trace("Everdamned DEBUG: GetSkillName " + CustomSkills.GetSkillName("EverdamnedMain")) 
		;CustomSkills.AdvanceSkill("EverdamnedMain", game.getplayer().getactorvalue("variable08"))
		
		;avi =  actorvalueinfo.GetActorValueInfoByName("Destruction")
		;debug.Trace("Everdamned DEBUG: avi is skill: " + avi.isskill())
		;debug.Trace("Everdamned DEBUG: avi is skill: " + avi.isskill())
		;debug.Trace("Everdamned DEBUG: avi GetSkillOffsetMult() " + avi.GetSkillOffsetMult())
		;debug.Trace("Everdamned DEBUG: avi GetSkillUseMult() " + avi.GetSkillUseMult())
		;debug.Trace("Everdamned DEBUG: avi GetSkillImproveMult() " + avi.GetSkillImproveMult())
		;debug.Trace("Everdamned DEBUG: avi GetSkillImproveOffset() " + avi.GetSkillImproveOffset())
		;debug.Trace("Everdamned DEBUG: avi GetSkillExperience() " + avi.GetSkillExperience())
		;debug.Trace("Everdamned DEBUG: avi GetExperienceForLevel() " + avi.GetExperienceForLevel(avi.GetCurrentValue(game.getplayer()) as int))
		
		avi =  actorvalueinfo.GetActorValueInfoByName("Destruction")
		__timer = 0
		RegisterForUpdate(1.0)
	Endif
	
EndEvent

;DEBUG
float __currentExp
float __prevExp
int __timer
;DEBUG
event OnUpdate()
	__currentExp = avi.GetSkillExperience()
	debug.Trace("Everdamned DEBUG: -----------")
	debug.Trace("Everdamned DEBUG: avi GetExperienceForLevel() "  + __currentExp)
	debug.Trace("Everdamned DEBUG: exp diff "  + (__currentExp - __prevExp))
	debug.Trace("Everdamned DEBUG: avi GetExperienceForLevel() " + avi.GetExperienceForLevel(avi.GetCurrentValue(game.getplayer()) as int))
	__prevExp = __currentExp
	__timer += 1
	if __timer >= 10
		UnregisterForUpdate()
	endif
endevent

GlobalVariable Property ED_Test_Hotkey Auto
