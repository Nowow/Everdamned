Scriptname ED_ProfanedSun_Script extends activemagiceffect  

float property XPgained auto

ObjectReference TheSun

function OnEffectFinish(Actor akTarget, Actor akCaster)

	TheSun.StopTranslation()
	TheSun.Delete()
	
endFunction

function OnUpdate()
	objectreference _target = ED_LastBloodBrandedActor.GetReference()
	debug.Trace("Everdamned DEBUG: Profaned Sun target: " + _target)
	if _target != none
		TheSun.TranslateToRef(_target, 200.0, 0.000000)
	endif
	RegisterForSingleUpdate(1.0)
endFunction

function OnEffectStart(Actor akTarget, Actor akCaster)
	
	objectreference TheOrbRef = TheOrb.GetReference()
	debug.Trace("Everdamned DEBUG: Profaned Sun started, akTarget: " + akTarget + ", akCaster:" + akCaster)
	
	TheSun = TheOrbRef.PlaceAtMe(ED_Art_Light_ProfanedSun_Projectile, 1, false, true)
	TheSun.SetAngle(0.0, 0.0, 0.0)
	TheSun.MoveTo(TheOrbRef, 0.0, 0.0, -100.0, false)
	TheSun.Enable(true)
	
	ED_Mechanics_Quest_BloodVortex.SetCurrentStageID(100)
	
	ED_VampireSpells_ProfanedSun_Cloak_Spell.RemoteCast(playerRef, playerRef, TheSun)
	utility.Wait(0.1)
	RegisterForSingleUpdate(1.0)
	
	objectreference _target = ED_LastBloodBrandedActor.GetReference()
	if _target != none
		TheSun.TranslateToRef(_target, 200.0, 0.000000)
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endFunction

quest property ED_Mechanics_Quest_BloodVortex auto
referencealias property TheOrb auto

Spell property ED_VampireSpells_ProfanedSun_Cloak_Spell auto
light property ED_Art_Light_ProfanedSun_Projectile auto
ReferenceAlias property ED_LastBloodBrandedActor auto

actor property playerRef auto
