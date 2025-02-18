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
int __HemomancyXPneededToAdvance

function RestartLearning()
	debug.Trace("Everdamned INFO: Restarting Hemomancy learning, setting all counters to 0 and goto empty state")
	AdeptHemomancyLearned = 0
	ExpertHemomancyLearned = 0
	MasterHemomancyLearned = 0
	__allHemomancyLearned = false
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

function GainHemomancyXP(int HowMuch)
	__HemomancyXPneededToAdvance -= HowMuch
	if __HemomancyXPneededToAdvance <= 0
		AdvanceHemomancy()
	endif
endfunction

function AdvanceHemomancy()
	debug.Trace("Everdamned ERROR: AdvanceHemomancy was called in an empty state, should not have happened")
endfunction

state LearningAdept
	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Adept Hemomancy")
		__HemomancyXPneededToAdvance = 15
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	function AdvanceHemomancy()
		debug.Trace("Everdamned DEBUG: Hemomancy will be advanced")		
		
		int spellListSize = AdeptHemomancySpells.Length
		while AdeptHemomancyLearned < spellListSize
			theSpell = AdeptHemomancySpells[i]
			if !(player.hasspell(theSpell))
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				player.addspell(theSpell)
				AdeptHemomancyLearned += 1
				return
			else
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
			endif
			AdeptHemomancyLearned += 1
		endWhile
		
		
		debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Adept Hemomancy spells, goto state LearningExpert")
		GoToState("LearningExpert")
		AdvanceHemomancy()

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __learnLock
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
		__HemomancyXPneededToAdvance = 15
		AdvanceHemomancy()
		
		__learnLock = false
	endevent
	
endstate

state LearningExpert
	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Expert Hemomancy")
		__HemomancyXPneededToAdvance = 30
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction
	
	function AdvanceHemomancy()
		debug.Trace("Everdamned DEBUG: Hemomancy will be advanced")		
		
		int spellListSize = ExpertHemomancySpells.Length
		while ExpertHemomancyLearned < spellListSize
			theSpell = ExpertHemomancySpells[i]
			if !(player.hasspell(theSpell))
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				player.addspell(theSpell)
				ExpertHemomancyLearned += 1
				return
			else
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
			endif
			ExpertHemomancyLearned += 1
		endWhile
		
		
		debug.Trace("Everdamned INFO: Player seems to have learned all " + spellListSize +" Expert Hemomancy spells, goto state LearningExpert")
		GoToState("LearningMaster")
		AdvanceHemomancy()

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __learnLock
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
		__HemomancyXPneededToAdvance = 30
		
		AdvanceHemomancy()
		
		__learnLock = false
	endevent
endstate

state LearningMaster

	event OnBeginState()
		debug.Trace("Everdamned INFO: Started learning Master Hemomancy")
		__HemomancyXPneededToAdvance = 50
	endevent
	
	function StartLearningHemomancy()
		debug.Trace("Everdamned ERROR: StartLearningHemomancy was called in an non-empty state, should not have happened")
	endfunction

	function AdvanceHemomancy()
		debug.Trace("Everdamned DEBUG: Hemomancy will be advanced")		
		
		int spellListSize = MasterHemomancySpells.Length
		while MasterHemomancyLearned < spellListSize
			theSpell = MasterHemomancySpells[i]
			if !(player.hasspell(theSpell))
				debug.Trace("Everdamned DEBUG: Player does not know Hemomancy spell " + theSpell + ", teaching it")
				player.addspell(theSpell)
				MasterHemomancyLearned += 1
				return
			else
				debug.Trace("Everdamned DEBUG: Player DOES know Hemomancy spell " + theSpell + ", skipping")
			endif
			MasterHemomancyLearned += 1
		endWhile
		
		
		debug.Trace("Everdamned INFO: Player just learned all Master Hemomancy spells, thus concluding learning, goto empty state")
		__allHemomancyLearned = true
		GoToState("")

	endfunction
	
	Event OnSpellCast(Form akSpell)
		if __learnLock
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
		__HemomancyXPneededToAdvance = 50
		
		AdvanceHemomancy()
		__learnLock = false
	endevent
endstate


actor property playerRef auto
keyword property ED_Mechanics_Keyword_Hemomancy auto
perk property ED_PerkTree_BloodMagic_20_AdeptHemomancy auto
perk property ED_PerkTree_BloodMagic_40_ExpertHemomancy_Perk auto
perk property ED_PerkTree_BloodMagic_60_MasterHemomancy_Perk auto
