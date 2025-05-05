Scriptname ED_MesmerizeQuest_Script extends Quest  


function DispelSeductionOnShutdown()
	actor __target = ED_Target.GetReference() as actor
	if __target && !(__target.IsDead())
		debug.Trace("Everdamned DEBUG: Mesmerize Quest shuts down and dispels Vampires Seduction spell from its target")
		__target.DispelSpell(ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell)
	else
		debug.Trace("Everdamned DEBUG: Mesmerize Quest shuts down, but no dispell because target is dead or doesnt exist anymore lol")
	endif
	ED_Mechanics_Global_MesmerizeShouldFollow.SetValue(0)
endfunction

referencealias property ED_Target auto
spell property ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell auto
globalvariable property ED_Mechanics_Global_MesmerizeShouldFollow auto
