Scriptname ED_EvdUpdaterScript extends ReferenceAlias


; is not constant, saved into savegame
globalvariable property ED_Mechanics_Global_LastVersion auto
; is constant, reads whats assigned in CK
globalvariable property ED_Mechanics_Global_CurrentVersion auto



Event OnPlayerLoadGame()
	debug.Trace("Everdamned DEBUG: Updater OnPlayerLoadGame called")
	int __currentVersion = ED_Mechanics_Global_CurrentVersion.GetValue() as int
	int __lastVersion = ED_Mechanics_Global_LastVersion.GetValue() as int
	debug.Trace("Everdamned INFO: Current Everdamned Updater version: " + __currentVersion + ", last version: " + __lastVersion)

	if __currentVersion > __lastVersion
		debug.Trace("Everdamned INFO: Everdamned Updater does updating on PlayerLoadGame")
		ED_Mechanics_Global_LastVersion.SetValue(__currentVersion)
		ED_Mechanics_Message_UpdaterStartedUpdate.Show(__lastVersion, __currentVersion)
		
		if playerRef.HasSpell(ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight)
			playerRef.removespell(ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight)
			playerRef.addspell(ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight, false)
			debug.Trace("Everdamned INFO: Everdamned Updater restarted ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight")
		endif
		
		if playerRef.HasSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
			playerRef.removespell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell)
			playerRef.addspell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell, false)
			debug.Trace("Everdamned INFO: Everdamned Updater restarted ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell")
		endif
		if playerRef.HasSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
			playerRef.removespell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell)
			playerRef.addspell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell, false)
			debug.Trace("Everdamned INFO: Everdamned Updater restarted ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell")
		endif
		if playerRef.HasSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
			playerRef.removespell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell)
			playerRef.addspell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell, false)
			debug.Trace("Everdamned INFO: Everdamned Updater restarted ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell")
		endif
		if playerRef.HasSpell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell)
			playerRef.removespell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell)
			playerRef.addspell(ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell, false)
			debug.Trace("Everdamned INFO: Everdamned Updater restarted ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell")
		endif
		if playerRef.HasSpell(ED_NPCVampire_Vanilla_Ab_SunDamage_Spell)
			playerRef.removespell(ED_NPCVampire_Vanilla_Ab_SunDamage_Spell)
			playerRef.addspell(ED_NPCVampire_Vanilla_Ab_SunDamage_Spell, false)
			debug.Trace("Everdamned INFO: Everdamned Updater restarted ED_NPCVampire_Vanilla_Ab_SunDamage_Spell")
		endif
		
		int currentVampireAge = ED_Mechanics_VampireAge.GetValue() as int
		int maxVampireAge = ED_Mechanics_Main_Quest.MaxAge
		debug.Trace("Everdamned INFO: Everdamned Updater sees current age as: " + currentVampireAge)
		
		if currentVampireAge > maxVampireAge
			debug.Trace("Everdamned INFO: Everdamned Updater detects that Vampire Age is out of upper bound of " + maxVampireAge)
				
			; simulating LvlUpAge
			ED_Mechanics_VampireAge.SetValue(maxVampireAge)
			; in previous version of StopAge we unregistred
			; since age is not 1, assuming player is still vampire
			ED_Mechanics_Main_Quest.RegisterForSleep()  
			
			ED_Mechanics_Main_Quest.SetUpAgeAppropriateRewards()
			ED_Mechanics_Main_Quest.StopAge()
			ED_BloodPoolManager_Quest.AtStageOrAgeChange()
			
		endif
		
		
		ED_Mechanics_Message_UpdaterFinishedUpdate.Show()
	endif
endevent


spell property ED_BeingVampire_Vanilla_Ab_PassivesHolder_Spell_WasChampionOfTheNight auto

spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage1_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage2_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage3_Spell auto
spell property ED_BeingVampire_Vanilla_Ab_SunDamage_Stage4_Spell auto
spell property ED_NPCVampire_Vanilla_Ab_SunDamage_Spell auto

message property ED_Mechanics_Message_UpdaterStartedUpdate auto
message property ED_Mechanics_Message_UpdaterFinishedUpdate auto

globalvariable property ED_Mechanics_VampireAge auto
ED_MainQuest_Script property ED_Mechanics_Main_Quest auto
ED_BloodPoolManager_Script property ED_BloodPoolManager_Quest auto

actor property playerRef auto
