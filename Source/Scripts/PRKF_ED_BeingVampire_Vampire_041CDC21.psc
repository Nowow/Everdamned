;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 45
Scriptname PRKF_ED_BeingVampire_Vampire_041CDC21 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleDrainThrall(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleFeedThrall(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleDrainMesmerized(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleFeedMesmerized(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleDrainSleep(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleCombatDrain(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleCombatDrain(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleFeedThrall(akTargetRef as actor)
debug.Trace("Everdamned DEBUG: Dexion is bitten!!! perk")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_FeedManager_Quest.HandleFeedSleep(akTargetRef as actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ED_FeedManager_Script property ED_FeedManager_Quest auto
