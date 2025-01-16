Scriptname ED_Gutwrench_Script extends ActiveMagicEffect  



;globalvariable property DLC1VampireNextPerk auto
;globalvariable property DLC1VampireBloodPoints auto
;globalvariable property DLC1VampireTotalPerksEarned auto
;globalvariable property DLC1VampirePerkPoints auto
;globalvariable property DLC1VampireMaxPerks auto
;globalvariable property SCS_VampireSpells_VampireLord_Global_XP_Gutwrench_Base auto
;globalvariable property SCS_VampireSpells_VampireLord_Global_XP_Gutwrench_Level auto

globalvariable property ED_Mechanics_Global_Gutwrench_HealthPerSecond auto
explosion property ED_Art_Explosion_Gutwrench auto
activator property AshPileObject auto

;message property DLC1BloodPointsMsg auto
;message property DLC1VampirePerkEarned auto

formlist property ProhibitedCreatures auto



;keyword property SCS_Raze auto
;explosion property SCS_ForceExplosion auto
;hazard property SCS_Blood_Hazard_Bones auto


Actor TheCaster
Actor TheTarget
int _healthThresholdSetting
Int HealthThreshold = 0


function OnUpdate()

	HealthThreshold += _healthThresholdSetting
	if HealthThreshold as Float > TheTarget.GetActorValue("Health") && !TheTarget.IsEssential()
		self.UnregisterForUpdate()
		;Bool IsRaze = TheTarget.HasEffectKeyword(SCS_Raze)
		TheTarget.Kill(TheCaster)
		TheTarget.PlaceAtMe(ED_Art_Explosion_Gutwrench as form, 1, false, false)
		TheTarget.AttachAshPile(AshPileObject as form)
		TheTarget.SetAlpha(0.000000, true)
		TheTarget.SetCriticalStage(TheTarget.CritStage_DisintegrateEnd)
		self.Dispel()
		;if !IsRaze
		;	Float XPGranted = SCS_VampireSpells_VampireLord_Global_XP_Gutwrench_Base.GetValue() + TheTarget.GetLevel() as Float * SCS_VampireSpells_VampireLord_Global_XP_Gutwrench_Level.GetValue()
		;	game.AdvanceSkill("Destruction", XPGranted)
		;endIf
		;utility.Wait(0.500000)
		; if !TheTarget.IsCommandedActor() && !TheTarget.IsGhost() && TheCaster == game.GetPlayer()
		;	DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value + 1 as Float
		;	if DLC1VampireTotalPerksEarned.value < DLC1VampireMaxPerks.value
		;		DLC1BloodPointsMsg.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		;		if DLC1VampireBloodPoints.value >= DLC1VampireNextPerk.value
		;			DLC1VampireBloodPoints.value = DLC1VampireBloodPoints.value - DLC1VampireNextPerk.value
		;			DLC1VampirePerkPoints.value = DLC1VampirePerkPoints.value + 1 as Float
		;			DLC1VampireTotalPerksEarned.value = DLC1VampireTotalPerksEarned.value + 1 as Float
		;			DLC1VampireNextPerk.value = DLC1VampireNextPerk.value + 1 as Float
		;			DLC1VampirePerkEarned.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		;		endIf
		;	endIf
		;	TheCaster.SetActorValue("VampirePerks", DLC1VampireBloodPoints.value / DLC1VampireNextPerk.value * 100 as Float)
		;endIf
	endIf
endFunction

; Skipped compiler generated GetState

function OnEffectStart(Actor akTarget, Actor akCaster)
	_healthThresholdSetting = ED_Mechanics_Global_Gutwrench_HealthPerSecond.GetValue() as Int
	if !akTarget.IsDead()
		TheTarget = akTarget
		TheCaster = akCaster
		self.RegisterForUpdate(1.00000)
	else
		self.Dispel()
	endIf
endFunction
