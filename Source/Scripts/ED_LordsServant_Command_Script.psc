Scriptname ED_LordsServant_Command_Script extends activemagiceffect  

Faction Property CharmFaction Auto
bool Property bMakePlayerTeammate = false Auto
spell property ED_VampireSpellsVL_LordsServant_Spell auto
spell property ED_VampireSpellsVL_LordsServant_Command_Effect auto
keyword property ED_Mechanics_Keyword_LordsServantCommand auto
ReferenceAlias Property CommandedRef  Auto  

actor _caster
actor _target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	_caster = akCaster
	_target = akTarget
	
	actor prevRef = CommandedRef.GetReference() as Actor
	CommandedRef.ForceRefTo(akTarget)
	if prevRef == none
		akTarget.AddToFaction(CharmFaction)
		akCaster.StopCombat()
		akTarget.StopCombat()
		if bMakePlayerTeammate
			akTarget.SetPlayerTeammate(true, false)
		endif
	elseif prevRef != akTarget
		debug.Trace("Everdamned INFO: Lord's Servant Command effect applied while command reference still filled, dispelling")
		prevRef.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell)
	endif
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	;cheeky innit
	;to allow recasted effect settle in
	utility.wait(0.5)
	
	; means effect expired or got dispeled, not recast
	if !(_target.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_LordsServantCommand))
		actor currentRef = CommandedRef.GetReference() as Actor	
		; means effect was expired, need clear ref
		if currentRef == _target
			CommandedRef.Clear()
		endif
		; actual dispel
		_target.RemoveFromFaction(CharmFaction)
		if bMakePlayerTeammate
			_target.SetPlayerTeammate(false, false)
		endif
	endif
	
EndEvent
