;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_ED_Mechanics_Quest_BloodE_0608AE8D Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.trace("Everdamned INFO: Blood Extractor aquired!")
ED_Mechanics_Global_BloodExtractorAquired.SetValue(1.0)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property ED_Mechanics_Global_BloodExtractorAquired  Auto  
