;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ED_FeedDialogue_SedSuccsessPreproc Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
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

SPELL Property ED_Mechanics_FeedDialogue_ExpressionSmile_Spell  Auto  

SPELL Property ED_Mechanics_FeedDialogue_VictimSFX_Spell  Auto  

GlobalVariable property GameDaysPassed auto

FavorDialogueScript property DialogueFavorGeneric auto

GlobalVariable Property ED_Mechanics_FeedDialogue_Seduction_LastSuccessTime  Auto  

GlobalVariable Property ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours  Auto  

Actor Property PlayerRef  Auto  

quest property ED_Mechanics_Quest_RollFeedDialogueScore auto
