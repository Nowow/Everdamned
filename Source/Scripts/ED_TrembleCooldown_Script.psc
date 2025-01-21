Scriptname ED_TrembleCooldown_Script extends referencealias

String property LandStart = "LandStart" auto
int property ED_TrembleMaxUses auto
float property ED_TrembleCooldown auto

perk property ED_PerkTreeVL_Tremble_Perk auto
spell property ED_VampirePowersVL_Ab_Tremble_Cast_Spell auto
race property DLC1VampireBeastRace auto
actor property casterRef auto
globalvariable property ED_Mechanics_Global_TrembleCount auto
message property ED_Mechanics_Message_Tremble_Ready auto


Event OnInit()
	;Debug.Trace("Everdamned DEBUG: Tremble Cooldown alias script initiated")
	ED_Mechanics_Global_TrembleCount.value = 0.0
endevent

Event OnPlayerLoadGame()
	Debug.Trace("Everdamned INFO: Tremble Cooldown alias script OnPlayerLoadGame() called ")
	self.RegisterForAnimationEvent(casterRef, LandStart)
	if casterRef.GetRace() == DLC1VampireBeastRace
		Debug.Trace("Everdamned DEBUG: detected race after load was Vampire Lord")
		self.RegisterForAnimationEvent(casterRef, LandStart)
	endif
EndEvent

Event OnRaceSwitchComplete()
 	Debug.Trace("Everdamned INFO: Tremble Cooldown alias script OnRaceSwitchComplete() called ")
	if casterRef.GetRace() == DLC1VampireBeastRace
		Debug.Trace("Everdamned DEBUG: detected race after race switch was Vampire Lord")
		self.RegisterForAnimationEvent(casterRef, LandStart)
	endif
EndEvent

function OnAnimationEvent(objectreference akActor, String akEventName)

	debug.Trace("Everdamned DEBUG: Tremble Cooldown alias script caught animevent")
	debug.Trace(akEventName)
	debug.Trace(casterRef.hasperk(ED_PerkTreeVL_Tremble_Perk))
	
	;This function is unreliable the first time it is called after a certain amount of time has passed
	casterRef.GetCombatState()
	; has perk, in combat and weapons drawn
	if akEventName == LandStart && casterRef.hasperk(ED_PerkTreeVL_Tremble_Perk) && casterRef.IsWeaponDrawn() && casterRef.GetCombatState() != 0
		if ED_Mechanics_Global_TrembleCount.value < ED_TrembleMaxUses as Float
			utility.wait(0.1)
			ED_VampirePowersVL_Ab_Tremble_Cast_Spell.Cast(casterRef, casterRef)
		endIf
		if ED_Mechanics_Global_TrembleCount.value == 0.0
			self.RegisterForSingleUpdate(ED_TrembleCooldown)
		endIf
		ED_Mechanics_Global_TrembleCount.Mod(1.0)
	endif
	
endfunction

event OnUpdate()
	self.UnRegisterforUpdate()
	if ED_Mechanics_Global_TrembleCount.value >= ED_TrembleMaxUses as Float
		ED_Mechanics_Message_Tremble_Ready.Show()
	endIf
	ED_Mechanics_Global_TrembleCount.value = 0 as Float
endevent

