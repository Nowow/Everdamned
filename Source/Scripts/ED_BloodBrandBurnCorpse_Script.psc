Scriptname ED_BloodBrandBurnCorpse_Script extends activemagiceffect  


float property DurationSeconds auto
float property SlapIntervalSeconds auto
float property SlapDeadZoneSeconds auto
float property ArmedWaitIntervalSeconds auto


objectreference __anchor
event OnEffectStart(Actor akTarget, Actor akCaster)
	
	;akTarget.SetGhost(true)
	
	;debug.Trace("Everdamned DEBUG: Burn Corpse started "  + __anchor)
	
	__anchor = akTarget.placeatme(FXEmptyActivator)
	
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	
	utility.wait(1.0)
	__anchor.placeatme(ED_Art_Hazard_BloodSpill2)
	;ED_Mechanics_Spell_SpawnBloodSpill.remotecast(akTarget, akCaster)
	
	if !(akCaster.HasSpell(ED_VampireSpells_BloodTendril_SpellAb))
		return
	endif
	
	
	utility.wait(4.0)
	
	akTarget.SetAlpha(0.0, true)
	
	;akTarget.SetGhost(false)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)
	
	;bool __started = ED_Mechanics_Keyword_TentacleHitStart.SendStoryEventAndWait(none, __anchor)
	
	RegisterForSingleUpdate(1.0)
endevent

event OnUpdate()
	
	if DurationSeconds - GetTimeElapsed() <= SlapDeadZoneSeconds
		debug.Trace("Everdamned DEBUG: Burn Corpse has NO time for SLAP")
		return
	endif
	
	debug.Trace("Everdamned DEBUG: Burn Corpse is trying to SLAP SOMEBODY")
	bool __started = ED_Mechanics_Keyword_TentacleHitStart.SendStoryEventAndWait(none, __anchor)
	
	if __started
		debug.Trace("Everdamned DEBUG: Burn Corpse successfully launched slap QUEST, sleeping")
		RegisterForSingleUpdate(SlapIntervalSeconds)
	else
		debug.Trace("Everdamned DEBUG: Burn Corpse FAILED to launch Slap quest, retrying soon")
		RegisterForSingleUpdate(ArmedWaitIntervalSeconds)
	endif

endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if __anchor
		__anchor.disable()
		__anchor.delete()
	endif
	;debug.Trace("Everdamned DEBUG: Burn Corpse finished")
endevent


activator property FXEmptyActivator auto
spell property ED_Mechanics_Spell_SpawnBloodSpill auto
keyword property ED_Mechanics_Keyword_TentacleHitStart auto
spell property ED_VampireSpells_BloodTendril_SpellAb auto
hazard property ED_Art_Hazard_BloodSpill2 auto
