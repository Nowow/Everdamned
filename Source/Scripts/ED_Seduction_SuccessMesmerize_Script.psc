;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ED_Seduction_SuccessMesmerize_Script Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
playerRef.DoCombatSpellApply(ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell  Auto  

Actor Property PlayerRef  Auto  
