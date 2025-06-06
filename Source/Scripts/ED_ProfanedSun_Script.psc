Scriptname ED_ProfanedSun_Script extends activemagiceffect  


Actor TheCaster
ObjectReference TheOrb

function OnEffectFinish(Actor akTarget, Actor akCaster)

	TheOrb.StopTranslation()
	TheOrb.Delete()
	
endFunction

function OnUpdate()
	objectreference _target = ED_LastBloodBrandedActor.GetReference()
	debug.Trace("Everdamned DEBUG: Profaned Sun target: " + _target)
	if _target != none
		TheOrb.TranslateToRef(_target, 200.0, 0.000000)
		;SCS_VampireSpells_Blood_Spell_100_ProfanedSun_Proc.RemoteCast(TheOrb, TheCaster, none)
	endif
	RegisterForSingleUpdate(1.0)
endFunction

function OnEffectStart(Actor akTarget, Actor akCaster)
	
	objectreference _vortex = ED_BloodVortexAlias.TransformingVortex
	debug.Trace("Everdamned DEBUG: Profaned Sun started, akTarget: " + akTarget + ", akCaster:" + akCaster)
	TheCaster = akCaster
	TheOrb = _vortex.PlaceAtMe(ED_Art_Light_ProfanedSun_Projectile, 1, false, true)
	TheOrb.SetAngle(0 as Float, 0 as Float, 0 as Float)
	TheOrb.MoveTo(_vortex, 0.0, 0.0, -100.0, false)
	TheOrb.Enable(true)
	playerRef.dispelspell(ED_VampireSpells_BloodVortex_Spell)
	;ED_Art_VFX_WellingBlood.Play(TheOrb, 15.0)
	ED_VampireSpells_ProfanedSun_Cloak_Spell.RemoteCast(playerRef, playerRef, TheOrb)
	utility.Wait(0.100000)
	RegisterForSingleUpdate(1.0)
	
	objectreference _target = ED_LastBloodBrandedActor.GetReference()
	if _target != none
		TheOrb.TranslateToRef(_target, 200.0, 0.000000)
	endif
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
endFunction

float property XPgained auto
actor property playerRef auto
ED_BloodVortexAlias_Script Property ED_BloodVortexAlias Auto
light property ED_Art_Light_ProfanedSun_Projectile auto
ReferenceAlias property ED_LastBloodBrandedActor auto
VisualEffect property ED_Art_VFX_WellingBlood auto
Spell property ED_VampireSpells_ProfanedSun_Cloak_Spell auto
spell property ED_VampireSpells_BloodVortex_Spell auto
