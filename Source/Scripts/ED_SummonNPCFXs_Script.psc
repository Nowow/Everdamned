Scriptname ED_SummonNPCFXs_Script extends ObjectReference  

Event OnLoad()
	if AbFX
		AbFX.play(self)
	endif
endevent

EVENT onDying(actor myKiller)

	AtronachUnsummonDeathFXS.Play(self)
	if DeathSound
		DeathSound.Play(self)
	endif
ENDEVENT

effectshader property AtronachUnsummonDeathFXS auto
effectshader property AbFX auto
sound property DeathSound auto
