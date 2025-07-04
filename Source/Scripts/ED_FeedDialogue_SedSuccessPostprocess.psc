;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ED_FeedDialogue_SedSuccessPostprocess Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; listened by ED_FeedDialogue_VictimSFX script
SendModEvent("feedDialogue_last_scene_started")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int _cntr

actor PlayerRef = Game.GetPlayer()

; for walk-away type situations
if !(akSpeakerRef.IsInDialogueWithPlayer())
	debug.Trace("Everdamned: First check determined player didnt wait to feed, calling ResetRoot")
	playerRef.PlayIdle(ResetRoot)
	akSpeaker.PlayIdle(ResetRoot)
	return
endif

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

;make em feel good
ED_Mechanics_FeedDialogue_FeedExpression_Spell.Cast(akSpeakerRef, akSpeakerRef)

utility.wait(1)

;recheck, if player cant wait 1 sec
if !(akSpeakerRef.IsInDialogueWithPlayer())
	debug.Trace("Everdamned: Second check determined player didnt wait to feed, calling ResetRoot")
	playerRef.PlayIdle(ResetRoot)
	akSpeaker.PlayIdle(ResetRoot)
	;maybe wave?
	return
endif

ED_FeedManager_Script_Quest.HandleDialogueSeduction(akSpeaker)

; TODO: will enable when figure out how to ensure Mesmerize idle will play, also need to add headtrack-off mesmerized idle
;ED_MesmerizeSafe_Scene_FeedDialogue.Start()

int currentFactionRank = akSpeaker.GetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac)
if currentFactionRank < 0
	akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 0)
	debug.trace("Victim seduced fac is now to seduced fac at rank 0")
elseif currentFactionRank < 2
	akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, (currentFactionRank + 1))
	debug.trace("Victim seduced fac is now to seduced fac at rank " + (currentFactionRank + 1))
endif

; cooldown handled by ED_HpDrainedTimer av
;FeedDialogue_Cooldown_Spell.Cast(akSpeaker, akSpeaker)
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
