;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_FeedDialogue_SedFailPostprocess Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_Mechanics_FeedDialogue_Cooldown3d_Spell.Cast(akSpeaker, akSpeaker)

actor PlayerRef = Game.GetPlayer()

if !(akSpeakerRef.IsInDialogueWithPlayer())
	debug.Trace("Everdamned: Player failed seduction check and left dialogue, calling ResetRoot for him")
	playerRef.PlayIdle(ResetRoot)
	;akSpeaker.PlayIdle(ResetRoot)
	return
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Fail_Fac Auto 

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto

Spell Property ED_Mechanics_FeedDialogue_Cooldown3d_Spell Auto

Idle Property ED_Idle_Seduction_PlayfulEnd  Auto  

Idle Property ResetRoot  Auto 
