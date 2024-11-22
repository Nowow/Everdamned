Scriptname ED_BloodPoolManager_Script Extends Quest

float property BaseBloodPoolBonusDecreaseRate auto

float _calculatedBonus
float _currentAV
float _currentBonus
float _maxAV

bool _locked = false
actor _playerRef


float _incrementPermaBonus
float _decrementBonus


bool function ProcessBonuses()
	
	if _locked
		debug.Trace("Everdamned: ProcessBonuses called during lock, skipping")
		return false
	endif
	_locked = true
	_playerRef = Game.GetPlayer()
	
	_incrementPermaBonus = ED_BloodPoolMaxBonus.GetValue() * 0.05
	_decrementBonus = BaseBloodPoolBonusDecreaseRate - _incrementPermaBonus
	ED_BloodPoolMaxPermaBonus.Mod(_incrementPermaBonus)
	ED_BloodPoolMaxBonus.Mod(_decrementBonus)
	
	ModBloodPoolMaximum(BaseBloodPoolBonusDecreaseRate)
	
	_locked = false
	return true
endfunction


bool function AtStageOrAgeChange(int VampireStatus, int VampireAge, float hpEaten = 0.0)
	if !VampireStatus || !VampireAge
		debug.Trace("Everdamned ERROR: AtStageOrAgeChange in BloodPoolManager called without status or age")
		return false
	endif
	if _locked
		debug.Trace("Everdamned Warning: AtStageOrAgeChange called while _locked, waiting...")
		utility.wait(10.0) ; idk how long?
		if _locked
			debug.Trace("Everdamned ERROR: AtStageOrAgeChange stuck in _locked state, problem with ED_BloodPoolManager_Script")
			return false
		endif
	endif
	_locked = true
	_playerRef = Game.GetPlayer()
	
	SetBloodPoolGlobals(VampireStatus, VampireAge)
	if hpEaten > 0
		debug.Trace("AtStageOrAgeChange called after feed")
		SetBonusAfterFeed(hpEaten)
	else
		debug.Trace("AtStageOrAgeChange called because hungry")
		ED_BloodPoolMaxBonus.SetValue(0.0)
	endif
	ReconstructBloodPoolAV()
	_locked = false
	return true
endfunction


; not interface
float _calcMaxAv
function SetBloodPoolGlobals(int VampireStatus, int VampireAge)
	
	; each age adds 150 to pool? maybe should add more?
	_calcMaxAv = 150.0 + (150.0 * (VampireAge as float))
	; Base pool values for progression, full for Sated, half for Starved
	_calcMaxAv = _calcMaxAv - ((_calcMaxAv / 6.0) * ((VampireStatus - 1) as float))
	
	ED_BloodPoolMax.SetValue(_calcMaxAv)

endfunction



; not interface
function ReconstructBloodPoolAV()
	
	_playerRef.SetAV("Variable08", ED_BloodPoolMax.GetValue() + ED_BloodPoolMaxBonus.GetValue() + ED_BloodPoolMaxPermaBonus.GetValue())
	; top up, cant reconstruct keeping current value because not thread safe
	_playerRef.RestoreAV("Variable08", 9999.0)
	
endfunction

function ModBloodPoolMaximum(float _val)

	_playerRef.ModAV("Variable08", _val)
	if _val < 0
		_playerRef.RestoreAV("Variable08", _val)
	else
		_playerRef.DamageAV("Variable08", _val)
	endif
	
endfunction

; not interface
function SetBonusAfterFeed(float _hpEaten)

	_calculatedBonus = _hpEaten * 0.2
	_currentBonus = ED_BloodPoolMaxBonus.GetValue()
	debug.Trace("EVERDAMNED: current blood pool bonus: " + _currentBonus + ", calculated: " + _calculatedBonus)
	if _calculatedBonus > _currentBonus
		debug.Trace("Setting new blood pool bonus!")
		_currentBonus = _calculatedBonus
		ED_BloodPoolMaxBonus.SetValue(_currentBonus)
		
		; top up included
		;_playerRef.ForceAV("Variable08", ED_BloodPoolMax.GetValue() + _currentBonus + ED_BloodPoolMaxPermaBonus.GetValue())
	endif
	
endfunction


GlobalVariable Property ED_BloodPoolMax  Auto  

GlobalVariable Property ED_BloodPoolMaxBonus  Auto  

GlobalVariable Property ED_BloodPoolMaxPermaBonus  Auto  
