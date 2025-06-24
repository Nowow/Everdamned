Scriptname ED_ExsanguinateEssentialMsg_Script extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	if Target.HasKeyword(ActorTypeDwarven)
		ED_Mechanics_Message_ExsanguinateImmune.Show()
	else
		ED_Mechanics_Message_ExsanguinateImmune.Show()
	endif
EndEvent

Message property ED_Mechanics_Message_ExsanguinateEssential auto
Message property ED_Mechanics_Message_ExsanguinateImmune auto
keyword property ActorTypeDwarven auto
