Scriptname ED_ExsanguinateEssentialMsg_Script extends activemagiceffect  


Event OnEffectStart(Actor Target, Actor Caster)
	ED_TEST_ExsanguinateEssential_Message.Show()
EndEvent

Message property ED_TEST_ExsanguinateEssential_Message auto
