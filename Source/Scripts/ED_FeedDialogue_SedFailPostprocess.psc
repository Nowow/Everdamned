;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_FeedDialogue_SedFailPostprocess Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
debug.trace("Adding to dialogue Fail faction with rank 0 that means a temporary block for dialogue")
akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Fail_Fac, 0)
ED_Mechanics_FeedDialogue_Cooldown3d_Spell.Cast(akSpeaker, akSpeaker)

int _cntr
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


if playerRef.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Player had Anim Trigger ME")
	playerRef.PlayIdle(ResetRoot)
endif

if akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect)
	debug.trace("Speaker had Anim Trigger ME")
	akSpeaker.PlayIdle(ResetRoot)
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
