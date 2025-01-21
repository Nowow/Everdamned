Scriptname ED_VampireGarkainBeastChangeEffect extends ActiveMagicEffect  

;======================================================================================;
;               PROPERTIES  /
;=============/

Quest Property ED_PlayerVampireGarkainQuest auto
Spell Property VFXSpell auto
Perk Property DLC1VampireActivationBlocker  Auto  


;======================================================================================;
;               EVENTS                     /
;=============/

Event OnEffectStart(Actor Target, Actor Caster)
; 	Debug.Trace("VAMPIRE: Casting transformation spell on " + Target)

	; set up tracking
	if (Target == Game.GetPlayer())
		Game.DisablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 1)
		;Target.AddPerk(DLC1VampireActivationBlocker)
		ED_PlayerVampireGarkainQuest.Start()
	endif

	VFXSpell.Cast(Target)
EndEvent

