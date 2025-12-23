Scriptname ED_HemomancyStudies_Quest extends ReferenceAlias


spell[] property AdeptHemomancySpells auto
spell[] property ExpertHemomancySpells auto
spell[] property MasterHemomancySpells auto

int property AdeptHemomancyLearned auto
int property ExpertHemomancyLearned auto
int property MasterHemomancyLearned auto

bool __allHemomancyLearned
bool __learnLock
bool __readyToProgress
int __HemomancyXPneededToAdvance

function RemoveAllDisplayAb()
	playerRef.RemoveSpell(ED_Mechanics_UnlockDisplayAb_HemomancyStudiesInProgress)
	playerRef.RemoveSpell(ED_Mechanics_UnlockDisplayAb_HemomancyProgressReady)
endfunction

function ManageDisplayAb()
	if __readyToProgress
		playerRef.RemoveSpell(ED_Mechanics_UnlockDisplayAb_HemomancyStudiesInProgress)
		playerRef.AddSpell(ED_Mechanics_UnlockDisplayAb_HemomancyProgressReady, false)
		debug.Trace("Everdamned DEBUG: Hemomancy Studies gives Progress Ready display ability")
		return
	endif
	
	playerRef.RemoveSpell(ED_Mechanics_UnlockDisplayAb_HemomancyProgressReady)
	
	if  	playerRef.HasPerk(ED_PerkTree_BloodMagic_20_AdeptHemomancy) \
			&& AdeptHemomancyLearned < AdeptHemomancySpells.Length
		
		playerRef.AddSpell(ED_Mechanics_UnlockDisplayAb_HemomancyStudiesInProgress, false)
		debug.Trace("Everdamned DEBUG: Hemomancy Studies gives In Progress display ability for Adept")
	
	elseif  playerRef.HasPerk(ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk) \
			&& ExpertHemomancyLearned < ExpertHemomancySpells.Length
		
		playerRef.AddSpell(ED_Mechanics_UnlockDisplayAb_HemomancyStudiesInProgress, false)
		debug.Trace("Everdamned DEBUG: Hemomancy Studies gives In Progress display ability for Expert")
	
	elseif  playerRef.HasPerk(ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk) \
			&& MasterHemomancyLearned < MasterHemomancySpells.Length
	
		playerRef.AddSpell(ED_Mechanics_UnlockDisplayAb_HemomancyStudiesInProgress, false)
		debug.Trace("Everdamned DEBUG: Hemomancy Studies gives In Progress display ability for Master")
		
	endif
	
endfunction

function StartLearningHemomancy()
	if !__allHemomancyLearned
		debug.Trace("Everdamned INFO: StartLearningHemomancy was called, hemomancy not learned yet, goto state LearningAdept")
		GoToState("LearningAdept")
	else
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called, BUT all hemomancy was learned, should not have happened")
	endif
endfunction

;function GainHemomancyXP(int HowMuch)
;	__HemomancyXPneededToAdvance -= HowMuch
;	if __HemomancyXPneededToAdvance <= 0
;		AdvanceHemomancy()
;	endif
;endfunction

function AdvanceHemomancy(bool force = false)
	debug.Trace("Everdamned ERROR: AdvanceHemomancy was called in an empty state, should not have happened")
endfunction

