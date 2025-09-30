Scriptname ED_LordsServantChargeAb_Script extends activemagiceffect  


float property ArmTime = 2.7 auto

string property LeftMagicNode = "NPC L MagicNode [LMag]" auto
string property ReadyEvent = "MLh_SpellReady_event" auto
string property ReleaseEvent = "MLH_SpellRelease_event" auto
string property EquippedEvent = "MLh_Equipped_event" auto
float property VitaeCost = 300.0 auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForAnimationEvent(playerRef, ReadyEvent)
	RegisterForAnimationEvent(playerRef, ReleaseEvent)
	RegisterForAnimationEvent(playerRef, EquippedEvent)
endevent


bool __charging
bool __charged
event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if asEventName == EquippedEvent || ReleaseEvent
		UnregisterForUpdate()
		__charging = false
	elseif asEventName == ReadyEvent
		__charging = true
		RegisterForSingleUpdate(ArmTime)
	endif
	
	debug.Trace("Everdamned DEBUG: Got animevent " + asEventName)
endevent

event OnUpdate()
	
	if __charging
		if ED_Mechanics_Global_UndyingLoyaltyPrimer.GetValue() == 0.0
			if playerRef.GetActorValue("ED_BloodPool") >= VitaeCost
				playerRef.DamageActorValue("ED_BloodPool", VitaeCost) 
				ED_Mechanics_Global_UndyingLoyaltyPrimer.SetValue(1)
				NetImmerse.SetNodeScale(playerRef, LeftMagicNode, 2.0, true)
			else
				ED_Mechanics_Message_NotEnoughBloodPoints.Show()
			endif
		else
			NetImmerse.SetNodeScale(playerRef, LeftMagicNode, 2.0, true)
		endif
		__charging = false
	endif
	
endevent


event OnEffectFinish(Actor akTarget, Actor akCaster)
	utility.wait(0.1)
	NetImmerse.SetNodeScale(playerRef, LeftMagicNode, 1.0, true)
endevent


globalvariable property ED_Mechanics_Global_UndyingLoyaltyPrimer auto
message property ED_Mechanics_Message_NotEnoughBloodPoints auto

actor property playerRef auto
