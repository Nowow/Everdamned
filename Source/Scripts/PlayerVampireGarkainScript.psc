Scriptname PlayerVampireGarkainScript extends ReferenceAlias  

Race Property VampireGarkainBeastRace auto

Event OnRaceSwitchComplete()
	if (GetActorReference().GetRace() == VampireGarkainBeastRace)
 		Debug.Trace("Garkain: Getting notification that race swap TO garkain is complete.")
		(GetOwningQuest() as ED_PlayerVampireGarkainChangeScript).StartTracking()
	else
 		Debug.Trace("GARKAIN: Getting notification that race swap FROM garkain is complete.")
		(GetOwningQuest() as ED_PlayerVampireGarkainChangeScript).Shutdown()
	endif
EndEvent
