Scriptname ED_LordsServant_Command_Script extends activemagiceffect  


bool Property bMakePlayerTeammate = false Auto
float property XPgained auto

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
	
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	
	if prevRef != none && prevRef != akTarget
		debug.Trace("Everdamned INFO: Lord's Servant Command effect applied while command reference still filled by other actor, dispelling")
		prevRef.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell_CommandUndead)
	endif
	
	debug.Trace("Everdamned INFO: Lord's Servant Command effect controls applied to " + akTarget)
	
	ED_Art_VFX_CommandUndead_Bound.Play(akTarget)
	akTarget.AddToFaction(CharmFaction)
	;akCaster.StopCombat()
	akTarget.StopCombat()
	if bMakePlayerTeammate
		akTarget.SetPlayerTeammate(true, false)
	endif
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

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
		ED_Art_VFX_CommandUndead_Bound.Stop(akTarget)
		_target.RemoveFromFaction(CharmFaction)
		if bMakePlayerTeammate
			_target.SetPlayerTeammate(false, false)
		endif
		_target.StopCombat()
	endif
	
EndEvent

bool __lock
event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
	if __lock
		return
	endif
	__lock = true
	
	if akAggressor == _caster
		debug.Trace("Everdamned DEBUG: Command Undead was detected a friendly hit, checking whether is hostile")
		if akSource as weapon
			debug.Trace("Everdamned DEBUG: Command Undead was detected was hit with a weapon, scandalous!")
			_target.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell_CommandUndead)
		elseif akSource as spell
			if (akSource as spell).IsHostile()
				debug.Trace("Everdamned DEBUG: Command Undead was detected was hit with a hostile spell, scandalous!")
				_target.DispelSpell(ED_VampireSpellsVL_LordsServant_Spell_CommandUndead)
			endif
		endif
	endif
	__lock = false
endevent



Faction Property CharmFaction Auto
spell property ED_VampireSpellsVL_LordsServant_Spell_CommandUndead auto
keyword property ED_Mechanics_Keyword_LordsServantCommand auto
ReferenceAlias Property CommandedRef Auto
VisualEffect Property ED_Art_VFX_CommandUndead_Bound  Auto
