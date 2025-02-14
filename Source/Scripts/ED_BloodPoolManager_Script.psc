Scriptname ED_BloodPoolManager_Script Extends Quest

float property BaseBloodPoolBonusDecreaseRate auto
actor property playerRef auto


function ModBloodPoolMaximum(float _val)

	playerRef.ModAV("ED_BloodPool", _val)
	if _val < 0
		playerRef.RestoreAV("ED_BloodPool", _val)
	else
		playerRef.DamageAV("ED_BloodPool", _val)
	endif
	
endfunction

; not interface
function ReconstructBloodPoolAV()
	
	playerRef.SetAV("ED_BloodPool", ED_Mechanics_BloodPool_Total.GetValue() + ED_Mechanics_BloodPool_MaxBonus.GetValue() + ED_Mechanics_BloodPool_MaxPermaBonus.GetValue())
	; top up, cant reconstruct keeping current value because not thread safe
	playerRef.RestoreAV("ED_BloodPool", 9999.0)
	
endfunction


; flow
;SetBloodPoolGlobals(VampireStatus, VampireAge)
;	if hpEaten > 0

;		SetBonusAfterFeed(hpEaten)
;	else

;		ED_Mechanics_BloodPool_MaxBonus.SetValue(0.0)
;	endif
;	ReconstructBloodPoolAV()


function AtStageOrAgeChange()
	GoToState("StageOrAgeChange")
endfunction

function SetBonusAfterFeed()
	GoToState("AfterFeed")
endfunction

function AtProcessBonus()
	GoToState("ProcessBonus")
endfunction

bool __doStageOrAgeChange
bool __doAfterFeed
bool __doProcessBonus
state StageOrAgeChange
	function AtStageOrAgeChange()
		__doStageOrAgeChange = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtStageOrAgeChange while in StageOrAgeChange state")
	endfunction
	function SetBonusAfterFeed()
		__doAfterFeed = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do SetBonusAfterFeed while in StageOrAgeChange state")
	endfunction
	function AtProcessBonus()
		__doProcessBonus = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtProcessBonus while in StageOrAgeChange state")
	endfunction

	event OnBeginState()
		debug.Trace("Everdamned DEBUG: Blood Pool Manager entered StageOrAgeChange state")
		int VampireStatus
		int VampireAge
		VampireStatus = PlayerVampireQuest.VampireStatus
		VampireAge = ED_Mechanics_VampireAge.GetValue() as int
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is doing adjustments for Status " + VampireStatus + " and Age " + VampireAge)
		
		float _calcMaxAv
		; each age adds 150 to pool? maybe should add more?
		_calcMaxAv = 150.0 + (150.0 * (VampireAge as float))
		; Base pool values for progression, full for Sated, half for Starved
		_calcMaxAv = _calcMaxAv - ((_calcMaxAv / 6.0) * ((VampireStatus - 1) as float))
	
		ED_Mechanics_BloodPool_Total.SetValue(_calcMaxAv)
		
		;utility.wait(0.2) ; waiting to release lock for any other calls to this script to do their thing, mainly AtStageOrAgeChange()
		GoToState("Postprocess")
	endevent
	
endstate

state AfterFeed
	function AtStageOrAgeChange()
		__doStageOrAgeChange = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtStageOrAgeChange while in AfterFeed state")
	endfunction
	function SetBonusAfterFeed()
		__doAfterFeed = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do SetBonusAfterFeed while in AfterFeed state")
	endfunction
	function AtProcessBonus()
		__doProcessBonus = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtProcessBonus while in AfterFeed state")
	endfunction

	event OnBeginState()
		debug.Trace("Everdamned DEBUG: Blood Pool Manager entered AfterFeed state")
		
		float __calculatedBonus
		float __currentBonus
		
		; % HP to be eaten gets applied at EatThisActor
		__calculatedBonus = PlayerVampireQuest.GetHPtoBeEaten()
		__currentBonus = ED_Mechanics_BloodPool_MaxBonus.GetValue()
		debug.Trace("Everdamned DEBUG: current blood pool bonus: " + __currentBonus + ", calculated: " + __calculatedBonus)
		if __calculatedBonus > __currentBonus
			debug.Trace("Everdamned DEBUG: Setting new blood pool bonus!")
			__currentBonus = __calculatedBonus
			ED_Mechanics_BloodPool_MaxBonus.SetValue(__currentBonus)
			
			; top up included
			;playerRef.ForceAV("ED_BloodPool", ED_Mechanics_BloodPool_Total.GetValue() + __currentBonus + ED_Mechanics_BloodPool_MaxPermaBonus.GetValue())
		endif
		
		GoToState("Postprocess")
	endevent
