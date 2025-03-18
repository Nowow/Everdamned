Scriptname ED_LastStand_ChainedBeast_Script extends activemagiceffect  


playervampirequestscript property PlayerVampireQuest auto

actor property PlayerRef auto
Float property ED_WaitUntilResurrect auto
referencealias property PlayerProtectionPlan auto
sound property ED_RezSound auto
spell property ED_Mechanics_Ab_BeastUnchained_Spell auto
spell property ED_VampirePowers_GarkainBeast_Change auto
message property ED_BeingVampire_Ab_LastStandFrenzy_Message auto
perk property ED_PerkTree_General_40_EmbraceTheBeast_Perk auto

quest property ED_Mechanics_Ab_BeastUnchained_Quest auto

keyword property ED_Mechanics_Keyword_IsInSunlight auto
race property ED_VampireGarkainBeastRace auto
race property DLC1VampireBeastRace auto


function OnEffectStart(actor akTarget, actor akCaster)
	utility.Wait(0.5)
	PlayerProtectionPlan.ForceRefTo(PlayerRef as objectreference)
	debug.Trace("Everdamned DEBUG: Player Protection Plan on")
endFunction

function OnEffectFinish(actor akTarget, actor akCaster)
	PlayerProtectionPlan.Clear()
	debug.Trace("Everdamned DEBUG: Player Protection Plan off")
endFunction


bool __planEngaged
function OnEnterBleedout()
	
	if __planEngaged
		debug.Trace("Everdamned DEBUG: Player Protection Plan ALREADY engaged, return")
		return
	endif
	
	; just for good measure, conditions are already in spell
	race playerRace = playerRef.GetRace()
	bool RaceNotBeast = playerRace != ED_VampireGarkainBeastRace && playerRace != DLC1VampireBeastRace
	bool IsInSunlight = PlayerRef.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_IsInSunlight)
	
	if PlayerProtectionPlan.GetActorRef() == PlayerRef && RaceNotBeast && IsInSunlight
		__planEngaged = true
		debug.Trace("Everdamned DEBUG: Player Protection Plan engaged")
		utility.Wait(ED_WaitUntilResurrect)
		ED_RezSound.Play(PlayerRef)
		
		;SCS_Imod.Apply(1.00000)
		
		PlayerRef.RestoreActorValue("Health", 9999 as Float)
		PlayerVampireQuest.DropToBloodstarved()
		
		if !(PlayerRef.hasperk(ED_PerkTree_General_40_EmbraceTheBeast_Perk))
			debug.Trace("Everdamned DEBUG: Player Protection Plan started Beast Unchained quest")
			ED_Mechanics_Ab_BeastUnchained_Quest.Start()
		endif
		PlayerRef.DispelSpell(ED_Mechanics_Ab_BeastUnchained_Spell)
		__planEngaged = false
	endIf
endFunction

; Skipped compiler generated GetState
 