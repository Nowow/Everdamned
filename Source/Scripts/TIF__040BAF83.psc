;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__040BAF83 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;debug.trace("seduc success response")
ED_Mechanics_FeedDialogue_FeedExpression_Spell.Cast(akSpeakerRef, akSpeakerRef)
ED_Mechanics_FeedDialogue_HeartPalpitations_Imod.Apply()
ED_Mechanics_FeedDialogue_HeartPalpitations_SoundM.Play(akSpeakerRef)
utility.wait(2)
ED_Mechanics_FeedDialogue_BreathFemale_SoundM.Play(akSpeakerRef)
utility.wait(1)
if akSpeaker.IsInFaction(DLC1PotentialVampireFaction) && akSpeaker.IsInFaction(DLC1PlayerTurnedVampire) == False
	DLC1VampireTurn.PlayerBitesMe(akSpeaker)
endif
Game.GetPlayer().PlayIdle(ResetRoot)
Game.GetPlayer().PlayIdleWithTarget(FeedDialogueIdle, akSpeaker)
PlayerVampireQuest.VampireFeed()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PlayerVampireQuestScript Property PlayerVampireQuest  Auto  

dlc1vampireturnscript Property DLC1VampireTurn  Auto  

Faction Property DLC1PotentialVampireFaction  Auto  

Faction Property DLC1PlayerTurnedVampire  Auto  

Idle Property FeedDialogueIdle  Auto  

ImageSpaceModifier Property ED_Mechanics_FeedDialogue_HeartPalpitations_Imod  Auto  


Sound Property ED_Mechanics_FeedDialogue_HeartPalpitations_SoundM  Auto  

Sound Property ED_Mechanics_FeedDialogue_BreathFemale_SoundM  Auto  

SPELL Property ED_Mechanics_FeedDialogue_FeedExpression_Spell  Auto  

Idle Property ResetRoot  Auto  
