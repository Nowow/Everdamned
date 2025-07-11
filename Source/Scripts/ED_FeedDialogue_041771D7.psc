;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ED_FeedDialogue_041771D7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as Ed_FeedDialogue_Script).WaitForScoreCalcToFinish()
debug.trace("Everdamned DEBUG: Feed Dialogue ForceGreet bridge finished waiting for score to calc")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


SPELL Property ED_Mechanics_FeedDialogue_ExpressionSmile_Spell  Auto  

SPELL Property ED_Mechanics_FeedDialogue_VictimSFX_Spell  Auto  

GlobalVariable property GameDaysPassed auto

FavorDialogueScript property DialogueFavorGeneric auto

GlobalVariable Property ED_Mechanics_FeedDialogue_Seduction_LastSuccessTime  Auto  

GlobalVariable Property ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours  Auto  

Actor Property PlayerRef  Auto  
