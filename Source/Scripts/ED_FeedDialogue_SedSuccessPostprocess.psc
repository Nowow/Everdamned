;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ED_FeedDialogue_SedSuccessPostprocess Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int _cntr

;make em feel good
ED_Mechanics_FeedDialogue_FeedExpression_Spell.Cast(akSpeakerRef, akSpeakerRef)

return

; race/gender specific sfx
; can move to Victim SFX spell
bool isFemale
race speakerRace
isFemale = akSpeaker.GetActorBase().GetSex() == 1
speakerRace = akSpeaker.GetActorBase().GetRace()

if (speakerRace == KhajiitRace || speakerRace == KhajiitRaceVampire)

	if isFemale == true
		ED_Mechanics_FeedDialogue_BreathFemaleKhajiit_SoundM.Play(akSpeakerRef)
	else
		ED_Mechanics_FeedDialogue_BreathMaleKhajiit_SoundM.Play(akSpeakerRef)
	endif 

elseif (speakerRace == OrcRace || speakerRace == OrcRaceVampire)

	if isFemale == true
		ED_Mechanics_FeedDialogue_BreathFemaleOrc_SoundM.Play(akSpeakerRef)
	else
		ED_Mechanics_FeedDialogue_BreathMaleOrc_SoundM.Play(akSpeakerRef)
	endif
	
else
	
	if isFemale == true
		ED_Mechanics_FeedDialogue_BreathFemale_SoundM.Play(akSpeakerRef)
	else
		ED_Mechanics_FeedDialogue_BreathMale_SoundM.Play(akSpeakerRef)
	endif

endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; listened by ED_FeedDialogue_VictimSFX script
SendModEvent("feedDialogue_last_scene_started")

;walkaway will not happen, whatever happens next we count it as finished dialogue
ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState.SetValue(2)

ED_FeedManager_Script_Quest.HandleDialogueSeduction(akSpeaker)

; seduced faction rank increment moved to controller scene fragments
; because lines activator need to be placed after dialogue ends
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

PlayerVampireQuestScript Property PlayerVampireQuest  Auto  

dlc1vampireturnscript Property DLC1VampireTurn  Auto

ED_FeedManager_Script property ED_FeedManager_Script_Quest auto

Faction Property DLC1PotentialVampireFaction  Auto  

Faction Property DLC1PlayerTurnedVampire  Auto  

Idle Property FeedDialogueIdle  Auto  

Sound Property ED_Mechanics_FeedDialogue_BreathFemale_SoundM  Auto
Sound Property ED_Mechanics_FeedDialogue_BreathFemaleKhajiit_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathFemaleOrc_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathMale_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathMaleKhajiit_SoundM  Auto 
Sound Property ED_Mechanics_FeedDialogue_BreathMaleOrc_SoundM  Auto 

SPELL Property ED_Mechanics_FeedDialogue_FeedExpression_Spell  Auto  

Idle Property ResetRoot  Auto 

Scene Property ED_MesmerizeSafe_Scene_FeedDialogue  Auto  

ReferenceAlias Property ED_FeedDialogue_Target  Auto  

Race Property KhajiitRace Auto 
Race Property KhajiitRaceVampire Auto 
Race Property OrcRace Auto 
Race Property OrcRaceVampire Auto 

SPELL Property FeedDialogue_Cooldown_Spell  Auto  

Activator Property ED_Misc_Activator_FeedDialogueSuccessLines  Auto  

actor property playerRef auto

GlobalVariable Property ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState  Auto  
