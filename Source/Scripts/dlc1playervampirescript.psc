;/ Decompiled by Champollion V1.0.1
Source   : DLC1PlayerVampireScript.psc
Modified : 2020-12-09 01:32:01
Compiled : 2020-12-09 01:32:02
User     : maxim
Computer : CANOPUS
/;
scriptName DLC1PlayerVampireScript extends ReferenceAlias

;-- Properties --------------------------------------
message property DLC1BatsReadyMessage auto
race property VampireLordRace auto
message property DLC1BatsWaitMessage auto
Float property SCS_Cooldown auto
spell property DLC1Mistform auto
Int property BatsIndoorMaxUses auto
spell property DLC1VampireBats auto
Int property BatsOutdoorMaxUses auto
Float property BatsCooldown auto
globalvariable property DLC1BatsCount auto
spell property CurrentEquippedPower auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnUpdate()

	self.UnRegisterforUpdate()
	if game.GetPlayer().IsInInterior() == false && DLC1BatsCount.value >= BatsOutdoorMaxUses as Float || game.GetPlayer().IsInInterior() == true && DLC1BatsCount.value >= BatsIndoorMaxUses as Float
		DLC1BatsReadyMessage.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		self.GetActorRef().AddSpell(DLC1VampireBats, false)
		if self.GetActorRef().GetEquippedSpell(2) == none
			self.GetActorRef().EquipSpell(DLC1VampireBats, 2)
		endIf
	endIf
	DLC1BatsCount.value = 0 as Float
endFunction

function OnInit()

	DLC1BatsCount.value = 0 as Float
endFunction

function OnRaceSwitchComplete()

	if self.GetActorReference() == game.GetPlayer()
		game.GetPlayer().GetActorBase().SetInvulnerable(false)
		game.GetPlayer().SetGhost(false)
	endIf
	if self.GetActorReference().GetRace() == VampireLordRace
		debug.Trace("VAMPIRE: Getting notification that race swap TO vampire is complete.", 0)
		(self.GetOwningQuest() as dlc1playervampirechangescript).StartTracking()
	else
		debug.Trace("VAMPIRE: Getting notification that race swap FROM vampire is complete.", 0)
		(self.GetOwningQuest() as dlc1playervampirechangescript).Shutdown()
	endIf
endFunction

function OnSpellCast(Form akSpellCast)

	if akSpellCast == DLC1VampireBats as Form
		if DLC1BatsCount.value == 0 as Float
			self.RegisterForSingleUpdate(SCS_Cooldown)
		endIf
		DLC1BatsCount.value = DLC1BatsCount.value + 1 as Float
		if game.GetPlayer().IsInInterior() == false && DLC1BatsCount.value >= BatsOutdoorMaxUses as Float
			DLC1BatsWaitMessage.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
			self.GetActorRef().RemoveSpell(DLC1VampireBats)
		elseIf game.GetPlayer().IsInInterior() == true && DLC1BatsCount.value >= BatsIndoorMaxUses as Float
			DLC1BatsWaitMessage.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
			self.GetActorRef().RemoveSpell(DLC1VampireBats)
		endIf
	endIf
endFunction

function OnPlayerLoadGame()

	(self.GetOwningQuest() as dlc1playervampirechangescript).HandlePlayerLoadGame()
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState
