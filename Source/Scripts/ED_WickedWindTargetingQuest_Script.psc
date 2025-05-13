Scriptname ED_WickedWindTargetingQuest_Script extends Quest  

import input

objectreference property LandingTarget auto

float property PollingRate = 0.2 auto

bool __done
int __currentHotkey
function StartPolling()
	
	debug.Trace("Everdamned DEBUG: Wicked Wind targeting quest started!")
	
	LandingTarget = playerRef.placeatme(LandingTargetObject, 1, false, true)
	
	while !(LandingTarget.Is3dLoaded()) && LandingTarget
		utility.wait(0.05)
	endwhile
		
	ED_VampirePowers_WickedWind_Targeting_AdjustTarget_Spell.Cast(playerRef)
	
	__currentHotkey = input.GetMappedKey("Shout")
	RegisterForKey(__currentHotkey)
	
	if !iskeypressed(__currentHotkey)
		ED_VampirePowers_WickedWind_Invis_Spell.Cast(PlayerRef as ObjectReference, none)
		
		debug.Trace("Everdamned DEBUG: Wicked Wind quest detected Hotkey A not being held before targeting started, doing failsafe!")
	
		Float XLoc = LandingTarget.GetPositionX()
		Float YLoc = LandingTarget.GetPositionY()
		Float ZLoc = LandingTarget.GetPositionZ()
		
		PlayerRef.TranslateTo(XLoc, YLoc, ZLoc + 10 as Float, 0.000000, 0.000000, 0.000000, 150000.0, 0.000000)
		ED_Art_Imod_Grayish_DispelMagic.Apply(1.00000)
		ED_Art_SoundM_WickedWind_Slow.Play(playerRef)
		Shutdown()
		return
	endif
	
	LandingTarget.enable(true)
	RegisterForUpdate(PollingRate)
endfunction

function Shutdown()
	__done = true
	if LandingTarget
		LandingTarget.disable()
		LandingTarget.delete()
	endif
	UnregisterForAllKeys()
	stop()
endfunction

event OnUpdate()
	; moves LandingTarget to explosion placed activator
	if !__done
		debug.Trace("Everdamned DEBUG: WW quest update and adjust!")
		ED_VampirePowers_WickedWind_Targeting_AdjustTarget_Spell.Cast(playerRef)
	endif
endevent

Event OnKeyUp(Int KeyCode, Float HoldTime)

	;if Utility.IsInMenuMode()
	;	return
	;endif
	
	ED_VampirePowers_WickedWind_Invis_Spell.Cast(PlayerRef as ObjectReference, none)
	
	Float XLoc = LandingTarget.GetPositionX()
	Float YLoc = LandingTarget.GetPositionY()
	Float ZLoc = LandingTarget.GetPositionZ()
	
	PlayerRef.TranslateTo(XLoc, YLoc, ZLoc + 10 as Float, 0.000000, 0.000000, 0.000000, 150000.0, 0.000000)
	ED_Art_Imod_Grayish_DispelMagic.Apply(1.00000)
	ED_Art_SoundM_WickedWind_Slow.Play(playerRef)
	
	debug.Trace("Everdamned DEBUG: Wicked Wind targeting quest detected key was held for: " + HoldTime)
	
	Shutdown()	
	
EndEvent


actor property playerRef auto
;globalvariable property ED_Mechanics_Hotkeys_HotkeyBus auto

spell property ED_VampirePowers_WickedWind_Targeting_CreateTarget_Spell auto
spell property ED_VampirePowers_WickedWind_Targeting_AdjustTarget_Spell auto
spell property ED_VampirePowers_WickedWind_Spell auto

static property LandingTargetObject auto

spell property ED_VampirePowers_WickedWind_Invis_Spell auto
imagespacemodifier property ED_Art_Imod_Grayish_DispelMagic auto
sound property ED_Art_SoundM_WickedWind_Slow auto