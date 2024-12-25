Scriptname ED_RoyalGuardianQuest_Script extends Quest  

actorbase property ED_Actor_RoyalGuardian_DeathHound auto
referencealias Property ED_Attacker auto
actor property playerRef auto
spell Property ED_VampirePowersVL_RoyalGuardian_SummonDummy_Spell auto
spell Property ED_Misc_Spell_DogAmbushKnockbackEnabled auto
effectshader Property UnsummonDeathFXS auto

;activator property FXEmptyActivator auto
explosion property ED_Art_Explosion_SummonUndead auto

actor _attacker
actor _dog

function FindNearestAttackerAndSicDog()
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest: FindNearestAttackerAndSicDog() called")
	_attacker = ED_Attacker.GetReference() as actor
	NetImmerse.SetNodeScale(_attacker, "NPC Head [Head]", 5.0, false)
	
	;ED_VampirePowersVL_RoyalGuardian_SummonDummy_Spell.Cast(playerRef, _attacker)
	
	_dog = (_attacker.placeatme(ED_Actor_RoyalGuardian_DeathHound, 1, false, true)) as actor
	HandleDogPlaced()
endfunction


function HandleDogPlaced()
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest HandleDogPlaced() called")
	_dog.placeatme(ED_Art_Explosion_SummonUndead)
	_dog.enablenowait(true)
	_dog.SetAlpha(0.0)
	_dog.IgnoreFriendlyHits(true)
	_dog.SetRestrained(true)
	utility.wait(0.5)
	_dog.SetAlpha(1.0, true)
	_dog.StopCombat()
	;utility.wait(0.1)
	_dog.SetAngle(_dog.GetAngleX(), _dog.GetAngleY(), _dog.GetAngleZ() + _dog.GetHeadingAngle(_attacker))
	_dog.StartCombat(_attacker)
	_dog.DoCombatSpellApply(ED_Misc_Spell_DogAmbushKnockbackEnabled, _dog)
	_dog.SetRestrained(false)
	
endfunction

function GetRidOfDog()
	debug.Trace("Everdamned DEBUG: Royal Guardian Quest: GetRidOfDog() called")
	if _dog != None
		debug.Trace("Everdamned DEBUG: Royal Guardian Quest: during GetRidOfDog() the _dog was not None!")
		_dog.SetCriticalStage(_dog.CritStage_DisintegrateStart)
		UnsummonDeathFXS.Play(_dog as objectreference, 3.00000)
		utility.Wait(2.75000)
		_dog.SetAlpha(0.000000, true)
		_dog.SetCriticalStage(_dog.CritStage_DisintegrateEnd)
		_dog.Delete()
		_dog = None
	endif
endfunction

