Scriptname ED_MainQuest_Script extends Quest  

; should be true when player is vampire, false when not/cured.
; set to true on first call of GainAgeExpirience()
bool isAging
bool HasShownAgeMessage
int NextMessageIndex = 0

actor property playerRef auto
globalvariable property ED_Mechanics_VampireAge auto
globalvariable property ED_Mechanics_VampireAgeRate auto
globalvariable property ED_Mechanics_VampireAgeCurrentExp auto
globalvariable property ED_Mechanics_VampireAgeCurrentLvlUpThreshold auto
globalvariable property ED_Mechanics_VampireAgeLvlUpExpIncrement auto

spell[] property Age_Scaling_Display_Spell_List auto

message property ED_Mechanics_Message_AgeLvlUpNotification auto
message[] property Age_Message_List auto


function OnUpdateGameTime()
	self.GainAgeExpirience(1.00000)
	; default is once every game hour
	self.RegisterforSingleUpdateGameTime(ED_Mechanics_VampireAgeRate.value)
endFunction

float function CalculateNextLvlThreshold(int thisAge)
	float _increment = ED_Mechanics_VampireAgeLvlUpExpIncrement.value
	return _increment*(thisAge as float)
endfunction

function GainAgeExpirience(float amountToAge = 0.0)
	
	if !isAging
		; called for first time since becoming vamp (again)
		; giving Fledgling stuff
		isAging = true
		; give 
		RegisterforSingleUpdateGameTime(ED_Mechanics_VampireAgeRate.value)
	endif
	if amountToAge > 0.0
		ED_Mechanics_VampireAgeCurrentExp.Mod(amountToAge)
		if ED_Mechanics_VampireAgeCurrentExp.value >= ED_Mechanics_VampireAgeCurrentLvlUpThreshold.value
			if !HasShownAgeMessage
				ED_Mechanics_Message_AgeLvlUpNotification.Show()
				HasShownAgeMessage = true
			endif
			RegisterForSleep()
		endif
	endif
endfunction

event OnSleepStop(Bool abInterrupted)
	if abInterrupted
		return
	endif
	UnregisterForSleep()
	LvlUpAge()
	Age_Message_List[NextMessageIndex].Show()
	NextMessageIndex += 1
	HasShownAgeMessage = false
endevent


function LvlUpAge()
	ED_Mechanics_VampireAge.Mod(1)
	ED_Mechanics_VampireAgeCurrentExp.value = 0.0
	ED_Mechanics_VampireAgeCurrentLvlUpThreshold.value = CalculateNextLvlThreshold((ED_Mechanics_VampireAge.value + 1) as int)
	
	SetUpAgeAppropriateRewards()
	
endfunction 

function SetUpAgeAppropriateRewards()
	int _currentAge = (ED_Mechanics_VampireAge.value) as int
	if _currentAge < 1 || _currentAge > 6
		debug.Trace("Everdamned ERROR: in SetUpAgeAppropriateRewards Vampire Age seems to be out of less than 1 or more than 6")
	endif
	; indexing from 0
	int _currentAgeIndex = _currentAge - 1
	
	int i = 0
	while i < 5 ; max age
		spell _ageDisplaySpell = Age_Scaling_Display_Spell_List[_currentAgeIndex]
		
		if i == _currentAgeIndex
			playerRef.addspell(_ageDisplaySpell)
		else
			playerRef.removespell(_ageDisplaySpell)
		endif
		
		i += 1
	endWhile
	
	
endfunction


function StopAge()

	self.UnregisterForUpdateGameTime()
	IsAging = false
	HasShownAgeMessage = false
endFunction
