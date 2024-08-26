;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__040EA020 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().PlayIdle(ED_Idle_Seduction_OpenEnd)
int _cntr
while _cntr < 20
	if	!(akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect))
		_cntr = 20
	else
		_cntr = _cntr + 1
		utility.wait(0.5)
	endif
endwhile
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Intimidated_Fac, 0)

ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell.Cast(akSpeaker, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Intimidated_Fac  Auto  

SPELL Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell  Auto  

Idle Property ED_Idle_Seduction_OpenEnd  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto  
