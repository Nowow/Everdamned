;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_Seduction_SuccessWalkaway_Script Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ED_Mechanics_FeedDialogue_Cooldown3d_Spell.Cast(akSpeaker, akSpeaker)

debug.Trace("Everdamned INFO: Player successfully seduced target, but was in a hurry and left before dialogue concluded, now target is on cooldown")
playerRef.PlayIdle(ResetRoot)
akSpeaker.PlayIdle(ResetRoot)

ED_Mechanics_FeedDialogue_Message_SuccessWalkaway.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property ED_Mechanics_FeedDialogue_Message_SuccessWalkaway  Auto  

idle property ResetRoot auto

actor property playerRef auto

spell property ED_Mechanics_FeedDialogue_Cooldown3d_Spell auto
