Scriptname ED_Mesmerize_Script extends activemagiceffect  

actor __target

EVENT OnEffectStart(Actor Target, Actor Caster)

	debug.trace("Everdamned DEBUG: Start Mesmerize quest with actor " + Target)
	if ED_Mechanics_Quest_Mesmerize.IsRunning() || ED_Mechanics_Quest_Mesmerize.IsStarting()
		ED_Mechanics_Quest_Mesmerize.Stop()
		debug.Trace("Everdamned DEBUG: Mesmerize ME encountered a running / starting Mesmerize quest. Restarting it")
	endif
	
	; failsafe
	int __counter = 30
	
	while !(ED_Mechanics_Quest_Mesmerize.IsStopped()) && __counter > 0
		__counter -= 1
		utility.wait(0.1)
	endwhile
	
	if __counter <= 0
		debug.Trace("Everdamned ERROR: Mesmerize ME waited whole 3 seconds for Distraction quest to stop, WHY IS IT STOPPING SO LONG??")
		debug.MessageBox("Everdamned DEBUG: Mesmerize not applied because Mesmerize ME couldnt wait for Mesmerize quest to finish, report to mod author")
		return
	endif
	
	ED_Mechanics_Keyword_StartMesmerizeQuest.SendStoryEvent(akRef1 = Target)
	Target.SetLookAt(Caster)
	__target = Target
	
	;CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endEVENT

EVENT OnEffectFinish(Actor Target, Actor Caster)
	debug.trace("Everdamned DEBUG: Mesmerize effect finished")
	__target.ClearLookAt()
endevent

float property XPgained auto
quest property ED_Mechanics_Quest_Mesmerize auto
keyword property ED_Mechanics_Keyword_StartMesmerizeQuest auto