endstate

state ProcessBonuses

	function AtStageOrAgeChange()
		__doStageOrAgeChange = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtStageOrAgeChange while in ProcessBonuses state")
	endfunction
	function SetBonusAfterFeed()
		__doAfterFeed = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do SetBonusAfterFeed while in ProcessBonuses state")
	endfunction
	function AtProcessBonus()
		__doProcessBonus = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtProcessBonus while in ProcessBonuses state")
	endfunction

	event OnBeginState()
		float _incrementPermaBonus
		float _decrementBonus
		_incrementPermaBonus = ED_Mechanics_BloodPool_MaxBonus.GetValue() * 0.05
		_decrementBonus = BaseBloodPoolBonusDecreaseRate - _incrementPermaBonus
		ED_Mechanics_BloodPool_MaxPermaBonus.Mod(_incrementPermaBonus)
		ED_Mechanics_BloodPool_MaxBonus.Mod(_decrementBonus)
		
		ModBloodPoolMaximum(BaseBloodPoolBonusDecreaseRate)
	endevent
	
endstate

state Postprocess
	function AtStageOrAgeChange()
		__doStageOrAgeChange = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtStageOrAgeChange while in Postprocess state")
	endfunction
	function SetBonusAfterFeed()
		__doAfterFeed = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do SetBonusAfterFeed while in Postprocess state")
	endfunction
	function AtProcessBonus()
		__doProcessBonus = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtProcessBonus while in Postprocess state")
	endfunction
	
	event OnBeginState()
		utility.wait(0.2) ; for good measure
		if __doStageOrAgeChange
			__doStageOrAgeChange = false
			GoToState("StageOrAgeChange")
			debug.Trace("Everdamned DEBUG: Blood Pool Manager went back to StageOrAgeChange state")
			return
		endif
		if __doAfterFeed
			__doAfterFeed = false
			GoToState("AfterFeed")
			debug.Trace("Everdamned DEBUG: Blood Pool Manager went back to AfterFeed state")
			return
		endif
		if __doProcessBonus
			__doProcessBonus = false
			GoToState("ProcessBonus")
			debug.Trace("Everdamned DEBUG: Blood Pool Manager went back to ProcessBonus state")
		endif
		ReconstructBloodPoolAV()
		GoToState("PostPostprocess")
	endevent

endstate

;im so sorry...

state PostPostprocess
	function AtStageOrAgeChange()
		__doStageOrAgeChange = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtStageOrAgeChange while in PostPostprocess state")
	endfunction
	function SetBonusAfterFeed()
		__doAfterFeed = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do SetBonusAfterFeed while in PostPostprocess state")
	endfunction
	function AtProcessBonus()
		__doProcessBonus = true
		debug.Trace("Everdamned DEBUG: Blood Pool Manager is alerted to do AtProcessBonus while in PostPostprocess state")
	endfunction
	
	event OnBeginState()
		utility.wait(0.2) ; for good measure
		if !__doStageOrAgeChange && !__doAfterFeed && !__doProcessBonus
			; update cycle ended
			; dont want to log because that is not thread safe external call
			GoToState("")
			return
		endif
		GoToState("Postprocess")
	endevent
endstate

GlobalVariable Property ED_Mechanics_BloodPool_Total  Auto  
GlobalVariable Property ED_Mechanics_BloodPool_MaxBonus  Auto  
GlobalVariable Property ED_Mechanics_BloodPool_MaxPermaBonus  Auto  
GlobalVariable property ED_Mechanics_VampireAge auto

playervampirequestscript property PlayerVampireQuest auto
