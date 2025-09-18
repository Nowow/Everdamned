Scriptname ED_ShowHelpMessage_Script extends activemagiceffect  

Event OnEffectStart(Actor Target, Actor Caster)
	message.ResetHelpMessage(HelpCategoryString)
	MessageToShow.ShowAsHelpMessage(HelpCategoryString, 5.0, 1.0, 1)
endevent

message property MessageToShow auto
string property HelpCategoryString auto
