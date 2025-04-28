Scriptname ED_DistractionScenesQuest_Script extends Quest  


scene[] property DistractionScenesArray auto

event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, Int aiValue1, Int aiValue2)
	
	debug.Trace("Everdamned DEBUG: Distraction Scenes quest started, target: " + akRef1)
	
	debug.Trace("Everdamned DEBUG: Distraction Scenes target voice type is: " + akRef1.GetVoiceType())
	
	debug.Trace("Everdamned DEBUG: Observer1 is: " + ED_Observer1.GetReference())
	debug.Trace("Everdamned DEBUG: Observer2 is: " + ED_Observer2.GetReference())
	debug.Trace("Everdamned DEBUG: Observer3 is: " + ED_Observer3.GetReference())
	debug.Trace("Everdamned DEBUG: Observer4 is: " + ED_Observer4.GetReference())
	debug.Trace("Everdamned DEBUG: Observer5 is: " + ED_Observer5.GetReference())
	debug.Trace("Everdamned DEBUG: Observer6 is: " + ED_Observer6.GetReference())
	debug.Trace("Everdamned DEBUG: IdleMarker is: " + ED_IdleMarker1.GetReference())
	
	objectreference idlem = ED_IdleMarker1.GetReference()
	objectreference target = akRef1
	idlem.SetAngle(idlem.GetAngleX(), idlem.GetAngleY(), idlem.GetAngleZ() + idlem.GetHeadingAngle(akRef1) + 180)
	
	int SceneNo = aiValue1
	int TotalAvailableScenes = DistractionScenesArray.length
	if SceneNo < 1 || SceneNo > TotalAvailableScenes
		SceneNo = utility.randomint(1, TotalAvailableScenes)
	endif
	
	debug.Trace("Everdamned DEBUG: Distraction Scenes scene No to be played is " + SceneNo)
	
	int SceneIndex = SceneNo - 1 
	DistractionScenesArray[SceneIndex].Start()
	
endevent


ReferenceAlias Property ED_IdleMarker1 Auto

ReferenceAlias Property ED_Target Auto

ReferenceAlias Property ED_Observer5 Auto

ReferenceAlias Property ED_Observer1 Auto

ReferenceAlias Property ED_Observer6 Auto

ReferenceAlias Property ED_Observer4 Auto

ReferenceAlias Property ED_Observer2 Auto

ReferenceAlias Property ED_Observer3 Auto
