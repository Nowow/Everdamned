Scriptname ED_BloodVortexQuest_Script extends Quest  

float property OrbHeight = 170.0 auto
float property VortexLifetime = 30.0 auto
int property VictimsNeededToTransform = 4 auto

float property ExtraDuration auto

function Startup()
	
	;ED_VampireSpells_BloodVortex_Spell_SpawnHazard.Cast(playerRef)
	
	; dirtiest hack of them all, but I dont know how to spawn a hazard from player
	; and capture its object / dispel the effect holding the hazard on demand...
	
	objectreference TheHazardRef = game.FindClosestReferenceOfTypeFromRef(ED_Art_Hazard_BloodVortex, playerRef, 10000)
	while !TheHazardRef
		TheHazardRef = game.FindClosestReferenceOfTypeFromRef(ED_Art_Hazard_BloodVortex, playerRef, 10000)
		utility.wait(0.05)
	endwhile
	
	;objectreference TheHazardRef = TheOrbRef.placeatme(ED_Art_Hazard_BloodVortex)
	debug.Trace("Everdamned DEBUG: Blood Vortex found the hazard: " + TheHazardRef)
	
	;BlizzardForceExplosion
	
	ObjectReference TheOrbRef = TheOrb.GetReference()
	TheOrbRef.MoveTo(TheHazardRef, 0.0, 0.0, OrbHeight, true)
	TheOrbRef.SetAngle(0.0, 0.0, 0.0)
	TheOrbRef.PlaceAtMe(ED_Art_Explosion_BloodVortex_AbsorbOrbSpawnExplosion)
	TheOrbRef.Enable()
	
	while !(TheOrbRef.is3dloaded())
		utility.wait(0.1)
	endwhile
	
	ED_Art_VFX_BatsCloak.Play(TheOrbRef)
	
	TheHazard.ForceRefTo(TheHazardRef)
	RegisterForSingleUpdate(VortexLifetime)
	
	;00SPTranscendCloakEffectEvil runic circle, lower and add to the storm
	
	; TODO: add energy hum to the whole vortex
	
	;00SPScapeGoatEffectAO add to Vortex
	;00SPScapeGoatEffectAONEW - setscale 0.8  | imported
	
	;BLO_BloodCastPoint01 BLO_BloodTargetPoint01 on ingestion | imported
	;SCS_RestorationBlood_Art_HeartOfThorns stacking when absorbing | imported
	
	;ED_Art_ExsanguinateBuildup
	
	;
	;ED_Art_Explosion_BloodVortex_FlareSecondary - initial transformation blast | imported
	;ED_Art_Explosion_BloodVortex_Flare - scaled down | imported
	; ----_AII_DPriestBossSkullExp
	
	;ED_Art_Light_BloodVortex_ProfanedSun - profaned sun ; make a light | imported
	;ED_Art_VFX_BloodVortex_ProfanedSunCloak - profaned sun cloak effect | imported
	; check 00SPSunSoundLoop for profaned sun loop
	
	
	;SCS_RestorationBlood_Art_Halo outward pulse, for ingestion / looped for profaned sun?
	
	
	
	;_Sn_ResonaCloakFX add to profaned sun 00SPPitLordAOEffect
	;00SPTendrilsAO profaned sun object
	;DLC1nVampireBloodPlagueExplosion transofmation explosion WB_RestorationBlood_Explosion 
	;EASY transition _AII_DPriestBossSkullExp _AII_BloodImplosionExp
	
endfunction


bool __shutdownMutex
event OnUpdate()
	if __shutdownMutex
		return
	endif
	
	if __transformHappened
		SetCurrentStageID(100)
		return
	endif 
	
	if ExtraDuration > 0
		float __aaa = ExtraDuration
		ExtraDuration = 0.0
		RegisterForSingleUpdate(__aaa)
		debug.Trace("Everdamned INFO: Blood vortex EXTENDED for " + __aaa + " seconds")
	endif
	
	if !__shutdownMutex && GetCurrentStageID() != 100
		; blood vortex did not birth a profaned sun
		; or timeout reached
		; shutdown
		SetCurrentStageID(100)
	endif
endevent

function Shutdown()
	UnregisterForUpdate()
	debug.Trace("Everdamned DEBUG: Blood Vortex Quest shutdown func called!")
	objectreference TheHazardRef = TheHazard.GetReference()
	if TheHazardRef.IsEnabled()
		TheHazardRef.Disable(true)
	endif
	TheHazardRef.Delete()
	
	objectReference TheOrbRef = TheOrb.GetReference()
	if TheOrbRef.IsEnabled()
		ED_Art_VFX_BatsCloak.Stop(TheOrbRef)
		TheOrbRef.Disable(true)
	endif
	TheOrbRef.Delete()
	Stop()
