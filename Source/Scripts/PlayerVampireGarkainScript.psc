Scriptname PlayerVampireGarkainScript extends ReferenceAlias  

Race Property VampireGarkainBeastRace auto

Event OnRaceSwitchComplete()
	if (GetActorReference().GetRace() == VampireGarkainBeastRace)
 		Debug.Trace("Garkain: Getting notification that race swap TO garkain is complete.")
		(GetOwningQuest() as ED_PlayerVampireGarkainChangeScript).StartTracking()
		GoToState("InVampireBeastForm")
	else
 		Debug.Trace("GARKAIN: Getting notification that race swap FROM garkain is complete.")
		(GetOwningQuest() as ED_PlayerVampireGarkainChangeScript).Shutdown()
		GoToState("")
	endif
EndEvent

state InVampireBeastForm
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		debug.Trace("Everdamned DEBUG: V Beast player alias detected armor equipped")
		
		armor equippedArmor = akBaseObject as armor
		if !equippedArmor
			debug.Trace("Everdamned DEBUG: But it was not armor?")
		endif
		
		bool __validated = ED_SKSEnativebindings.ValidateArmorRace(equippedArmor)
		debug.Trace("Everdamned DEBUG: Race validated: " + __validated)
		if !__validated
			GetActorRef().UnequipItem(equippedArmor)
		endif
	endevent
endstate
