;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname PRKF_ED_TEST_Perk_060B87E4 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
actor thisTarget = (akTargetRef as actor)
thisTarget.DamageActorValue("Health", thisTarget.GetActorValue("Health") - 2.0)
utility.wait(2.0)
ED_FeedManager_Quest.HandleCombatDrain(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_Misc_Spell_StaggerSelf_Spell.Cast(akTargetRef, akTargetRef)

utility.wait(0.8)

ED_FeedManager_Quest.HandleCombatDrain(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ED_FeedManager_Script property ED_FeedManager_Quest auto


SPELL Property ED_Misc_Spell_StaggerSelf_Spell  Auto  
