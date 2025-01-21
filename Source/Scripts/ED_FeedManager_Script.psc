Scriptname ED_FeedManager_Script extends Quest  

Event OnInit()
	debug.Trace("Everdamned DEBUG: FeedManager script initialized")
	RegisterFeedEvents()
EndEvent
 
Function RegisterFeedEvents()
	if PlayerIsVampire.value == 1
		race playerRace = playerRef.GetRace()
		if (playerRace != VampireGarkainBeastRace) && (playerRace != DLC1VampireBeastRace)
			Debug.Trace("Everdamned INFO: Registred player for feed animation events")
			unRegisterForAnimationEvent(playerRef, "SoundPlay.NPCVampireLordFeed")
			utility.wait(1)
			RegisterForAnimationEvent(playerRef, "SoundPlay.NPCVampireLordFeed")
		endif
	endif
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if asEventName == "SoundPlay.NPCVampireLordFeed"
		PlayerVampireQuest.VampireFeed()
	endif
endevent

function HandleFeed(actor FeedTarget)

	debug.Trace("Everdamned DEBUG: Player feeds on target " + FeedTarget)
	if FeedTarget.IsInFaction(DLC1PotentialVampireFaction) && FeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
		DLC1VampireTurn.PlayerBitesMe(FeedTarget)
	endif
	
	;TODO: mark target as fed upon, when decided how that should impact feeding
	
	PlayerRef.StartVampireFeed(FeedTarget)
	
	
	ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(FeedTarget as objectreference)
	
	PlayerVampireQuest.VampireFeed()
	
	;TODO: psychic vampire check
	
	;?
	FeedTarget.SendAssaultAlarm() ;?
	;PlayerRef.RestoreActorValue("Health", (100 + TargetLevel * 20) as Float)
	;PlayerRef.RestoreActorValue("Magicka", (100 + TargetLevel * 20) as Float)
	;PlayerRef.RestoreActorValue("Stamina", (100 + TargetLevel * 20) as Float)
	
	;TODO: Age, or maybe handle it in BloodPoolManager?
	;TODO: Vamp XP
	
	;TODO: Blue blood and Hemomancy quests
	
endfunction

function HandleDrain(actor FeedTarget)
endfunction

function HandleCombatDrain(actor FeedTarget)
endfunction

function HandleDiablerie(actor FeedTarget)
endfunction

function HandleDialogueFeed(actor FeedTarget)
endfunction

actor property playerRef auto

Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto

faction Property DLC1PotentialVampireFaction auto
Faction Property DLC1PlayerTurnedVampire auto	

GlobalVariable Property PlayerIsVampire  Auto

sound property ED_Art_Sound_NPCHumanVampireFeed_Marker auto

playerVampireQuestScript property PlayerVampireQuest auto
dlc1vampireturnscript property DLC1VampireTurn auto
