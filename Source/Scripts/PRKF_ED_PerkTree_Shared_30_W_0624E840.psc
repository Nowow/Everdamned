;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname PRKF_ED_PerkTree_Shared_30_W_0624E840 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
actor __target = akTargetRef as actor
if Lock
	return
endif
Lock = true

ED_Mechanics_Global_FeedType.SetValue(0.0)
;akActor.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, __target)
akActor.StartVampireFeed(__target)

utility.wait(1.0)

__target.DamageActorValue("ED_HpDrainedTimer", __target.GetBaseActorValue("ED_HpDrainedTimer") * 0.7)
akActor.AddItem(ED_Mechanics_BloodPotionWeak, 1)


lock = false
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Bool Property Lock  Auto  

Potion Property ED_Mechanics_BloodPotionWeak  Auto  

GlobalVariable Property ED_Mechanics_Global_FeedType  Auto  

Idle Property IdleVampireStandingFeedFront_Loose  Auto  

Idle Property IdleVampireStandingFeedBack_Loose  Auto  
