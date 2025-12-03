Scriptname ED_ProfanedSun_Script extends activemagiceffect  

float property XPgained auto

ObjectReference TheSun

function OnEffectFinish(Actor akTarget, Actor akCaster)

	ED_Art_VFX_BloodVortex_ProfanedSunFlares.Stop(TheSun)
	ED_Art_VFX_BloodVortex_ProfanedSunCloak.Stop(TheSun)
	TheSun.StopTranslation()
	TheSun.Disable(true)
	TheSun.Delete()
	
endFunction

function OnUpdate()
	actor _target = ED_LastBloodBrandedActor.GetReference() as actor
	debug.Trace("Everdamned DEBUG: Profaned Sun target: " + _target)
	if _target != none
		TheSun.TranslateTo(_target.X, _target.Y, _target.Z + 170.0, 0.0, 0.0, 0.0, 200.0, 0.0)
		if _target.IsDead()
			ED_LastBloodBrandedActor.Clear()
		endif
	endif
	RegisterForSingleUpdate(1.0)
endFunction

function OnEffectStart(Actor akTarget, Actor akCaster)
	
	objectreference TheOrbRef = TheOrb.GetReference()
	debug.Trace("Everdamned DEBUG: Profaned Sun started, akTarget: " + akTarget + ", akCaster:" + akCaster)
	
	TheSun = TheOrbRef.PlaceAtMe(ED_Art_Light_ProfanedSun_Projectile, 1, false, true)
	TheSun.SetAngle(0.0, 0.0, 0.0)
	TheSun.MoveTo(TheOrbRef, 0.0, 0.0, 0.0, false)
	TheSun.Enable(true)
	
	ED_Mechanics_Quest_BloodVortex.SetCurrentStageID(100)
	
	while !(TheSun.is3dloaded())
		utility.wait(0.1)
	endwhile
	
	ED_VampireSpells_ProfanedSun_Cloak_Spell.RemoteCast(playerRef, playerRef, TheSun)
	ED_Art_VFX_BloodVortex_ProfanedSunFlares.Play(TheSun)
	ED_Art_VFX_BloodVortex_ProfanedSunCloak.Play(TheSun)
	RegisterForSingleUpdate(1.0)
	
	actor _target = ED_LastBloodBrandedActor.GetReference() as actor
	if _target != none
		if _target.IsDead()
			ED_LastBloodBrandedActor.Clear()
		else
			TheSun.TranslateTo(_target.X, _target.Y, _target.Z + 170.0, 0.0, 0.0, 0.0, 200.0, 0.0)
			;TheSun.TranslateToRef(_target, 200.0, 0.000000)
		endif
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endFunction

quest property ED_Mechanics_Quest_BloodVortex auto
referencealias property TheOrb auto

Spell property ED_VampireSpells_ProfanedSun_Cloak_Spell auto
light property ED_Art_Light_ProfanedSun_Projectile auto
ReferenceAlias property ED_LastBloodBrandedActor auto

visualeffect property ED_Art_VFX_BloodVortex_ProfanedSunFlares auto
visualeffect property ED_Art_VFX_BloodVortex_ProfanedSunCloak auto

actor property playerRef auto
