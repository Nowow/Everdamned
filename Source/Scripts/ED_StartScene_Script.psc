Scriptname ED_StartScene_Script extends activemagiceffect  


scene property ED_Scene auto
spell property ControllerSpell auto

keyword property MagicInfluence auto
spell property ED_Mechanics_VampiresCommandImmunity_Spell auto
spell property ED_VampirePowers_Pw_Dominate_Spell_ProjectileVFX auto
visualeffect property ED_Art_VFX_Dominate_CasterPoint auto

magiceffect property ED_VampirePowers_Pw_Dominate_Effect auto

actor TheTarget

function OnEffectStart(Actor akTarget, Actor akCaster)
	TheTarget = akTarget
	;ED_VampirePowers_Pw_Dominate_Spell_ProjectileVFX.Cast(playerRef)
	;ED_Art_VFX_Dominate_CasterPoint.Play(playerRef, 5.0)
	ED_Scene.Start()
	
	;failsafe. should have done the whole thing as a quest tho
	utility.wait(0.5)
	if !(playerRef.HasMagicEffect(ED_VampirePowers_Pw_Dominate_Effect))
		TheTarget.DispelSpell(ControllerSpell)
	endif
		
endFunction

actor property playerRef auto
