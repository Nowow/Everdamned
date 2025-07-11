;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname ED_TIF_SeductionStart_Inn Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_FeedDialogue_Target.ForceRefTo(akSpeaker)

ED_FeedDialogue_StartLocMarker.ForceRefTo(akSpeaker.PlaceAtMe(FXEmptyActivator))

ED_Controller_FeedDialogue_Scene.Start()
utility.wait(1.0)
if akSpeaker.IsInDialogueWithPlayer()
	input.TapKey(input.GetMappedKey("Activate"))
endif
(GetOwningQuest() as Ed_FeedDialogue_Script).RollFeedDialogueChecks(PlayerRef, akSpeakerRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef  Auto  

SPELL Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell  Auto  

Idle Property ED_Idle_Seduction_PlayerSeqStart  Auto  

ReferenceAlias Property ED_FeedDialogue_Target  Auto  

Scene Property ED_Controller_FeedDialogue_Scene  Auto  

ReferenceAlias Property ED_FeedDialogue_StartLocMarker  Auto  

Activator Property FXEmptyActivator  Auto  
