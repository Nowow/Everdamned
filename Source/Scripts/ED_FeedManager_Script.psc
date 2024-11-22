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


actor property playerRef auto

Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto

GlobalVariable Property PlayerIsVampire  Auto

playerVampireQuestScript property PlayerVampireQuest auto
