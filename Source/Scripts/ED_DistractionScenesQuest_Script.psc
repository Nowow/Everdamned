Scriptname ED_DistractionScenesQuest_Script extends Quest  


scene[] property DistractionScenesArray auto
actorbase[] property PropHauntersChoiceArray auto

event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, Int aiValue1, Int aiValue2)
	
	debug.Trace("Everdamned DEBUG: Distraction Scenes quest started")
	
	ObjectReference ScenePrimaryTarget = ED_Target.GetReference()
	
	if !ScenePrimaryTarget
		debug.Trace("Everdamned ERROR: Distraction Scenes primary target reference is null, bailing")
		stop()
		return
	endif
	
	
	;debug.Trace("Everdamned DEBUG: Distraction Scenes target voice type is: " + akRef1.GetVoiceType())
	
	debug.Trace("Everdamned DEBUG: Observer1 is: " + ED_Observer1.GetReference())
	debug.Trace("Everdamned DEBUG: Observer2 is: " + ED_Observer2.GetReference())
	debug.Trace("Everdamned DEBUG: Observer3 is: " + ED_Observer3.GetReference())
	debug.Trace("Everdamned DEBUG: Observer4 is: " + ED_Observer4.GetReference())
	debug.Trace("Everdamned DEBUG: Observer5 is: " + ED_Observer5.GetReference())
	debug.Trace("Everdamned DEBUG: Observer6 is: " + ED_Observer6.GetReference())
	
	
	int SceneNo = aiValue1
	int TotalAvailableScenes = DistractionScenesArray.length
	if !SceneNo || SceneNo < 1 || SceneNo > TotalAvailableScenes
		SceneNo = utility.randomint(1, TotalAvailableScenes)
		debug.Trace("Everdamned DEBUG: Distraction Scenes quest was not provided with scene No, random: " + SceneNo)
	else
		debug.Trace("Everdamned DEBUG: Distraction Scenes provided scene No to be played is " + SceneNo)
	endif
	
	; 1 - Wounded
	; 2 - Haunted by Illusion
	
	if SceneNo == 2
	
		int WhichHaunter = utility.randomint(1, PropHauntersChoiceArray.length)
		actorbase PropHaunterBase = PropHauntersChoiceArray[WhichHaunter]
		actor PropHaunterActor = ScenePrimaryTarget.PlaceAtMe(PropHaunterBase) as actor
		
		; ref should be empty because quest is just scene and is stop starting
		ED_PropHaunter.ForceRefTo(PropHaunterActor)
		
	endif
	
	int SceneIndex = SceneNo - 1 
	
	DistractionScenesArray[SceneIndex].Start()
	
	; TODO:
	; make scenes check for VampiresWill keyword
	
endevent



ReferenceAlias Property ED_Target Auto

ReferenceAlias Property ED_Observer5 Auto

ReferenceAlias Property ED_Observer1 Auto

ReferenceAlias Property ED_Observer6 Auto

ReferenceAlias Property ED_Observer4 Auto

ReferenceAlias Property ED_Observer2 Auto

ReferenceAlias Property ED_Observer3 Auto

ReferenceAlias Property ED_PropHaunter Auto
