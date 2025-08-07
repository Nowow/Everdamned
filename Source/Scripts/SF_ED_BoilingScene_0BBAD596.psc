;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SF_ED_BoilingScene_0BBAD596 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; they must be essential, putting them into essential bleedout state
(BoilingTarget.GetReference() as actor).Kill(playerRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property BoilingTarget  Auto  

Actor Property PlayerRef  Auto  
