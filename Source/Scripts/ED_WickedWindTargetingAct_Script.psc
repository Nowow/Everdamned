Scriptname ED_WickedWindTargetingAct_Script extends ObjectReference  


function OnLoad()
	; create landing target
	
	ED_Mechanics_Quest_WickedWindTargeting.LandingTarget = placeatme(LandingTargetObject, 1, false, true)
	
	
	utility.Wait(0.500000)
	self.Delete()
endFunction

static property LandingTargetObject auto
ED_WickedWindTargetingQuest_Script property ED_Mechanics_Quest_WickedWindTargeting auto
