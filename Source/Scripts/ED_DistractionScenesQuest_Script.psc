Scriptname ED_DistractionScenesQuest_Script extends Quest  


scene[] property DistractionScenesArray auto
actorbase[] property PropHauntersChoiceArray auto


event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, Int aiValue1, Int aiValue2)
	
	debug.Trace("Everdamned DEBUG: Distraction Scenes quest started")
	
	actor ScenePrimaryTarget = ED_Target.GetReference() as actor
	
	if !ScenePrimaryTarget
		debug.Trace("Everdamned ERROR: Distraction Scenes primary target reference is null, bailing")
		stop()
		return
	endif
	
	debug.Trace("Everdamned DEBUG: Observer1 is: " + ED_Observer1.GetReference())
	debug.Trace("Everdamned DEBUG: Observer2 is: " + ED_Observer2.GetReference())
	debug.Trace("Everdamned DEBUG: Observer3 is: " + ED_Observer3.GetReference())
	debug.Trace("Everdamned DEBUG: Observer4 is: " + ED_Observer4.GetReference())
	debug.Trace("Everdamned DEBUG: Observer5 is: " + ED_Observer5.GetReference())
	debug.Trace("Everdamned DEBUG: Observer6 is: " + ED_Observer6.GetReference())
	
	
	int SceneNo = aiValue1
	int TotalAvailableScenes = DistractionScenesArray.length
	
	bool useHearingThingsScene = ScenePrimaryTarget.GetFactionReaction(playerRef) == 1 || \
									 ScenePrimaryTarget.IsHostileToActor(playerRef)
	bool SoloPerformance = ED_Observer1.GetReference() == None
	
	if useHearingThingsScene && SoloPerformance
	
		debug.Trace("Everdamned DEBUG: Distraction Scenes are called on solo hostile target, overriding to Hearing Things scene")
		SceneNo = 3
	
	elseif !SceneNo || SceneNo < 1 || SceneNo > TotalAvailableScenes
		
		; not using Hearing Things scene because non hostiles do not care about Throw Voice
		; maybe has something to do with aggro behavior radius instead?
		if !useHearingThingsScene
			debug.Trace("Everdamned DEBUG: Distraction Scenes will not use Hearing Things scene " + SceneNo)
			TotalAvailableScenes -= 1
		endif
		SceneNo = utility.randomint(1, TotalAvailableScenes)
		debug.Trace("Everdamned DEBUG: Distraction Scenes quest was not provided with scene No, random: " + SceneNo)
	else
		debug.Trace("Everdamned DEBUG: Distraction Scenes provided scene No to be played is " + SceneNo)
	endif
	
	; 1 - Wounded
	; 2 - Dance Naked
	; 3 - Hearing Things - conditional
	; unfinished: Haunted by Illusion
	
	;if SceneNo == 4
	
		;int WhichHaunter = utility.randomint(1, PropHauntersChoiceArray.length) - 1
		;actorbase PropHaunterBase = PropHauntersChoiceArray[WhichHaunter]
		;actor PropHaunterActor = ScenePrimaryTarget.PlaceAtMe(PropHaunterBase) as actor
		;PropHaunterActor.SetScale(0.4)
		
		; ref should be empty because quest is just scene and is stop starting
		; ref ability controls deleting actor
		;ED_PropHaunter.ForceRefTo(PropHaunterActor)
		
		; sluggish running from nightmare
		;ED_HauntedMovSlow.ForceRefTo(ScenePrimaryTarget)
		
	if SceneNo == 3
		
		;This function is unreliable the first time it is called 
		;calling here to make it reliable :)
		ScenePrimaryTarget.GetCombatState()
		
		ED_HearingThings.ForceRefTo(ScenePrimaryTarget)
	endif
	
	int SceneIndex = SceneNo - 1 
	
	DistractionScenesArray[SceneIndex].Start()

endevent


actor property playerRef auto

ReferenceAlias Property ED_Target Auto

ReferenceAlias Property ED_Observer5 Auto

ReferenceAlias Property ED_Observer1 Auto

ReferenceAlias Property ED_Observer6 Auto

ReferenceAlias Property ED_Observer4 Auto

ReferenceAlias Property ED_Observer2 Auto

ReferenceAlias Property ED_Observer3 Auto

ReferenceAlias Property ED_PropHaunter Auto
ReferenceAlias Property ED_HauntedMovSlow Auto
ReferenceAlias Property ED_HearingThings Auto
