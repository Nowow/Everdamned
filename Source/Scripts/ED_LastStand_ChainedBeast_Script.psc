Scriptname ED_LastStand_ChainedBeast_Script extends activemagiceffect  

;-- Properties --------------------------------------
playervampirequestscript property PlayerVampireQuest auto

actor property PlayerRef auto
Float property ED_WaitUntilResurrect auto
referencealias property PlayerProtectionPlan auto
sound property ED_RezSound auto
spell property ED_BeingVampire_Ab_LastStandFrenzy_Spell auto
message property ED_BeingVampire_Ab_LastStandFrenzy_Message auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnEffectStart(actor akTarget, actor akCaster)

	utility.Wait(1.00000)
	PlayerProtectionPlan.ForceRefTo(PlayerRef as objectreference)
endFunction

function OnEffectFinish(actor akTarget, actor akCaster)

	PlayerProtectionPlan.Clear()
endFunction

; Skipped compiler generated GotoState

function OnEnterBleedout()

	if PlayerProtectionPlan.GetActorRef() == PlayerRef
		utility.Wait(ED_WaitUntilResurrect)
		PlayerRef.RestoreActorValue("Health", 9999 as Float)
		ED_RezSound.Play(PlayerRef)
		ED_BeingVampire_Ab_LastStandFrenzy_Message.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		;SCS_Imod.Apply(1.00000)
		PlayerVampireQuest.VampireStatus = 4
		PlayerVampireQuest.VampireProgression(PlayerRef, 4)
		
		PlayerRef.DispelSpell(ED_BeingVampire_Ab_LastStandFrenzy_Spell)
	endIf
endFunction

; Skipped compiler generated GetState
