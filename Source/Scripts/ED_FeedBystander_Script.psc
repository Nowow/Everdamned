Scriptname ED_FeedBystander_Script extends Quest  

float property NoticeTime auto

GlobalVariable Property DLC1VampireFeedStartTime  Auto  
GlobalVariable Property TimeScale Auto

message property ED_Mechanics_Message_BystanderNotAlerted auto
message property ED_Mechanics_Message_BystanderAlerted auto

referencealias Property Victim auto

referencealias[] Property BystanderAliasArray auto

Function CheckBystandersSendAlarmAndStopQuest()
 	Debug.Trace("Everdamned DEBUG: Bystander Quest and check started")

	Float StartTime = DLC1VampireFeedStartTime.GetValue()
	Float Now = utility.GetCurrentGameTime()
	Float Duration = Now - StartTime

	Float DurationInRealTimeSeconds = Duration/(24*60*60) * TimeScale.GetValue()
	Debug.Trace("Everdamned DEBUG: Bystander Quest started after " + DurationInRealTimeSeconds + " seconds")
	
	Actor VictimRef = Victim.GetReference() as actor
	Faction VictimCrimeFaction = VictimRef.GetCrimeFaction()
	
	Debug.Trace("Everdamned DEBUG: Bystander Quest Victim crime faction: " + VictimCrimeFaction)

	bool BystanderCares = CheckBystanders()
	
	message __displayMessage = ED_Mechanics_Message_BystanderNotAlerted
	
	utility.wait(4.0)

	if bystanderCares 
		if DurationInRealTimeSeconds <= NoticeTime
			Debug.Trace("Everdamned INFO: And its not too late")
			__displayMessage = ED_Mechanics_Message_BystanderAlerted
			VictimCrimeFaction.SendAssaultAlarm()
		else
			Debug.Trace("Everdamned INFO: But its too late!!! HA-HAA!")
		endif
	else
		Debug.Trace("Everdamned INFO: No Bystander cares about what the player is doing right now")
	endif

	__displayMessage.Show()
	
	stop()

EndFunction

bool Function CheckBystanders()

	actor currentActor
	int i = 0
	while (i < BystanderAliasArray.length)
	
		currentActor = BystanderAliasArray[i].GetReference() as actor
		
		if currentActor

 			Debug.Trace("Everdamned DEBUG: Bystander Quest alias num " + i + " was filled with " + currentActor)

			bool detected = playerRef.IsDetectedBy(currentActor)
			utility.wait(0.25) ;first time checking detection between non-hostiles doesn't work
			detected = playerRef.IsDetectedBy(currentActor)

			bool theyHaveLos = currentActor.HasLOS(playerRef)
			bool areConcious = !(currentActor.IsUnconscious())
			Debug.Trace("Everdamned DEBUG: They detect: " + detected + ", they have los: " + theyHaveLos + ", concious: " + areConcious)
			
			if detected && theyHaveLos && areConcious
				Debug.Trace("Everdamned INFO: Bystander Quest determined someon cares")
				RETURN True
			endif

		else
; 			Debug.Trace(self + "CheckBystanders() only have empty aliases left, RETURNING FALSE")
			RETURN FALSE

		endif

		i += 1
	endwhile

	RETURN False

EndFunction

actor property playerRef auto
