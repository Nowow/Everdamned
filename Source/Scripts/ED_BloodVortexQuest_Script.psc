Scriptname ED_BloodVortexQuest_Script extends Quest  

float property OrbHeight = 170.0 auto
float property VortexLifetime = 30.0 auto
int property VictimsNeededToTransform = 4 auto

function Startup()
	
	ObjectReference TheOrbRef = TheOrb.GetReference()
	TheOrbRef.SetAngle(0.0, 0.0, 0.0)
	TheOrbRef.MoveTo(TheOrbRef, 0.0, 0.0, OrbHeight, true)
	TheOrbRef.PlaceAtMe(ED_Art_Explosion_BloodVortex_AbsorbOrbSpawnExplosion)
	TheOrbRef.Enable(true)
	ED_Art_VFX_BatsCloak.Play(TheOrbRef, 29.0)
	ED_VampireSpells_BloodVortex_Spell_SpawnHazard.RemoteCast(TheOrbRef, playerRef)
	
	; dirtiest hack of them all, but I dont know how to spawn a hazard from player
	; and capture its object / dispel the effect holding the hazard on demand...
	utility.wait(0.1)
	objectreference TheHazardRef = game.FindClosestReferenceOfTypeFromRef(ED_Art_Hazard_BloodVortex, playerRef, 1000)
	debug.Trace("Everdamned DEBUG: Blood Vortex found the hazard: " + TheHazardRef)
	TheHazard.ForceRefTo(TheHazardRef)
	
	RegisterForSingleUpdate(VortexLifetime)
	
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
	TheOrbRef.Disable(true)
	TheOrbRef.Delete()
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


referencealias property TheOrb auto
referencealias property TheHazard auto

spell property ED_VampireSpells_BloodVortex_Spell_SpawnHazard auto
spell property ED_VampireSpells_ProfanedSun_Spell auto

Explosion Property ED_Art_Explosion_BloodVortex_AbsorbOrbSpawnExplosion auto
VisualEffect property ED_Art_VFX_BatsCloak auto
hazard property ED_Art_Hazard_BloodVortex auto

actor property playerRef auto
