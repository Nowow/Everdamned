Scriptname ED_MesmerizeQuest_Script extends Quest  

event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, Int aiValue1, Int aiValue2)
	debug.Trace("Everdamned DEBUG: Mesmerize Quest started from event!!!")
endevent

function DispelSeductionOnShutdown()
	actor __target = ED_Target.GetReference() as actor
	if __target && !(__target.IsDead())
		debug.Trace("Everdamned DEBUG: Mesmerize Quest shuts down and dispels Vampires Seduction spell from its target")
		__target.DispelSpell(ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell)
	else
		debug.Trace("Everdamned DEBUG: Mesmerize Quest shuts down, but no dispell because target is dead or doesnt exist anymore lol")
	endif
	
	if playerRef.HasMagicEffect(ED_VampirePowers_Pw_Dominate_Effect) && !(__target.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_CurrentlyDominated))
		
		int __currentFollowSetting = ED_Mechanics_Global_MesmerizeShouldFollow.GetValue() as int
		debug.Trace("Everdamned DEBUG: Mesmerize Quest current follow setting is: " + __currentFollowSetting)
		if __currentFollowSetting == 0
			ED_Mechanics_Dominate_SceneController_Wait_Spell.Cast(playerRef, __target)
		elseif __currentFollowSetting == 1
			ED_Mechanics_Dominate_SceneController_Follow_Spell.Cast(playerRef, __target)
		endif
		
	endif
	ED_Mechanics_Global_MesmerizeShouldFollow.SetValue(-1)
endfunction

actor property playerRef auto

referencealias property ED_Target auto
spell property ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell auto
globalvariable property ED_Mechanics_Global_MesmerizeShouldFollow auto

magiceffect property ED_VampirePowers_Pw_Dominate_Effect auto
spell property ED_Mechanics_Dominate_SceneController_Wait_Spell auto
spell property ED_Mechanics_Dominate_SceneController_Follow_Spell auto
keyword property ED_Mechanics_Keyword_CurrentlyDominated auto
