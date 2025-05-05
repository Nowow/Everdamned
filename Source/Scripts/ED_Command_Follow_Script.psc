;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ED_Command_Follow_Script Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor currentTarget = ED_Target.GetReference() as actor
if currentTarget
	Int i = 0
	while i < ED_Misc_VampiresCommand_SceneControllers_FormList.GetSize()
		currentTarget.DispelSpell(ED_Misc_VampiresCommand_SceneControllers_FormList.GetAt(i) as spell)
		i += 1
	endWhile
endIf
ED_Target.ForceRefTo(akSpeaker)

if akSpeaker.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_Mesmerized)
	ED_Mechanics_Global_MesmerizeShouldFollow.SetValue(1)
else
	ED_Misc_VampiresCommand_SceneController_Follow_Spell.Cast(game.GetPlayer(), akSpeaker)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

referencealias property ED_Target auto
spell property ED_Misc_VampiresCommand_SceneController_Follow_Spell auto
formlist property ED_Misc_VampiresCommand_SceneControllers_FormList auto

Keyword Property ED_Mechanics_Keyword_Mesmerized  Auto  

GlobalVariable Property ED_Mechanics_Global_MesmerizeShouldFollow  Auto  
