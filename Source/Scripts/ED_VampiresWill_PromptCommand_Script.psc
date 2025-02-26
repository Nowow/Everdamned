Scriptname ED_VampiresWill_PromptCommand_Script extends activemagiceffect  


event OnEffectStart(Actor Target, Actor Caster)
	int __commandChoice
	__commandChoice = ED_Mechanics_Message_IssueCommandPrompt.Show()
	; TODO: blood pool cost
	debug.Trace("Everdamned NOTIMPLEMENTED DEBUG: add blood pool cost to issuing a command")
	if __commandChoice == 0
		ED_Misc_VampiresCommand_SceneController_Wait_Spell.Cast(Target, Caster)
	elseif __commandChoice == 1
		ED_Misc_VampiresCommand_SceneController_Flee_Spell.Cast(Target, Caster)
	elseif __commandChoice == 2
		ED_Misc_VampiresCommand_SceneController_Dance_Spell.Cast(Target, Caster)
	else
		debug.Trace("Everdamned ERROR: Vampire's Will command prompt returned choice value that is unaccounter for in script")
	endif
endevent


message property ED_Mechanics_Message_IssueCommandPrompt auto

spell property ED_Misc_VampiresCommand_SceneController_Dance_Spell auto
spell property ED_Misc_VampiresCommand_SceneController_Flee_Spell auto
spell property ED_Misc_VampiresCommand_SceneController_Follow_Spell auto
spell property ED_Misc_VampiresCommand_SceneController_Wait_Spell auto
