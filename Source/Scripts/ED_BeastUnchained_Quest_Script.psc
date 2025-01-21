Scriptname ED_BeastUnchained_Quest_Script extends Quest  

message property ED_Mechanics_Ab_BeastUnchained_Message_TransformImmenent auto
spell property ED_VampirePowers_GarkainBeast_Change auto
actor property playerRef auto

PlayerVampireQuestScript property PlayerVampireQuest auto

float property WarningRate auto
int property WarningsCount auto

int __warningsIssued

bool __trackingStarted
function SetupTracking()
	if __trackingStarted
		debug.Trace("Everdamned DEBUG: Beast Unchained Quest tracking has already started, do nothing")
		return
	endif
	__trackingStarted = true
	debug.Trace("Everdamned DEBUG: Beast Unchained Quest started")
	;play sfx
	
	;show message with little lag
	
	utility.wait(0.5)
	message.ResetHelpMessage("ed_garkain_transformimmenent")
	ED_Mechanics_Ab_BeastUnchained_Message_TransformImmenent.ShowAsHelpMessage("ed_garkain_transformimmenent", 5.0, 1.0, 1)
	
	;register for updates and issue all warnings
	SetStage(10)
		
endfunction

function TransformImmenent()
	if GetStage() == 10 
		debug.Trace("Everdamned DEBUG: Beast Unchained Quest, transform immenent. Total warnings: " + WarningsCount + ", issue rate: " + WarningRate)
		debug.Trace("Everdamned DEBUG: Beast Unchained Quest, time till transform trigger: " + (WarningsCount + 1)*WarningRate)
		RegisterForSingleUpdate(WarningRate)
	else
		debug.Trace("Everdamned ERROR: Beast Unchained Quest transform immenent called from later stage, do nothing ")
		SetStage(100)
	endif
endfunction

event OnUpdate()
	; transform pending
	if GetStage() == 10
		;player still in combat and hungery
		;debug.Trace("Everdamned DEBUG: player combat: " + playerRef.isInCombat() + ", VampireStatus: " + PlayerVampireQuest.VampireStatus)
		;debug.Trace("Everdamned DEBUG: eval1 " + playerRef.isInCombat() && PlayerVampireQuest.VampireStatus > 3)
		;debug.Trace("Everdamned DEBUG: eval2 " + playerRef.isInCombat())
		;debug.Trace("Everdamned DEBUG: eval3 " + PlayerVampireQuest.VampireStatus < 3)
		;playerRef.isInCombat() && PlayerVampireQuest.VampireStatus < 3
		if playerRef.isInCombat() && PlayerVampireQuest.VampireStatus > 3
			;issue warning if left
			if __warningsIssued < WarningsCount
				__warningsIssued += 1
				debug.Trace("Everdamned DEBUG: warnings issued: " + __warningsIssued)
				
				;play warning SFX
				
				RegisterForSingleUpdate(WarningRate)
			;trigger transform
			else
				SetStage(20)
			endif
		;player averted transformation
		else
			SetStage(30)
		endif
	endif
endevent
 
function DoTransform()
	debug.Trace("Everdamned DEBUG:  Beast Unchained Quest triggers transform")
	ED_VampirePowers_GarkainBeast_Change.Cast(playerRef, playerRef)
	SetStage(100)
endfunction

function TransformAverted()
	debug.Trace("Everdamned DEBUG:  Beast Unchained Quest transform averted")
	SetStage(100)
endfunction

bool __isShuttingDown

function Shutdown()
	if __isShuttingDown
		return
	endif
	__isShuttingDown = true
	debug.Trace("Everdamned DEBUG:  Beast Unchained Quest shuts down")
	
	__warningsIssued = 0
	__trackingStarted = false
	__isShuttingDown = false
	stop()
endfunction
