Scriptname ED_LordsServant_Command_Script extends activemagiceffect  

Faction Property CharmFaction Auto
bool Property bMakePlayerTeammate = false Auto
spell property ED_VampireSpellsVL_LordsServant_Spell auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	; cheeky innit
	; to give previous effect time to dispel if recasting, and also for flavor
	utility.wait(0.5)
	
	actor currentRef = CommandedRef.GetReference() as Actor
	CommandedRef.ForceRefTo(akTarget)
	if currentRef != none
		debug.Trace("Everdamned INFO: Lord's Servant Command effect applied while command reference still filled, dispelling")
		currentRef.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell)
	endif
	akTarget.AddToFaction(CharmFaction)
	akCaster.StopCombat()
	akTarget.StopCombat()
	if bMakePlayerTeammate
		akTarget.SetPlayerTeammate(true, false)
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if CommandedRef.GetReference() == akTarget as objectreference
		CommandedRef.Clear()
	endif
	akTarget.RemoveFromFaction(CharmFaction)
	if bMakePlayerTeammate
		akTarget.SetPlayerTeammate(false, false)
	endif
EndEvent


ReferenceAlias Property CommandedRef  Auto  
