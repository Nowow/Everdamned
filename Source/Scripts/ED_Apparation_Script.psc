Scriptname ED_Apparation_Script extends activemagiceffect  

actor __TheSpawn

event OnEffectStart(Actor Target, Actor Caster)
	__TheSpawn = Target.placeatme(ED_Mechanics_Ghost_Spider_NPC) as actor
endevent


event OnEffectFinish(Actor Target, Actor Caster)
	
	__TheSpawn.SetCriticalStage(__TheSpawn.CritStage_DisintegrateStart)
	__TheSpawn.SetAlpha(0.000000, true)
	__TheSpawn.kill()
	utility.wait(0.5)
	__TheSpawn.SetCriticalStage(__TheSpawn.CritStage_DisintegrateEnd)
	__TheSpawn = none
endevent

actorbase property ED_Mechanics_Ghost_Spider_NPC auto

