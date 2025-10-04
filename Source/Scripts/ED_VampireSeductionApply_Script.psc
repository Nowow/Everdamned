Scriptname ED_VampireSeductionApply_Script extends activemagiceffect  

; because a lot of things are dependent on vanilla Vampire Seduction magic effects
; but they are not Target Actor and a world of pain to cast from papyrus
Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget.GetActorBase() != DLC1Dexion \
	   && akTarget.GetLevel() > ED_Mechanics_SkillTree_Level_Global.GetValue()
		
		debug.Notification(akTarget.GetActorBase().GetName() + " is too powerful for Vampire's Seduction.")
		self.Dispel()
		return
	endif

	ED_Art_VFX_VampiresSeduction_CasterPoint.Play(akCaster, 5.0)
	playerRef.DoCombatSpellApply(ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell, akTarget)
	
	CustomSkills.AdvanceSkill("EverdamnedMain", 200.0)
	
	self.Dispel()
endevent

actor property playerRef auto
spell property ED_VampirePowers_Vanilla_Pw_VampiresSeductionTA_Spell auto
visualeffect property ED_Art_VFX_VampiresSeduction_CasterPoint auto
globalvariable property ED_Mechanics_SkillTree_Level_Global auto
actorbase property DLC1Dexion auto