Scriptname ED_FeedDialogue_Lines_Script extends ObjectReference  


function OnLoad()
	
	Say(FirstTopic, playerRef, false)
	utility.Wait(FirstTopicLength)
	
	if SecondTopicLength
		Say(SecondTopic, playerRef, false)
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
