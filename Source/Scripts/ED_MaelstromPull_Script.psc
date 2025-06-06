Scriptname ED_MaelstromPull_Script extends activemagiceffect  


referencealias property ED_Maelstrom_Source auto
Float property ED_Speed auto
float property XPgained auto



function OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.TranslatetoRef(ED_Maelstrom_Source.GetReference(), ED_Speed, 0.000000)
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
endFunction
