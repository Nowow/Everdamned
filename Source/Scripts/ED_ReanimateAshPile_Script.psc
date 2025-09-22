Scriptname ED_ReanimateAshPile_Script extends activemagiceffect  


actor victim
bool AshPileCreated


Event OnEffectStart(Actor Target, Actor Caster)
	victim = Target
EndEvent


function TurnToAsh()	
	victim.SetCriticalStage(Victim.CritStage_DisintegrateStart)
	if	MagicEffectShader != none
		MagicEffectShader.play(Victim, 4.0)
	endif
	utility.wait(1.25)     
	Victim.AttachAshPile(AshPileObject)
	utility.wait(1.65)
	if	MagicEffectShader != none
		MagicEffectShader.stop(Victim)
	endif
	victim.SetCriticalStage(Victim.CritStage_DisintegrateEnd)
endfunction


Event OnDying(Actor Killer)

	if victim.HasMagicEffect(ED_VampireSpellsVL_Chokehold_Ankh_Effect)
		AshPileCreated = True
	elseif !AshPileCreated
		AshPileCreated = True
		TurnToAsh()
	endif
	
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

	if victim.HasMagicEffect(ED_VampireSpellsVL_Chokehold_Ankh_Effect)
		AshPileCreated = True
	elseif !AshPileCreated
		AshPileCreated = True
		TurnToAsh()
	endif

EndEvent


effectshader property MagicEffectShader auto
activator property AshPileObject auto
magiceffect property ED_VampireSpellsVL_Chokehold_Ankh_Effect auto
