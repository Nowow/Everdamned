Scriptname ED_ZombieCloakProc_Script extends activemagiceffect  

function OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.DispelSpell(ED_VampireSpells_BloodBrand_ZombieCloak_Spell)
	ED_Misc_SpitBoilingBlood_Spell.Cast(akCaster, akTarget)
endFunction

SPELL Property ED_Misc_SpitBoilingBlood_Spell  Auto  
SPELL Property ED_VampireSpells_BloodBrand_ZombieCloak_Spell Auto