state LearningAdept
	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Adept Hemomancy")
		AdeptHemomancyLearned = 0
		__readyToProgress = false
		__HemomancyXPneededToAdvance = 5 + AdeptHemomancyLearned * 5
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	function AdvanceHemomancy(bool force = false)
		if !__readyToProgress && !force
			debug.Trace("Everdamned DEBUG: Hemomancy Advance got called, but not ready yet, doing nothing")
			return
		endif
		; acts as lock as well as allowing exp to start accumulating again, however DO NOT think that it should ever come into play
		__readyToProgress = false
		debug.Trace("Everdamned INFO: Hemomancy will be advanced")		
		
		; total available spells of this tier
		int spellListSize = AdeptHemomancySpells.Length
		bool spellGranted
		
		; iterating over all of them
		while !spellGranted && (AdeptHemomancyLearned < spellListSize)
		
			spell theSpell = AdeptHemomancySpells[AdeptHemomancyLearned]
			; if player does not have this spell
			if !(playerRef.hasspell(theSpell))
				;teach him and be done
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				playerRef.addspell(theSpell)
				AdeptHemomancyLearned += 1
				spellGranted = true
				ED_Mechanics_Message_HemomancySpellAwarded.Show()
				;return
			else
				; moving to try next spell
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
				AdeptHemomancyLearned += 1
			endif
		endWhile
		
		if AdeptHemomancyLearned >= spellListSize
			; player know all spells of this tier, switching to next state and trying to advance there
			debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Adept Hemomancy spells, goto state LearningExpert")
			GoToState("LearningExpert")
			
			if !spellGranted
				bool hasNextPerk = playerRef.hasperk(ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk)
				if hasNextPerk
					debug.Trace("Everdamned INFO: And since no Hemomancy spell was granted, trying to award next tier spell immediately")
					__readyToProgress = true
					AdvanceHemomancy()
				else
					debug.Trace("Everdamned ERROR: No Hemomancy spell was granted during Advance, but no perk is available next. Why are we here??")
				endif
			endif
			
		endif
		
		
		;GoToState("LearningExpert")
		; if player does not have the next perk, getting XP and learning is halted until he does
		
		;if playerRef.hasperk(ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk)
			; otherwise trying to advance again immediately
		;	debug.Trace("Everdamned INFO: And calling Hemomancy Advance in new state because player has the perk")
		;	__readyToProgress = true
		;	AdvanceHemomancy()
		;endif
		
	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __readyToProgress || __learnLock || !akSpell
			return
		endif
		__learnLock = true
		if !(akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy)) || !(playerRef.hasperk(ED_PerkTree_BloodMagic_20_AdeptHemomancy))
			__learnLock = false
			return
		endif

		debug.Trace("Everdamned DEBUG: Hemomancy spell was cast")
		
		int __xp = (akSpell as spell).GetPerk().GetNthEntryPriority(0) / 10
		if __xp < 1
			__xp = 1
		endif
		debug.Trace("Everdamned DEBUG: XP needed: " + __HemomancyXPneededToAdvance + ", Player gets " + __xp + " hemomancy XP")
		
		__HemomancyXPneededToAdvance -= __xp
		if __HemomancyXPneededToAdvance > 0
			__learnLock = false
			return
		endif

		__readyToProgress = true
		debug.Trace("Everdamned DEBUG: Hemomancy Studies is __readyToProgress in state LearningAdept")
		ED_Art_Shader_NewHemomancyAvailable.Play(playerRef, 7.0)
		ED_Mechanics_Message_HemomancyReadyToAdvance.Show()
		__HemomancyXPneededToAdvance = 5 + AdeptHemomancyLearned * 5
		ManageDisplayAb()
		
		__learnLock = false
	endevent
	
endstate

state LearningExpert
	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Expert Hemomancy")
		ExpertHemomancyLearned = 0
		__readyToProgress = false
		__HemomancyXPneededToAdvance = 20 + ExpertHemomancyLearned * 5
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	
	function AdvanceHemomancy(bool force = false)
		if !__readyToProgress && !force
			debug.Trace("Everdamned DEBUG: Hemomancy Advance got called, but not ready yet, doing nothing")
			return
		endif
		; acts as lock as well as allowing exp to start accumulating again, however DO NOT think that it should ever come into play
		__readyToProgress = false
		debug.Trace("Everdamned INFO: Hemomancy will be advanced")		
		
		; total available spells of this tier
		int spellListSize = ExpertHemomancySpells.Length
		bool spellGranted
		
		; iterating over all of them
		while !spellGranted && (ExpertHemomancyLearned < spellListSize)
		
			spell theSpell = ExpertHemomancySpells[ExpertHemomancyLearned]
			; if player does not have this spell
			if !(playerRef.hasspell(theSpell))
				;teach him and be done
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				playerRef.addspell(theSpell)
				ExpertHemomancyLearned += 1
				spellGranted = true
				ED_Mechanics_Message_HemomancySpellAwarded.Show()
			else
				; moving to try next spell
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
				ExpertHemomancyLearned += 1
			endif
		endWhile
		
		if ExpertHemomancyLearned >= spellListSize
			; player know all spells of this tier, switching to next state and trying to advance there
			debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Expert Hemomancy spells, goto state LearningMaster")
			GoToState("LearningMaster")
			
			if !spellGranted
				bool hasNextPerk = playerRef.hasperk(ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk)
				if hasNextPerk
					debug.Trace("Everdamned INFO: And since no Hemomancy spell was granted, trying to award next tier spell immediately")
					__readyToProgress = true
					AdvanceHemomancy()
				else
					debug.Trace("Everdamned ERROR: No Hemomancy spell was granted during Advance, but no perk is available next. Why are we here??")
				endif
			endif
			
		endif
		
		
		
		; player know all spells of this tier, switching to next state and trying to advance there
		;debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Expert Hemomancy spells, goto state LearningExpert")
		;GoToState("LearningMaster")
		; if player does not have the next perk, getting XP and learning is halted until he does
		
		;if playerRef.hasperk(ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk)
			; otherwise trying to advance again immediately
			; because since we are here it means that we have not taught player
			; a new spell yet
		;	debug.Trace("Everdamned INFO: And calling Hemomancy Advance in new state because player has the perk")
		;	__readyToProgress = true
		;	AdvanceHemomancy()
		;endif

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __readyToProgress || __learnLock || !akSpell
			return
		endif
		__learnLock = true
		if !(akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy)) || !(playerRef.hasperk(ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk))
			__learnLock = false
			return
		endif

		debug.Trace("Everdamned DEBUG: Hemomancy spell was cast")
		
		int __xp = (akSpell as spell).GetPerk().GetNthEntryPriority(0) / 10
		if __xp < 1
			__xp = 1
		endif
		debug.Trace("Everdamned DEBUG: XP needed: " + __HemomancyXPneededToAdvance + ", Player gets " + __xp + " hemomancy XP")
		
		__HemomancyXPneededToAdvance -= __xp
		if __HemomancyXPneededToAdvance > 0
			__learnLock = false
			return
		endif
		
		__readyToProgress = true
		debug.Trace("Everdamned DEBUG: Hemomancy Studies is __readyToProgress in state LearningExpert")
		ED_Art_Shader_NewHemomancyAvailable.Play(playerRef, 7.0)
		ED_Mechanics_Message_HemomancyReadyToAdvance.Show()
		__HemomancyXPneededToAdvance = 20 + ExpertHemomancyLearned * 5
		
		; now called from FeedManager, because actual hemomancy advancement 
		; comes from feeding after getting enough exp
		;AdvanceHemomancy()
		ManageDisplayAb()
		__learnLock = false
	endevent
	
