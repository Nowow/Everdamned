Scriptname ED_ApplyZombieCloak_Script extends activemagiceffect  

function OnEffectStart(Actor akTarget, Actor akCaster)
	utility.wait(utility.randomfloat(1.0,2.5))
	ED_VampireSpells_BloodBrand_ZombieCloak_Spell.Cast(akTarget, akTarget)
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
endFunction

float property XPgained auto

SPELL Property ED_VampireSpells_BloodBrand_ZombieCloak_Spell  Auto  
