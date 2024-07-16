;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname PRKF__04086FAB Extends Perk Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
ED_Mechanics_GarkainBeast_FeedOnCorpse.Cast(akActor as Actor, akActor as Actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property ED_PlayerVampireGarkainQuest  Auto  

SPELL Property ED_Mechanics_GarkainBeast_FeedOnCorpse  Auto  
