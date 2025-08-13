Scriptname ED_StartScene_Script extends activemagiceffect  


scene property ED_Scene auto
keyword property MagicInfluence auto
spell property ED_Mechanics_VampiresCommandImmunity_Spell auto
spell property ED_VampirePowers_Pw_Dominate_Spell_ProjectileVFX auto
visualeffect property ED_Art_VFX_Dominate_CasterPoint auto

actor TheTarget

function OnEffectStart(Actor akTarget, Actor akCaster)
	TheTarget = akTarget
	;ED_VampirePowers_Pw_Dominate_Spell_ProjectileVFX.Cast(playerRef)
	;ED_Art_VFX_Dominate_CasterPoint.Play(playerRef, 5.0)
	ED_Scene.Start()
endFunction

actor property playerRef auto
