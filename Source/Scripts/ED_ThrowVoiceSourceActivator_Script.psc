Scriptname ED_ThrowVoiceSourceActivator_Script extends ObjectReference  

bool loaded
ObjectReference __aimTarget

function OnLoad()

	if loaded
		debug.Trace("Everdamned DEBUG: Throw Voice SOURCE Activator ALREADY loaded WTF")
		return
	endif
	
	loaded = true
	
	SetPosition(GetPositionX(),GetPositionY(), GetPositionZ() + 150.0)
	
	__aimTarget = placeatme(FXEmptyActivator)
	
	__aimTarget.moveto(self, utility.randomint(-100, 100) as float, utility.randomint(-100, 100) as float, 0)
	;__voiceThrowSource.MoveTo(__target, 0, 0, 100)
	
	;debug.Trace("Everdamned DEBUG: Throw Voice Source Activator LOADED")
	;self.SetAngle(GetAngleX(), GetAngleY(), )
	;debug.Trace("Everdamned DEBUG: Throw Voice Source Activator SET ANGLE")
	ED_Mechanics_VoiceThrowAimed_Spell.RemoteCast(self, playerRef, __aimTarget)
	;debug.Trace("Everdamned DEBUG: Throw Voice Source Activator CAST aimed spell")
	;utility.wait(0.2)
	;debug.Trace("Everdamned DEBUG: Throw Voice Source Activator WAITED")
	__aimTarget.Delete()
	self.Delete()
	
	;debug.Trace("Everdamned DEBUG: Throw Voice Source Activator DELETED")
endFunction

actor property playerRef auto
spell property ED_Mechanics_VoiceThrowAimed_Spell auto
activator property FXEmptyActivator auto
