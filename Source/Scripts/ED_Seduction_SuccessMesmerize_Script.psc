;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ED_Seduction_SuccessMesmerize_Script Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;walkaway will not happen, whatever happens next we count it as finished dialogue
ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState.SetValue(2)

;SendModEvent("feedDialogue_SocialFeedFinished")

playerRef.DoCombatSpellApply(ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell  Auto  

Actor Property PlayerRef  Auto  

GlobalVariable Property ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState  Auto  
