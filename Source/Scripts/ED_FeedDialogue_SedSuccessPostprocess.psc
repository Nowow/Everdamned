;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_FeedDialogue_SedSuccessPostprocess Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int _cntr
ED_FeedDialogue_Target.ForceRefTo(akSpeaker)
ED_MesmerizeSafe_Scene_FeedDialogue.Start()

actor PlayerRef = Game.GetPlayer()
while _cntr < 20
	if !(akSpeakerRef.IsInDialogueWithPlayer())	|| !(akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect))
		_cntr = 20
	else
		_cntr = _cntr + 1
		utility.wait(0.5)
	endif
endwhile
PlayerRef.PlayIdle(ED_Idle_Seduction_PlayfulEnd)

if !(akSpeakerRef.IsInDialogueWithPlayer())
	return
endif

ED_Mechanics_FeedDialogue_FeedExpression_Spell.Cast(akSpeakerRef, akSpeakerRef)
ED_Mechanics_FeedDialogue_HeartPalpitations_Imod.Apply()
ED_Mechanics_FeedDialogue_HeartPalpitations_SoundM.Play(akSpeakerRef)
utility.wait(2)
ED_Mechanics_FeedDialogue_BreathFemale_SoundM.Play(akSpeakerRef)
utility.wait(1)
if akSpeaker.IsInFaction(DLC1PotentialVampireFaction) && akSpeaker.IsInFaction(DLC1PlayerTurnedVampire) == False
	DLC1VampireTurn.PlayerBitesMe(akSpeaker)
endif

if playerRef.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Player had Anim Trigger ME")
	playerRef.PlayIdle(ResetRoot)
endif

if akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Speaker had Anim Trigger ME")
	akSpeaker.PlayIdle(ResetRoot)
endif
playerRef.PlayIdleWithTarget(FeedDialogueIdle, akSpeaker)

int currentFactionRank = akSpeaker.GetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac)
if currentFactionRank < 0
	akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 0)
	debug.trace("Victim seduced fac is now to seduced fac at rank 0")
elseif currentFactionRank < 2
	akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, (currentFactionRank + 1))
	debug.trace("Victim seduced fac is now to seduced fac at rank " + (currentFactionRank + 1))
endif
PlayerVampireQuest.VampireFeed()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

SPELL Property ED_VampireAbilities_Seduction_VictimVFX_Spell  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto

Idle Property ED_Idle_Seduction_PlayfulEnd  Auto  

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

Scene Property ED_MesmerizeSafe_Scene_FeedDialogue  Auto  

ReferenceAlias Property ED_FeedDialogue_Target  Auto  
