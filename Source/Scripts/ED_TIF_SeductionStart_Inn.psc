;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname ED_TIF_SeductionStart_Inn Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_FeedDialogue_Target.ForceRefTo(akSpeaker)

ED_Mechanics_Keyword_RollFeedDialogueScore.SendStoryEvent(None, playerRef, akSpeaker, 0, 0)

; here because needs to exist before controller scene starts
ED_FeedDialogue_StartLocMarker.ForceRefTo(akSpeaker.PlaceAtMe(FXEmptyActivator))

ED_Controller_FeedDialogue_Scene.Start()
utility.wait(2.0)
if akSpeaker.IsInDialogueWithPlayer()
	input.TapKey(input.GetMappedKey("Activate"))
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;debug.MessageBox("End fragment started")
;(GetOwningQuest() as Ed_FeedDialogue_Script).RollFeedDialogueChecks(PlayerRef, akSpeakerRef as Actor)

;(GetOwningQuest() as Ed_FeedDialogue_Script).WaitForScoreCalcToFinish()
;debug.trace("Everdamned DEBUG: Feed Dialogue START TOPIC finished waiting for score to calc")
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

Keyword Property ED_Mechanics_Keyword_RollFeedDialogueScore  Auto  
