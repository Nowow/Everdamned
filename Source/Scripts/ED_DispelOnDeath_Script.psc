Scriptname ED_DispelOnDeath_Script extends activemagiceffect  


Event OnDying(Actor akKiller)
	debug.Trace("Everdamned DEBUG: AAAAAAAAAAA")
	self.dispel()
endevent

