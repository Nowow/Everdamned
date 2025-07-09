;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_FeedDialogue_041771D7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_Mechanics_FeedDialogue_ExpressionSmile_Spell.Cast(akSpeaker)
ED_Mechanics_FeedDialogue_VictimSFX_Spell.Cast(akSpeaker)

if (GameDaysPassed.value - ED_Mechanics_FeedDialogue_Seduction_LastSuccessTime.value) * 24.0100 >= ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.value
	ED_Mechanics_FeedDialogue_Seduction_LastSuccessTime.SetValue(GameDaysPassed.value)
	DialogueFavorGeneric.Persuade(akSpeaker)
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
