Scriptname ED_LordsServant_Command_Script extends activemagiceffect  

Faction Property CharmFaction Auto
bool Property bMakePlayerTeammate = false Auto
spell property ED_VampireSpellsVL_LordsServant_Spell auto
keyword property ED_Mechanics_Keyword_LordsServantCommand auto
ReferenceAlias Property CommandedRef Auto
VisualEffect Property DominateUndeadVFX  Auto  

actor _caster
actor _target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	_caster = akCaster
	_target = akTarget
	
	debug.trace("Everdamned DEBUG: Lord's Servant Command effect started on " + akTarget)
	actor prevRef = CommandedRef.GetReference() as Actor
	CommandedRef.ForceRefTo(akTarget)
	
	if prevRef == akTarget
		debug.Trace("Everdamned INFO: Lord's Servant Command effect to the same actor, so its a recast, do nothing")
		return
	endif
	if prevRef != none && prevRef != akTarget
		debug.Trace("Everdamned INFO: Lord's Servant Command effect applied while command reference still filled by other actor, dispelling")
		prevRef.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell)
	endif
	
	debug.Trace("Everdamned INFO: Lord's Servant Command effect controls applied to " + akTarget)
	
	DominateUndeadVFX.Play(akTarget)
	akTarget.AddToFaction(CharmFaction)
	akCaster.StopCombat()
	akTarget.StopCombat()
	if bMakePlayerTeammate
		akTarget.SetPlayerTeammate(true, false)
	endif
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	;cheeky innit
	;to allow recasted effect settle in
	utility.wait(0.5)
	
	debug.Trace("Everdamned INFO: Lord's Servant Command on " + _target + " effect finish after delay started")
	; means effect expired or got dispeled, not recast
	if !(_target.HasMagicEffectWithKeyword(ED_Mechanics_Keyword_LordsServantCommand))
		debug.Trace("Everdamned INFO: Lord's Servant Command effect on " + _target + " expired or dispelled")
		actor currentRef = CommandedRef.GetReference() as Actor	
		; means effect was expired, need clear ref
		if currentRef == _target
			debug.Trace("Everdamned INFO: Lord's Servant Command effect on " + _target + " expired, clearing ref")
			CommandedRef.Clear()
		endif
		; actual dispel
		DominateUndeadVFX.Stop(akTarget)
		_target.RemoveFromFaction(CharmFaction)
		if bMakePlayerTeammate
			_target.SetPlayerTeammate(false, false)
		endif
		_target.StopCombat()
	endif
	
EndEvent


