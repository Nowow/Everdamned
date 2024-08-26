;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ED_FragmentSeduce_Succ2Female Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
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
akSpeaker.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 1)
debug.notification("Victim added to seduced fac")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

MagicEffect Property ED_Mechanics_FeedDialogue_AnimFinishTrigger_Effect  Auto

Idle Property ED_Idle_Seduction_PlayfulEnd  Auto  
