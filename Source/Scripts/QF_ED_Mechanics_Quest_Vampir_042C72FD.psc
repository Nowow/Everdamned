;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_ED_Mechanics_Quest_Vampir_042C72FD Extends Quest Hidden

;BEGIN ALIAS PROPERTY ED_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_Target
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_Target Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ED_TargetDexion
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ED_TargetDexion Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
actor __target = Alias_ED_Target.GetReference() as actor

if __target
	if __target.GetLevel() > ED_Mechanics_SkillTree_Level_Global.GetValue()
		debug.Notification(__target.GetActorBase().GetName() + " is too powerful for Vampire's Seduction.")
		stop()
		return
	endif
else
	debug.Trace("Everdamned Debug: Vampires Seduction quest not found a regular target")
	__target = Alias_ED_TargetDexion.GetReference() as actor
endif

if __target == None
	debug.Trace("Everdamned Debug: Vampires Seduction quest found didn't find anybody" )	
	stop()
	return
endif


actor playerRef = Game.GetPlayer()

if playerRef.GetHeadingAngle(__target) <= 15.0 && playerRef.GetHeadingAngle(__target) >= -15.0

	ED_Art_VFX_VampiresSeduction_CasterPoint.Play(playerRef, 5.0)
	playerRef.DoCombatSpellApply(ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell, __target)
	
	CustomSkills.AdvanceSkill("EverdamnedMain", 200.0)
	debug.Trace("Everdamned DEBUG: Vampires Seduction was applied to: " + __target)
endif
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property ED_VampirePowers_Vanilla_Pw_VampiresSeduction_Spell_ShockwaveVisual  Auto
spell property ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell auto
visualeffect property ED_Art_VFX_VampiresSeduction_CasterPoint auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto
