Scriptname ED_LordsServantChargeAb_Script extends activemagiceffect  


float property ArmTime = 2.7 auto

string property LeftMagicNode = "NPC L MagicNode [LMag]" auto
;string property ReadyEvent = "MLh_SpellReady_event" auto
;string property ReleaseEvent = "MLH_SpellRelease_event" auto
;string property EquippedEvent = "MLh_Equipped_event" auto
float property VitaeCost = 300.0 auto

float __realCost
bool __finished
event OnEffectStart(Actor akTarget, Actor akCaster)
	;RegisterForAnimationEvent(playerRef, ReadyEvent)
	;RegisterForAnimationEvent(playerRef, ReleaseEvent)
	;RegisterForAnimationEvent(playerRef, EquippedEvent)
	
	if ED_Mechanics_Global_UndyingLoyaltyPrimer.GetValue() == 1.0
		ED_Art_VFX_LordsServantCharged.Play(playerRef)
	endif
	
	debug.Trace("Everdamned DEBUG: Charge Ab started")
	if playerRef.HasPerk(ED_PerkTreeVL_UnearthlyWill_Perk)
		__realCost = VitaeCost / 2.0
	else
		__realCost = VitaeCost
	endif
	
	RegisterForSingleUpdate(ArmTime)
endevent

event OnUpdate()
	if __finished
		return
	endif
	if ED_Mechanics_Global_UndyingLoyaltyPrimer.GetValue() == 0.0
		if playerRef.GetActorValue("ED_BloodPool") >= __realCost
			playerRef.DamageActorValue("ED_BloodPool", __realCost) 
			ED_Mechanics_Global_UndyingLoyaltyPrimer.SetValue(1)
			ED_Art_VFX_LordsServantCharged.Play(playerRef)
			ED_Art_SoundM_LordsServantCharged.Play(playerRef)
		else
			ED_Mechanics_Message_NotEnoughBloodPoints.Show()
		endif
	else
		ED_Art_VFX_LordsServantCharged.Play(playerRef)
	endif
endevent


event OnEffectFinish(Actor akTarget, Actor akCaster)
	__finished = true
	debug.Trace("Everdamned DEBUG: Charge Ab finished")
	ED_Art_VFX_LordsServantCharged.Stop(playerRef)
	
endevent


globalvariable property ED_Mechanics_Global_UndyingLoyaltyPrimer auto
message property ED_Mechanics_Message_NotEnoughBloodPoints auto
perk property ED_PerkTreeVL_UnearthlyWill_Perk auto
visualeffect property ED_Art_VFX_LordsServantCharged auto
sound property ED_Art_SoundM_LordsServantCharged auto

actor property playerRef auto
