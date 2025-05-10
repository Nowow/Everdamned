Scriptname ED_WWTargetAdjust_Script extends ObjectReference  


function OnLoad()
	; adjust landing target
	
	ED_Mechanics_Quest_WickedWindTargeting.LandingTarget.TranslateToRef(self, 5500.0)

	utility.Wait(0.15)
	self.Delete()
endFunction

ED_WickedWindTargetingQuest_Script property ED_Mechanics_Quest_WickedWindTargeting auto