endfunction


int ActorsDied
bool __transformHappened
function IncrementActorsDied(actor AbsorbedActor)
	if __transformHappened
		debug.Trace("Everdamned DEBUG: Blood Vortex wants to increment killed actors, but transform already happened")
		return
	endif
	ActorsDied = ActorsDied + 1	
	debug.Trace("Everdamned DEBUG: Blood Vortex is incrementing killed actors, now at " + ActorsDied)
	
	ObjectReference TheOrbRef = TheOrb.GetReference()
	
	ED_Art_VFX_BloodVortex_AbsorbCastPoint.Play(TheOrbRef, 5.0, AbsorbedActor)
	ED_Art_VFX_BloodVortex_AbsorbTargetPoint.Play(AbsorbedActor, 5.0, TheOrbRef)
	
	if ActorsDied >= VictimsNeededToTransform
		__transformHappened = true
		__shutdownMutex = true
		debug.Trace("Everdamned DEBUG: Blood Vortex is transforming")
		
		objectreference TheHazardRef = TheHazard.GetReference()
		ObjectReference TheAnchor = TheOrbRef.PlaceAtMe(FXEmptyActivator)
		ED_Art_VFX_BatsCloak.Stop(TheOrbRef)
		ED_Art_VFX_BloodVortex_AbsorbCrown.Stop(TheOrbRef)
		TheOrb.ForceRefTo(TheAnchor)
		
		TheAnchor.PlaceAtMe(ED_Art_Explosion_BloodVortex_FlareSecondary)
		TheAnchor.PlaceAtMe(ED_Art_Explosion_BloodVortex_TransformInitial)
		TheOrbRef.DisableNoWait(true)
		TheHazardRef.DisableNoWait(true)
		ED_Art_SoundM_BloodVortex_TransformTrigger.PlayAndWait(TheAnchor)
		
		
		; moved to explosion
		;ED_Art_SoundM_BloodVortex_Flare.Play(TheAnchor)
		TheAnchor.PlaceAtMe(ED_Art_Explosion_BloodVortex_Flare)
		
		; make profaned sun appear slowly
		ED_VampireSpells_ProfanedSun_Spell.Cast(playerRef)
		
		RegisterForSingleUpdate(5)
		__shutdownMutex = false
		; shutdown happens when after profaned sun setup complete
		; or after 5 sec timeout
		; SetCurrentStageID(100)
		
		TheAnchor.Disable()
		TheAnchor.Delete()
		
	else
		ExtraDuration += 10.0
		sound SoundToPlay = AbsorbSounds[ActorsDied]
		ED_Art_VFX_BloodVortex_AbsorbCrown.Play(TheOrbRef)
		SoundToPlay.Play(TheOrbRef)
		ED_Art_SoundM_BloodVortex_Initial2.Play(TheOrbRef)
		ED_Mechanics_Message_BloodVortex_Extended.Show()
	endif
	
endfunction


visualeffect property ED_Art_VFX_BloodVortex_AbsorbCastPoint auto
visualeffect property ED_Art_VFX_BloodVortex_AbsorbTargetPoint auto
visualeffect property ED_Art_VFX_BloodVortex_AbsorbCrown auto
visualeffect property ED_Art_VFX_BloodVortex_ProfanedSunCloak auto

explosion property ED_Art_Explosion_BloodVortex_TransformInitial auto
explosion property ED_Art_Explosion_BloodVortex_FlareSecondary auto
explosion property ED_Art_Explosion_BloodVortex_Flare auto

sound property ED_Art_SoundM_BloodVortex_TransformTrigger auto
sound property ED_Art_SoundM_BloodVortex_Flare auto
sound property ED_Art_SoundM_BloodVortex_Initial2 auto
sound[] property AbsorbSounds auto

referencealias property TheOrb auto
referencealias property TheHazard auto

spell property ED_VampireSpells_BloodVortex_Spell_SpawnHazard auto
spell property ED_VampireSpells_ProfanedSun_Spell auto
spell property ED_VampireSpells_BloodVortex_Spell_HazardCloak auto

Explosion Property ED_Art_Explosion_BloodVortex_AbsorbOrbSpawnExplosion auto
VisualEffect property ED_Art_VFX_BatsCloak auto
hazard property ED_Art_Hazard_BloodVortex auto
activator property FXEmptyActivator auto
message property ED_Mechanics_Message_BloodVortex_Extended auto

actor property playerRef auto
