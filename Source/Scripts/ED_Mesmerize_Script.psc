Scriptname ED_Mesmerize_Script extends activemagiceffect  


EVENT OnEffectStart(Actor Target, Actor Caster)

	if !(Caster.hasperk(ED_PerkTree_Deception_40_Mesmerize_Perk))
		return
	endif
	
	debug.trace("Everdamned DEBUG: Trying to start Follow Mesmerized scene on actor " + Target)
	if ED_FollowMesmerized_FeedDialogue_Scene.IsPlaying()
		debug.trace("Everdamned DEBUG: Follow Mesmerized is already playing, stopping")
		ED_FollowMesmerized_FeedDialogue_Scene.Stop()
		utility.wait(0.5)
	endif
	
	ED_FollowMesmerized.ForceRefTo(Target)
	Target.SetLookAt(Caster)
	ED_FollowMesmerized_FeedDialogue_Scene.Start()
	
	;fFollowMatchSpeedZoneWidth
	;fFollowStartSprintDistance
	
	;debug.trace("Everdamned DEBUG: setting fFollowStartSprintDistance " + Game.GetGameSettingFloat("fFollowStartSprintDistance"))
	;debug.trace("Everdamned DEBUG: setting fFollowMatchSpeedZoneWidth " + Game.GetGameSettingFloat("fFollowMatchSpeedZoneWidth"))
	
	;Game.SetGameSettingFloat("fFollowStartSprintDistance", 1500.0)
	;Game.SetGameSettingFloat("fFollowMatchSpeedZoneWidth", 1500.0)
	;debug.trace("Everdamned DEBUG: setting fFollowStartSprintDistance " + Game.GetGameSettingFloat("fFollowStartSprintDistance"))
	;debug.trace("Everdamned DEBUG: setting fFollowMatchSpeedZoneWidth " + Game.GetGameSettingFloat("fFollowMatchSpeedZoneWidth"))
	
	debug.trace("Everdamned DEBUG: Follow Mesmerized scene started")
	debug.trace("Everdamned DEBUG: Alias actor is: " + ED_FollowMesmerized.getreference() as actor)
	debug.trace("Everdamned DEBUG: Follow Mesmerized scene is playing: " + ED_FollowMesmerized_FeedDialogue_Scene.IsPlaying())

endEVENT

EVENT OnEffectFinish(Actor Target, Actor Caster)
	debug.trace("Everdamned DEBUG: Mesmerize effect finished")
	Target.ClearLookAt()
	ED_FollowMesmerized.Clear()
endevent

perk property ED_PerkTree_Deception_40_Mesmerize_Perk auto
scene property ED_FollowMesmerized_FeedDialogue_Scene auto
referencealias property ED_FollowMesmerized auto
