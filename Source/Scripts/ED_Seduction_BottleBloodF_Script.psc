;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname ED_Seduction_BottleBloodF_Script Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.PlayIdle(ResetRoot)
akSpeaker.PlayIdle(IdleDwemerExtractor)
utility.wait(3.6)
playerRef.PlayIdle(ResetRoot)
playerRef.PlayIdle(IdleTake)
akSpeaker.DamageActorValue("ED_HpDrainedTimer", akSpeaker.GetBaseActorValue("ED_HpDrainedTimer") * 0.7)
playerRef.AddItem(DLC1BloodPotion, 2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;walkaway will not happen, whatever happens next we count it as finished dialogue
ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState.SetValue(2)

SendModEvent("feedDialogue_SocialFeedFinished")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property IdleDwemerExtractor  Auto  

GlobalVariable Property ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState  Auto  

Potion Property DLC1BloodPotion  Auto  

Idle Property ResetRoot  Auto  

Idle Property IdleTake  Auto  

Actor Property PlayerRef  Auto  
