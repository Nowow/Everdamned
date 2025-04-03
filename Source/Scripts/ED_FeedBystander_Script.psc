Scriptname ED_FeedBystander_Script extends Quest  

float property NoticeTime auto

GlobalVariable Property DLC1VampireFeedStartTime  Auto  
GlobalVariable Property TimeScale  Auto  

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

 	Debug.Trace("Everdamned DEBUG: Bystander Quest determined someon cares")

	if bystanderCares && DurationInRealTimeSeconds <= NoticeTime
		Debug.Trace("Everdamned DEBUG: And its not too late")
; 	Debug.Trace(self + "CheckBystandersAlarmAndStopQuest calling VictimCrimeFaction.SendAssaultAlarm() because DurationInRealTimeSeconds <= 30")
	   VictimCrimeFaction.SendAssaultAlarm()
	else
		Debug.Trace("Everdamned DEBUG: But its too late!!!")
	endif

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
