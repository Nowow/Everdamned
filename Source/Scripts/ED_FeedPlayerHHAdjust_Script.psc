Scriptname ED_FeedPlayerHHAdjust_Script extends activemagiceffect  


Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly
String Property NINODE_ROOT = "NPC" AutoReadOnly
String Property RACEMENUHH_KEY = "RaceMenuHH.esp" AutoReadOnly
String Property INTERNAL_KEY = "internal" AutoReadOnly

Actor effectActor
Bool requirements

float heightDiff
bool fixApplied
bool fixRemoved

bool targetIsFemale
bool playerIsFemale


Bool Function CheckNiOverride()
	Return NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction


Event OnEffectStart(Actor akTarget, Actor akCaster)
	effectActor = akTarget
	requirements = CheckNiOverride()
	
	;utility.wait(1) ; so that paired starts
	FixHeight()

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	RemoveFix()
EndEvent

Function RemoveFix()
	If fixApplied && !fixRemoved
		fixRemoved = true
	
		NiOverride.RemoveNodeTransformPosition(effectActor, False, targetIsFemale, NINODE_ROOT, RACEMENUHH_KEY)
		NiOverride.RemoveNodeTransformPosition(playerRef, False, playerIsFemale, NINODE_ROOT, RACEMENUHH_KEY)
		NiOverride.UpdateNodeTransform(effectActor, False, targetIsFemale, NINODE_ROOT)
		NiOverride.UpdateNodeTransform(playerRef, False, playerIsFemale, NINODE_ROOT)
	EndIf
EndFunction

Function FixHeight()
	If requirements && !fixApplied

		targetIsFemale = effectActor.GetLeveledActorBase().GetSex()
		playerIsFemale = Player.GetSex()
		
		bool targetHasTransform = NiOverride.HasNodeTransformPosition(effectActor, False, targetIsFemale, NINODE_ROOT, INTERNAL_KEY)
		bool playerHasTransform = NiOverride.HasNodeTransformPosition(playerRef, False, playerIsFemale, NINODE_ROOT, INTERNAL_KEY)
		
		if !targetHasTransform && !playerHasTransform
			return
		endif
		
		if fixApplied
			return
		endif
		
		fixApplied = True
				
		Float[] targetPos = NiOverride.GetNodeTransformPosition(effectActor, False, targetIsFemale, NINODE_ROOT, INTERNAL_KEY)
		targetPos[0] = -targetPos[0]
		targetPos[1] = -targetPos[1]
		targetPos[2] = -targetPos[2]
				
		Float[] playerPos = NiOverride.GetNodeTransformPosition(playerRef, False, playerIsFemale, NINODE_ROOT, INTERNAL_KEY)
		playerPos[0] = -playerPos[0]
		playerPos[1] = -playerPos[1]
		playerPos[2] = -playerPos[2]
			
		NiOverride.AddNodeTransformPosition(effectActor, False, targetIsFemale, NINODE_ROOT, RACEMENUHH_KEY, targetPos)
		NiOverride.AddNodeTransformPosition(playerRef, False, playerIsFemale, NINODE_ROOT, RACEMENUHH_KEY, playerPos)
		NiOverride.UpdateNodeTransform(effectActor, False, targetIsFemale, NINODE_ROOT)
		NiOverride.UpdateNodeTransform(playerRef, False, playerIsFemale, NINODE_ROOT)
		
	
	EndIf
EndFunction


actor property playerRef Auto
actorbase property Player auto
