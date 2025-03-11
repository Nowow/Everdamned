Scriptname ED_HemomancyStudies_Quest extends ReferenceAlias


;Event OnPlayerLoadGame()
;	Debug.Trace("Everdamned INFO: Feed Manager player alias OnPlayerLoadGame() called ")
;	(GetOwningQuest() as ED_FeedManager_Script).RegisterFeedEvents()
;EndEvent

;Event OnRaceSwitchComplete()
; 	Debug.Trace("Everdamned INFO: Feed Manager player alias OnRaceSwitchComplete() called ")
;	(GetOwningQuest() as ED_FeedManager_Script).RegisterFeedEvents()
;EndEvent

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

; TODO: remove in favor of stop starting the whole quest
function RestartLearning()
	debug.Trace("Everdamned INFO: Restarting Hemomancy learning, setting all counters to 0 and goto empty state")
	AdeptHemomancyLearned = 0
	ExpertHemomancyLearned = 0
	MasterHemomancyLearned = 0
	__allHemomancyLearned = false
	__readyToProgress = false
	__learnLock = false
	GoToState("")
	StartLearningHemomancy()
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

function AdvanceHemomancy()
	debug.Trace("Everdamned ERROR: AdvanceHemomancy was called in an empty state, should not have happened")
endfunction

state LearningAdept
	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Adept Hemomancy")
		__readyToProgress = false
		__HemomancyXPneededToAdvance = 15
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	function AdvanceHemomancy()
		if !__readyToProgress
			debug.Trace("Everdamned DEBUG: Hemomancy Advance got called, but not ready yet, doing nothing")		
			return
		endif
		; acts as lock as well as allowing exp to start accumulating again, however DO NOT think that it should ever come into play
		__readyToProgress = false
		debug.Trace("Everdamned INFO: Hemomancy will be advanced")		
		
		; total available spells of this tier
		int spellListSize = AdeptHemomancySpells.Length
		
		; iterating over all of them
		while AdeptHemomancyLearned < spellListSize
		
			spell theSpell = AdeptHemomancySpells[AdeptHemomancyLearned]
			; if player does not have this spell
			if !(playerRef.hasspell(theSpell))
				;teach him and be done
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				playerRef.addspell(theSpell)
				AdeptHemomancyLearned += 1
				return
			else
				; moving to try next spell
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
				AdeptHemomancyLearned += 1
			endif
		endWhile
		
		; player know all spells of this tier, switching to next state and trying to advance there
		debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Adept Hemomancy spells, goto state LearningExpert")
		GoToState("LearningExpert")
		; if player does not have the next perk, getting XP and learning is halted until he does
		
		if playerRef.hasperk(ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk)
			; otherwise trying to advance again immediately
			debug.Trace("Everdamned INFO: And calling Hemomancy Advance in new state because player has the perk")
			__readyToProgress = true
			AdvanceHemomancy()
		endif

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __readyToProgress || __learnLock
			return
		endif
		__learnLock = true
		if !akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy) || !(playerRef.hasperk(ED_PerkTree_BloodMagic_20_AdeptHemomancy))
			__learnLock = false
			return
		endif

		debug.Trace("Everdamned DEBUG: Hemomancy spell was cast")
		
		int hemXP = 1
		__HemomancyXPneededToAdvance -= hemXP 
		if __HemomancyXPneededToAdvance > 0
			__learnLock = false
			return
		endif
		__readyToProgress = true
		__HemomancyXPneededToAdvance = 15
		
		; now called from FeedManager, because actual hemomancy advancement 
		; comes from feeding after getting enough exp
		;AdvanceHemomancy()
		
		__learnLock = false
	endevent
	
endstate

state LearningExpert
	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Expert Hemomancy")
		__readyToProgress = false
		__HemomancyXPneededToAdvance = 30
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	
	function AdvanceHemomancy()
		if !__readyToProgress
			debug.Trace("Everdamned DEBUG: Hemomancy Advance got called, but not ready yet, doing nothing")		
			return
		endif
		; acts as lock as well as allowing exp to start accumulating again, however DO NOT think that it should ever come into play
		__readyToProgress = false
		debug.Trace("Everdamned INFO: Hemomancy will be advanced")		
		
		; total available spells of this tier
		int spellListSize = ExpertHemomancySpells.Length
		
		; iterating over all of them
		while ExpertHemomancyLearned < spellListSize
		
			spell theSpell = ExpertHemomancySpells[ExpertHemomancyLearned]
			; if player does not have this spell
			if !(playerRef.hasspell(theSpell))
				;teach him and be done
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				playerRef.addspell(theSpell)
				ExpertHemomancyLearned += 1
				return
			else
				; moving to try next spell
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
				ExpertHemomancyLearned += 1
			endif
		endWhile
		
		; player know all spells of this tier, switching to next state and trying to advance there
		debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Expert Hemomancy spells, goto state LearningExpert")
		GoToState("LearningMaster")
		; if player does not have the next perk, getting XP and learning is halted until he does
		
		if playerRef.hasperk(ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk)
			; otherwise trying to advance again immediately
			debug.Trace("Everdamned INFO: And calling Hemomancy Advance in new state because player has the perk")
			__readyToProgress = true
			AdvanceHemomancy()
		endif

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __readyToProgress || __learnLock
			return
		endif
		__learnLock = true
		if !akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy) || !(playerRef.hasperk(ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk))
			__learnLock = false
			return
		endif

		debug.Trace("Everdamned DEBUG: Hemomancy spell was cast")
		
		int hemXP = 1
		__HemomancyXPneededToAdvance -= hemXP 
		if __HemomancyXPneededToAdvance > 0
			__learnLock = false
			return
		endif
		__readyToProgress = true
		__HemomancyXPneededToAdvance = 30
		
		; now called from FeedManager, because actual hemomancy advancement 
		; comes from feeding after getting enough exp
		;AdvanceHemomancy()
		
		__learnLock = false
	endevent
	
endstate

state LearningMaster

	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Master Hemomancy")
		__readyToProgress = false
		__HemomancyXPneededToAdvance = 50
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	function AdvanceHemomancy()
		if !__readyToProgress
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
				return
			else
				; moving to try next spell
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
				MasterHemomancyLearned += 1
			endif
		endWhile
		
		debug.Trace("Everdamned INFO: Player just learned all Master Hemomancy spells, thus concluding learning, goto empty state")
		__allHemomancyLearned = true
		GoToState("")

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __readyToProgress || __learnLock
			return
		endif
		__learnLock = true
		if !akSpell.haskeyword(ED_Mechanics_Keyword_Hemomancy) || !(playerRef.hasperk(ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk))
			__learnLock = false
			return
		endif

		debug.Trace("Everdamned DEBUG: Hemomancy spell was cast")
		
		int hemXP = 1
		__HemomancyXPneededToAdvance -= hemXP 
		if __HemomancyXPneededToAdvance > 0
			__learnLock = false
			return
		endif
		__readyToProgress = true
		__HemomancyXPneededToAdvance = 50
		
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
