;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ED_SeductionDialogueContr_0560A490 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;
debug.MessageBox("Feed dialogue target finished dialogue")
sceneTarget.ClearLookAt()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
debug.MessageBox("Feed dialogue target started controller scene")
sceneTarget = ED_FeedDialogue_Target.GetReference() as actor

playerRef.PlayIdle(ED_Idle_Seduction_PlayerSeqStart)

; TODO: furniture exiting
;debug.SendAnimationEvent(sceneTarget, "IdleChairExitStart")

;this does not work
;sceneTarget.playIdle(Chair)

ED_Mechanics_FeedDialogue_Signal_Spell.Cast(sceneTarget, sceneTarget)

sceneTarget.SetLookAt(playerRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property ED_FeedDialogue_Target  Auto  

actor Property PlayerRef  Auto  

Actor Property sceneTarget  Auto  

Idle Property Chair  Auto  

SPELL Property ED_Mechanics_FeedDialogue_Signal_Spell  Auto  

Idle Property ED_Idle_Seduction_PlayerSeqStart  Auto  
