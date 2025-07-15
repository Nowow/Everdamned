;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname ED_TIF_SeductionStart_Store Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_FeedDialogue_Target.ForceRefTo(akSpeaker)

ED_Mechanics_Keyword_RollFeedDialogueScore.SendStoryEvent(None, playerRef, akSpeaker, 0, 0)

; here because needs to exist before controller scene starts
ED_FeedDialogue_StartLocMarker.ForceRefTo(akSpeaker.PlaceAtMe(FXEmptyActivator))

if ED_Controller_FeedDialogue_Scene.IsPlaying()
	ED_Controller_FeedDialogue_Scene.Stop()
	utility.wait(0.5)
endif

ED_Controller_FeedDialogue_Scene.Start()

ED_Mechanics_FeedDialogue_DarkRadius.SetValue(35.0)
ED_Mechanics_FeedDialogue_LightRadius.SetValue(210.0)

utility.wait(4.0)
if !ThisTopicFinished  && akSpeaker.IsInDialogueWithPlayer()
	input.TapKey(input.GetMappedKey("Activate"))
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ThisTopicFinished = true

while !(ED_Mechanics_Quest_RollFeedDialogueScore.IsStopped())
	utility.wait(0.1)
endwhile

; success stage
if ED_Mechanics_Quest_RollFeedDialogueScore.IsStageDone(100)
	debug.Trace("Everdamned INFO: Feed Dialogue determined Score Roll was successful")
else
	debug.Trace("Everdamned ERROR: Feed Dialogue determined Score Roll was FAILED")
endif
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

quest property ED_Mechanics_Quest_RollFeedDialogueScore auto

Bool Property ThisTopicFinished  Auto  

globalvariable property ED_Mechanics_FeedDialogue_DarkRadius auto

globalvariable property ED_Mechanics_FeedDialogue_LightRadius auto
