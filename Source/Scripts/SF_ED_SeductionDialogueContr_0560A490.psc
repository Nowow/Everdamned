;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 28
Scriptname SF_ED_SeductionDialogueContr_0560A490 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Feed Dialogue Controller scene ended")
sceneTarget.ClearLookAt()

objectreference packageStartMarker = ED_FeedDialogue_StartLocMarker.GetReference()
ED_FeedDialogue_StartLocMarker.Clear()
packageStartMarker.Disable()
packageStartMarker.Delete()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
debug.Trace("Everdamned DEBUG: Feed Dialogue Controller scene starter")


ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState.SetValue(0)

sceneTarget = ED_FeedDialogue_Target.GetReference() as actor


;playerRef.PlayIdle(ED_Idle_Seduction_PlayerSeqStart)
;

ED_Mechanics_FeedDialogue_CrutchAnimTrigger_Spell.Cast(sceneTarget, sceneTarget)

sceneTarget.SetLookAt(playerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
int cntr

; mega haxx with anim var, see FNIS file

if playerRef.GetAnimationVariableBool("bIdlePlaying") 
	playerRef.PlayIdle(ResetRoot)
endif

while playerRef.GetAnimationVariableBool("bIdlePlaying") &&  cntr <= 30
	playerRef.PlayIdle(ED_Idle_Seduction_PlayerSequenceEnd)
	cntr = cntr + 1
	utility.wait(0.5)
endwhile
debug.Trace("Everdamned DEBUG: Feed Dialogue Controller Scene Phase 1 ENDED, cntr: " + cntr)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
int cntr

; mega haxx with anim var, see FNIS file
while playerRef.GetAnimationVariableBool("bIdlePlaying") &&  cntr <= 30
	playerRef.PlayIdle(ED_Idle_Seduction_PlayerSequenceMainEnd)
	cntr = cntr + 1
	utility.wait(1.0)
endwhile

cntr = 0

while sceneTarget.GetAnimationVariableBool("bIdlePlaying") &&  cntr <= 30
	sceneTarget.PlayIdle(ED_Idle_Seduction_NPCSequenceEnd)
	cntr = cntr + 1
	utility.wait(1.0)
endwhile

SendModEvent("feedDialogue_SocialFeedFinished")

int __walkawayState = ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState.GetValue() as int 

if __walkawayState == 0

	debug.Trace("Everdamned INFO: Seduction Controller Scene determined seduc had walkaway type 0, we havent started actual seduction")
	ED_Mechanics_FeedDialogue_CooldownShort_Spell.Cast(sceneTarget, sceneTarget)
	
	message.ResetHelpMessage("ed_feed_walkaway_short")
	ED_Mechanics_FeedDialogue_Message_Walkaway_OffTheHook.ShowAsHelpMessage("ed_feed_walkaway_short", 6.0, 1.0, 1)

else
	if ED_Mechanics_FeedDialogue_SeductionResult.GetValue() as int == 0
		debug.Trace("Everdamned DEBUG: Seduction Controller Scene determined we TRIED and FAILED")
		
		ED_Mechanics_FeedDialogue_Cooldown3d_Spell.Cast(sceneTarget, sceneTarget)
		
		playerRef.placeatme(ED_Misc_Activator_FeedDialogueFailLines)
	else		
		; we succeded in check
		if __walkawayState == 1
			debug.Trace("Everdamned INFO: Seduction Controller Scene determined seduc had walkaway type 1, we tried seducing and succeded but walked away anyway")
			ED_Mechanics_FeedDialogue_CooldownHalfDay_Spell.Cast(sceneTarget, sceneTarget)
			message.ResetHelpMessage("ed_feed_walkaway_halfday")
			ED_Mechanics_FeedDialogue_Message_Walkaway_Impatience.ShowAsHelpMessage("ed_feed_walkaway_halfday", 6.0, 1.0, 1)
		else ; walkaway type 2
			debug.Trace("Everdamned DEBUG: Seduction Controller Scene determined seduc was successfull and we followed through")
			int currentFactionRank = sceneTarget.GetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac)
			if currentFactionRank < 0
				if sceneTarget.GetRelationshipRank(playerRef) == 0
					;debug.trace("Everdamned INFO: Seduction Controller Scene determined First Time Seduced was an Aquaintance, setting to Friendly")
					;sceneTarget.SetRelationshipRank(playerRef, 1)
				endif
				sceneTarget.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, 0)
				playerRef.placeatme(ED_Misc_Activator_FeedDialogueSuccessLines)
				debug.trace("Everdamned INFO: Seduced is added to seduced fac at rank 0")
			elseif currentFactionRank < 2
				sceneTarget.SetFactionRank(ED_Mechanics_FeedDialogue_Seduced_Fac, (currentFactionRank + 1))
				debug.trace("Everdamned INFO: Seduced is now at seduced fac at rank " + (currentFactionRank + 1))
			endif
		endif
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

GlobalVariable Property ED_Mechanics_FeedDialogue_Global_SeductionWalkawayState  Auto  

Activator Property FXEmptyActivator  Auto  

ReferenceAlias Property ED_FeedDialogue_StartLocMarker  Auto  

SPELL Property ED_Mechanics_FeedDialogue_Cooldown3d_Spell  Auto  

Message Property ED_Mechanics_FeedDialogue_Message_Walkaway_Impatience  Auto   

Message Property ED_Mechanics_FeedDialogue_Message_Walkaway_OffTheHook  Auto  

SPELL Property ED_Mechanics_FeedDialogue_CooldownHalfDay_Spell  Auto  

SPELL Property ED_Mechanics_FeedDialogue_CooldownShort_Spell  Auto  

Idle Property ResetRoot  Auto  

Idle Property ED_Idle_Seduction_PlayerSequenceMainEnd  Auto  

Idle Property ED_Idle_Seduction_NPCSequenceEnd  Auto  

Idle Property ED_Idle_Seduction_PlayerSequenceEnd  Auto  
