;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ED_Fragment_Intimidate_Succ1PlusF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int _cntr
while _cntr < 20
	if	!(akSpeaker.HasMagicEffect(ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect))
		_cntr = 20
	else
		_cntr = _cntr + 1
		utility.wait(0.5)
	endif
endwhile
Game.GetPlayer().PlayIdle(ED_Idle_Seduction_PlayfulEnd)
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

Idle Property ED_Idle_Seduction_PlayfulEnd  Auto

SPELL Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Spell  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto  
