;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname PRKF__04086FAB Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(ED_PlayerVampireGarkainQuest as ED_PlayerVampireGarkainChangeScript).Feed(akTargetRef as Actor)
debug.trace("FEEEEED FROM FRAGMENT!")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property ED_PlayerVampireGarkainQuest  Auto  
