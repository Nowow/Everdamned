Scriptname ED_FeedDialogue_Lines_Script extends ObjectReference  

bool __fired
function OnLoad()
	if __fired
		debug.Trace("Everdamned DEBUG: Feed Dialogue LINES  OnLoad fired but alread FIRED!")
		return
	endif
	__fired = true
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue LINES activator loaded!")
	
	utility.wait(2.0)
	
	Say(FirstTopic, playerRef, false)
	utility.Wait(FirstTopicLength)
	
	if SecondTopic
		Disable()
		Enable()
		Say(SecondTopic, playerRef, false)
		debug.Trace("Everdamned DEBUG: Feed Dialogue LINES SECOND topic said!")
		utility.Wait(SecondTopicLength)
	endif
	
	Disable()
	Delete()
endFunction

topic property FirstTopic auto
topic property SecondTopic auto
float property FirstTopicLength auto
float property SecondTopicLength auto

actor property playerRef auto
