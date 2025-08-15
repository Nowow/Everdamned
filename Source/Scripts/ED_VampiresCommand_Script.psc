Scriptname ED_VampiresCommand_Script extends activemagiceffect  

bool __dontAwardExp
function OnEffectStart(Actor akTarget, Actor akCaster)

	ED_SoundOnEffectStart.Play(akTarget)
	while ED_Mechanics_Quest_VampiresCommand.IsRunning() || ED_Mechanics_Quest_VampiresCommand.IsStopping()
		__dontAwardExp = true
		utility.Wait(0.100000)
	endWhile
	ED_Mechanics_Quest_VampiresCommand.Start()
	
	if !__dontAwardExp
		CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
		__dontAwardExp = false
	endif
	
	
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)

	ED_SoundOnEffectEnd.Play(akTarget as objectreference)
	Actor TheTarget = ED_Target.GetActorReference()
	if TheTarget	
		Int i = 0
		while i < ED_Misc_VampiresCommand_SceneControllers_FormList.GetSize()
			TheTarget.DispelSpell(ED_Misc_VampiresCommand_SceneControllers_FormList.GetAt(i) as spell)
			i += 1
		endWhile
	endIf
	ED_Mechanics_Quest_VampiresCommand.Stop()
endFunction

float property XPgained auto
quest property ED_Mechanics_Quest_VampiresCommand auto
referencealias property ED_Target auto
formlist property ED_Misc_VampiresCommand_SceneControllers_FormList auto

sound property ED_SoundOnEffectEnd auto
sound property ED_SoundOnEffectStart auto
