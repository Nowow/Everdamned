Scriptname ED_ThrowVoiceAimedActivator_Script extends ObjectReference  

bool loaded

function OnLoad()
	
	if loaded
		debug.Trace("Everdamned DEBUG: Throw Voice AIMED Activator ALREADY loaded WTF")
		return
	endif
	
	loaded = true

	;debug.Trace("Everdamned DEBUG: Throw Voice Aimed Activator LOADED")
	;utility.wait(0.2)
	ED_Mechanics_VoiceThrowVoice_Spell.RemoteCast(self, playerRef, self)
	
	;debug.Trace("Everdamned DEBUG: Throw Voice Aimed Activator CASTED")
	;utility.wait(0.2)
	self.Delete()
endFunction

spell property ED_Mechanics_VoiceThrowVoice_Spell auto
actor property playerRef auto
