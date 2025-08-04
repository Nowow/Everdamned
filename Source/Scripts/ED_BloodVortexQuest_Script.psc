Scriptname ED_BloodVortexQuest_Script extends Quest  

float property OrbHeight = 170.0 auto
float property VortexLifetime = 30.0 auto
int property VictimsNeededToTransform = 4 auto

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
	TheOrbRef.SetAngle(0.0, 0.0, 0.0)
	TheOrbRef.MoveTo(TheHazardRef, 0.0, 0.0, OrbHeight, true)
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
	;ORD_Alc_ElementalOil_Explosion_FrenzyOil - initial transformation blast | imported
	;_BL_ExpFlare - scaled down | imported
	; ///_AII_DPriestBossSkullExp
	
	;00SPFervidEye - profaned sun ; make a light | imported
	;00SPPitLordAOEffect - profaned sun cloak effect | imported
	; check 00SPSunSoundLoop for profaned sun loop
	
	
	;SCS_RestorationBlood_Art_Halo outward pulse, for ingestion / looped for profaned sun?
	
	
	
	;_Sn_ResonaCloakFX add to profaned sun 00SPPitLordAOEffect
	;00SPTendrilsAO profaned sun object
	;DLC1nVampireBloodPlagueExplosion transofmation explosion WB_RestorationBlood_Explosion 
	;EASY transition _AII_DPriestBossSkullExp _AII_BloodImplosionExp
	
endfunction


bool __shutdownMutex
event OnUpdate()
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
	TheHazardRef.Disable(true)
	TheHazardRef.Delete()
	
	objectReference TheOrbRef = TheOrb.GetReference()
	ED_Art_VFX_BatsCloak.Stop(TheOrbRef)
	TheOrbRef.Disable(true)
	TheOrbRef.Delete()
	Stop()
endfunction


int ActorsDied
bool __transformHappened
function IncrementActorsDied()
	
	ActorsDied = ActorsDied + 1
	debug.Trace("Everdamned DEBUG: Blood Vortex is incrementing killed actors, now at " + ActorsDied)
	if ActorsDied >= VictimsNeededToTransform && !__transformHappened
		__transformHappened = true
		debug.Trace("Everdamned DEBUG: Blood Vortex is transforming")
		SpawnProfanedSun()
	endif
	
endfunction

function SpawnProfanedSun()
	__shutdownMutex = true
	objectReference TheOrbRef = TheOrb.GetReference()
	ED_VampireSpells_ProfanedSun_Spell.RemoteCast(TheOrbRef, playerRef)
	
	RegisterForSingleUpdate(5)
	__shutdownMutex = false
	
	; shutdown happens when after profaned sun setup complete
	; or after 5 sec timeout
	; SetCurrentStageID(100)
endfunction

visualeffect property ED_Art_VFX_BloodVortex_AbsorbCastPoint auto
visualeffect property ED_Art_VFX_BloodVortex_AbsorbTargetPoint auto
visualeffect property ED_Art_VFX_BloodVortex_AbsorbCrown auto


sound[] property AbsorbSounds auto

referencealias property TheOrb auto
referencealias property TheHazard auto

spell property ED_VampireSpells_BloodVortex_Spell_SpawnHazard auto
spell property ED_VampireSpells_ProfanedSun_Spell auto
spell property ED_VampireSpells_BloodVortex_Spell_HazardCloak auto

Explosion Property ED_Art_Explosion_BloodVortex_AbsorbOrbSpawnExplosion auto
VisualEffect property ED_Art_VFX_BatsCloak auto
hazard property ED_Art_Hazard_BloodVortex auto

actor property playerRef auto
