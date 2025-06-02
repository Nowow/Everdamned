Scriptname ED_Confuse_Script extends activemagiceffect  


event OnEffectStart(Actor Target, Actor Caster)

	; TODO: redo to Confusion cooldown
	if Target.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_ConfusionImmune)
		debug.Trace("Everdamned DEBUG: Confusion will not be applied due to Confusion immunity")
		MEssage.ResetHelpMessage("ed_confusion_immunity")
		ED_Mechanics_Message_VampiresCommandImmune.ShowAsHelpMessage("ed_confusion_immunity", 4, 30, 1)
		;ED_Mechanics_Message_VampiresCommandImmune.Show()
		return
	endif
	
	Caster.DamageActorValue("ED_BloodPool", 300.0)
	
	int __commandChoice
	__commandChoice = ED_Mechanics_Message_VampriesWill_ConfusePrompt.Show()
		
	if __commandChoice == 0
		;debug.Trace("Everdamned DEBUG: Vampires Will casts ED_Mechanics_Apparation_Spell on target " + Target)
		;ED_Mechanics_Apparation_Spell.Cast(Target, Target)
		
		debug.Trace("Everdamned DEBUG: Starting Distraction Scenes quest on target " + Target)
		
		; dont want to deal with race conditions on VampiresWillTarget alias
		utility.wait(0.3)
		
		if ED_Mechanics_Quest_DistractionScenes.IsRunning() || ED_Mechanics_Quest_DistractionScenes.IsStarting()
			ED_Mechanics_Quest_DistractionScenes.Stop()
			debug.Trace("Everdamned WARNING: Confusion ME encountered a running / starting Distraction quest, should not have happened? Restarting it")
		endif
		
		; failsafe
		int __counter = 30
		
		while !(ED_Mechanics_Quest_DistractionScenes.IsStopped()) && __counter > 0
			__counter -= 1
			utility.wait(0.1)
		endwhile
		
		if __counter <= 0
			debug.Trace("Everdamned ERROR: Confuse ME waited whole 3 seconds for Distraction quest to stop, WHY IS IT STOPPING SO LONG??")
			debug.MessageBox("Everdamned DEBUG: Confusion not applied because Confusion ME couldnt wait for Distraction quest to finish, report to mod author")
			return
		endif
		
		ED_Mechanics_Keyword_DistractionSceneQuestStart.SendStoryEvent(akRef1 = Target)
		
	endif
endevent


quest property ED_Mechanics_Quest_DistractionScenes auto
keyword property ED_Mechanics_Keyword_DistractionSceneQuestStart auto

keyword property ED_Mechanics_Keyword_ConfusionImmune auto
message property ED_Mechanics_Message_VampiresCommandImmune auto
message property ED_Mechanics_Message_VampriesWill_ConfusePrompt auto
spell property ED_Mechanics_Apparation_Spell auto
spell property ED_Mechanics_VampiresCommandImmunity_Spell auto