endstate

state LearningMaster

	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Master Hemomancy")
		MasterHemomancyLearned = 0
		__readyToProgress = false
		__HemomancyXPneededToAdvance = 30 + 5 * MasterHemomancyLearned
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	function AdvanceHemomancy(bool force = false)
		if !__readyToProgress && !force
			debug.Trace("Everdamned DEBUG: Hemomancy Advance got called, but not ready yet, doing nothing")
			return
		endif
		; acts as lock as well as allowing exp to start accumulating again, however DO NOT think that it should ever come into play
		__readyToProgress = false
		debug.Trace("Everdamned INFO: Hemomancy will be advanced")		
		
		; total available spells of this tier
		int spellListSize = MasterHemomancySpells.Length
		
		; iterating over all of them
		while MasterHemomancyLearned < spellListSize
		
			spell theSpell = MasterHemomancySpells[MasterHemomancyLearned]
			; if player does not have this spell
			if !(playerRef.hasspell(theSpell))
				;teach him and be done
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				playerRef.addspell(theSpell)
				MasterHemomancyLearned += 1
				ED_Mechanics_Message_HemomancySpellAwarded.Show()
				
				;special case, concluding all education
				if MasterHemomancyLearned == spellListSize
					debug.Trace("Everdamned INFO: Player just learned all Master Hemomancy spells, thus concluding learning, goto empty state")
					__allHemomancyLearned = true
					
					;shutdown
					ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(100)
				else
					return
				endif
				
			else
				; moving to try next spell
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
				MasterHemomancyLearned += 1
			endif
		endWhile
		
		; probably redundant
		debug.Trace("Everdamned INFO: Player just learned all Master Hemomancy spells, thus concluding learning, goto empty state")
		__allHemomancyLearned = true
		;shutdown
		ED_Mechanics_Hemomancy_Quest.SetCurrentStageID(100)

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __readyToProgress || __learnLock || !akSpell
			return
		endif
		__learnLock = true
		if !(akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy)) || !(playerRef.hasperk(ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk))
			__learnLock = false
			return
		endif

		debug.Trace("Everdamned DEBUG: Hemomancy spell was cast")
		
		int __xp = (akSpell as spell).GetPerk().GetNthEntryPriority(0) / 10
		if __xp < 1
			__xp = 1
		endif
		debug.Trace("Everdamned DEBUG: XP needed: " + __HemomancyXPneededToAdvance + ", Player gets " + __xp + " hemomancy XP")
		
		__HemomancyXPneededToAdvance -= __xp
		if __HemomancyXPneededToAdvance > 0
			__learnLock = false
			return
		endif
		
		__readyToProgress = true
		debug.Trace("Everdamned DEBUG: Hemomancy Studies is __readyToProgress in state LearningMaster")
		ED_Art_Shader_NewHemomancyAvailable.Play(playerRef, 7.0)
		ED_Mechanics_Message_HemomancyReadyToAdvance.Show()
		__HemomancyXPneededToAdvance = 30 + 5 * MasterHemomancyLearned
		ManageDisplayAb()
		; now called from FeedManager, because actual hemomancy advancement 
		; comes from feeding after getting enough exp
		;AdvanceHemomancy()
		
		__learnLock = false
	endevent

endstate


actor property playerRef auto
keyword property ED_Mechanics_Keyword_Hemomancy auto
perk property ED_PerkTree_BloodMagic_20_AdeptHemomancy auto
perk property ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk auto
perk property ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk auto

formlist property ED_Mechanics_FormList_HemomancyRewards auto

message property ED_Mechanics_Message_HemomancyReadyToAdvance auto
message property ED_Mechanics_Message_HemomancySpellAwarded auto
effectshader property ED_Art_Shader_NewHemomancyAvailable auto

quest property ED_Mechanics_Hemomancy_Quest auto

spell property ED_Mechanics_UnlockDisplayAb_HemomancyProgressReady auto
spell property ED_Mechanics_UnlockDisplayAb_HemomancyStudiesInProgress auto
