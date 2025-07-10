;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ED_SeductionDialogueContr_0560A490 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Feed Dialogue Controller scene starter")

ED_Mechanics_FeedDialogue_Seduction_WalkawayHappeend.SetValue(0)

sceneTarget = ED_FeedDialogue_Target.GetReference() as actor

playerRef.PlayIdle(ED_Idle_Seduction_PlayerSeqStart)

ED_Mechanics_FeedDialogue_CrutchAnimTrigger_Spell.Cast(sceneTarget, sceneTarget)

sceneTarget.SetLookAt(playerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Feed Dialogue Controller scene ended")
sceneTarget.ClearLookAt()

if ED_Mechanics_FeedDialogue_Seduction_WalkawayHappeend.GetValue() as int != 1

if ED_Mechanics_FeedDialogue_SeductionResult.GetValue() as int == 1
	debug.Trace("Everdamned DEBUG: Seduction Controller Scene determined seduc was successfull")
	int currentFactionRank = sceneTarget.GetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac)
	if currentFactionRank < 0
		sceneTarget.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 0)
		playerRef.placeatme(ED_Misc_Activator_FeedDialogueSuccessLines)
		debug.trace("Everdamned INFO: Seduced is added to seduced fac at rank 0")
	elseif currentFactionRank < 2
		sceneTarget.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, (currentFactionRank + 1))
		debug.trace("Everdamned INFO: Seduced is now at seduced fac at rank " + (currentFactionRank + 1))
	endif

else
	debug.Trace("Everdamned DEBUG: Seduction Controller Scene determined seduc was failed")
	playerRef.placeatme(ED_Misc_Activator_FeedDialogueFailLines)
endif

endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property ED_FeedDialogue_Target  Auto  

actor Property PlayerRef  Auto  

Actor Property sceneTarget  Auto  

Idle Property Chair  Auto  

SPELL Property ED_Mechanics_FeedDialogue_CrutchAnimTrigger_Spell  Auto  

Idle Property ED_Idle_Seduction_PlayerSeqStart  Auto  

GlobalVariable Property ED_Mechanics_FeedDialogue_SeductionResult  Auto  

Activator Property ED_Misc_Activator_FeedDialogueSuccessLines  Auto  

Activator Property ED_Misc_Activator_FeedDialogueFailLines  Auto  

Faction Property ED_Mechanics_FeedDialogue_Seduced_Fac  Auto  

GlobalVariable Property ED_Mechanics_FeedDialogue_Seduction_WalkawayHappeend  Auto  
