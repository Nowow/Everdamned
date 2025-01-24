Scriptname ED_FeedManager_Script extends Quest  

actor property aFeedTarget auto

Event OnInit()
	debug.Trace("Everdamned DEBUG: FeedManager script initialized")
	RegisterFeedEvents()
EndEvent
 
Function RegisterFeedEvents()
	if PlayerIsVampire.value == 1
		debug.Trace("Everdamned DEBUG: RegisterFeedEvents() called for vampire")
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
	debug.Trace("Everdamned DEBUG: Player combat drains target " + FeedTarget)
	
	PlayerRef.StartVampireFeed(FeedTarget)
	
	debug.Trace("Everdamned DEBUG: Feed Manager goes to CombatDrain state")
	GoToState("CombatDrain")
	
endfunction

function FeedManagerCallback(bool checkResult)
	debug.Trace("Everdamned DEBUG: Feed Manager callback was called in Empty state, should not be happening")
endfunction

function HandleDiablerie(actor FeedTarget)
endfunction

function HandleDialogueFeed(actor FeedTarget)
endfunction

state CombatDrain
	event OnBeginState()
		debug.Trace("Everdamned DEBUG: Feed Manager entered CombatDrain state")
	endevent
	event OnEndState()
		debug.Trace("Everdamned DEBUG: Feed Manager exited CombatDrain state")
	endevent

	function FeedManagerCallback(bool checkResult)
		if checkResult
			debug.Trace("Everdamned DEBUG: Feed Manager callback was called in CombatDrain state, feed anim WAS played, proceed")
			
			;TODO: mark target as fed upon, when decided how that should impact feeding
			
			;call for help
			FeedTarget.SendAssaultAlarm()
			
			; for vampire converting sidequest
			if aFeedTarget.IsInFaction(DLC1PotentialVampireFaction) && aFeedTarget.IsInFaction(DLC1PlayerTurnedVampire) == False
				DLC1VampireTurn.PlayerBitesMe(FeedTarget)
			endif
			
			;sfx, maybe should bake into animation?
			ED_Art_Sound_NPCHumanVampireFeed_Marker.Play(aFeedTarget as objectreference)
	
			;adjust status bloodpool etc
			PlayerVampireQuest.VampireFeed()
			
			;psychic vampire check
			ED_Mechanics_PsychicVampire_Spell.Cast(playerRef, aFeedTarget)
			
			;TODO: restore attributes according to VL perk POSSIBLY
			debug.Trace("Everdamned DEBUG NOT IMPLEMENTED: Attribute restore on feed")
			
			;age for 1 day, default amount for regular drain
			ED_Mechanics_Main_Quest.GainAgeExpirience(24.0)
			
			;TODO: Vamp XP
			
			;TODO: Trigger hemomancy advance
			
			;Blue Blood
			ED_Mechanics_BlueBlood_Track_FormList
			actorbase TargetBase = akTarget.GetActorBase()
			Int Index = ED_Mechanics_BlueBlood_Track_FormList.Find(TargetBase as form)
			if Index >= 0
				ED_BlueBlood_Quest.ProcessVIP(TargetBase)
				SCS_Help_StrongBlood.ShowAsHelpMessage("SCS_StrongBloodEvent", 5.00000, 0 as Float, 1)
				SCS_Mechanics_Message_StrongBlood.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
				PlayerRef.AddSpell(SCS_Spell[StrongBloodCounter], true)
				StrongBloodCounter += 1
				SCS_Mechanics_FormList_StrongBlood_Track.RemoveAddedForm(TargetBase as form)
				Int RemainingSize = SCS_Mechanics_FormList_StrongBlood_Track.GetSize()
				if RemainingSize <= SCS_Mechanics_FormList_StrongBlood.GetSize() - SCS_Spell.length
					self.SetStage(200)
				endIf
			endIf
			
			
		else
			debug.Trace("Everdamned DEBUG: Feed Manager callback was called in CombatDrain state, feed anim WAS NOT played, do nothing")
		endif
		GoToState("")
	endfunction
endstate

actor property playerRef auto
Race Property VampireGarkainBeastRace auto
Race Property DLC1VampireBeastRace auto
faction Property DLC1PotentialVampireFaction auto
Faction Property DLC1PlayerTurnedVampire auto	
GlobalVariable Property PlayerIsVampire  Auto
sound property ED_Art_Sound_NPCHumanVampireFeed_Marker auto
formlist property ED_Mechanics_BlueBlood_Track_FormList auto

playerVampireQuestScript property PlayerVampireQuest auto
dlc1vampireturnscript property DLC1VampireTurn auto
ed_mainquest_script property ED_Mechanics_Main_Quest auto
ED_BlueBlood_Quest_Script property ED_BlueBlood_Quest auto
