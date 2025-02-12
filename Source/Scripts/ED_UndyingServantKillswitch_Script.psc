Scriptname ED_UndyingServantKillswitch_Script extends activemagiceffect  


function OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.Trace("Everdamned DEBUG: Undying Servant ability ended on " + akTarget)
	if !(akTarget.HasKeyword(ED_Mechanics_Keyword_UndyingServant)) && !(akTarget.IsDead())
		debug.Trace("Everdamned DEBUG: It was alive and not in Undying Servant alias, so we killed it")
		akTarget.Kill()
	endif
endFunction

keyword property ED_Mechanics_Keyword_UndyingServant auto
