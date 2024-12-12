Scriptname ED_IcyWinds_Script extends activemagiceffect  

float property StartOffset Auto
float property SpawnRate Auto
float property ReleaseChargeTime Auto

actor _target

function OnEffectStart(Actor akTarget, Actor akCaster)
	_target = akTarget
	RegisterForSingleUpdate(StartOffset)
	utility.wait(1.0)
	ED_Art_VFX_IcyWinds_WispyCloud.Play(_target)
	SnowStormParticleGeometry.apply(StartOffset)
endfunction

event OnUpdate()
	Debug.Trace("ED_IcyWindsSelf actor value: " + _target.getactorvalue("ED_IcyWindsSelf"))
	ED_VampireSpellsVL_IcyWinds_FrostHazard_Spell.Cast(_target)
	RegisterForSingleUpdate(SpawnRate)
endevent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	ED_Art_VFX_IcyWinds_WispyCloud.Stop(_target)
	SnowStormParticleGeometry.remove(2.0)
	
	if akTarget.GetActorValue("ED_IcyWindsSelf") <= ReleaseChargeTime
		ED_VampireSpellsVL_IcyWinds_Release_Spell.Cast(akTarget)
	endif 
	
	_target.restoreactorvalue("ED_IcyWindsSelf", 9999.0)
endfunction

ShaderParticleGeometry property SnowStormParticleGeometry auto
SPELL Property ED_VampireSpellsVL_IcyWinds_FrostHazard_Spell  Auto  
SPELL Property ED_VampireSpellsVL_IcyWinds_Release_Spell  Auto  
VisualEffect property ED_Art_VFX_IcyWinds_WispyCloud auto 