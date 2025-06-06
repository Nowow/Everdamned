Scriptname ED_BorrowedTime_Script extends ActiveMagicEffect  


spell property ED_Misc_Spell_StaggerSelf_Spell auto
sound property ED_Art_SoundM_HellsBells auto
imagespacemodifier property ED_Art_Imod_RedWave_BloodAnkh auto
;perk property SCS_PerkTree_280_Perk_VampireLord_Mortal_StarvingArtist auto
keyword property ActorTypeNPC auto
float property XPgained auto


Float HPStart
Actor TheTarget
Actor PlayerRef



function OnUpdate()

	if !TheTarget.IsDead()
		Float DamageDealt = (HPStart - TheTarget.GetActorValue("Health")) * (100.0 - TheTarget.GetActorValue("MagicResist")) / 100.0
		if DamageDealt > 0.0
			ED_Misc_Spell_StaggerSelf_Spell.Cast(TheTarget as objectreference, none)
			ED_Art_SoundM_HellsBells.Play(TheTarget as objectreference)
			ED_Art_Imod_RedWave_BloodAnkh.Apply(1.0)
			TheTarget.DamageActorValue("Health", DamageDealt)
;			if PlayerRef.HasPerk(SCS_PerkTree_280_Perk_VampireLord_Mortal_StarvingArtist) && TheTarget.HasKeyword(ActorTypeNPC)
;				TheTarget.DamageActorValue("Health", DamageDealt * 0.250000)
;				PlayerRef.RestoreActorValue("Health", DamageDealt * 0.250000)
;			endIf
		endIf
	endIf
	CustomSkills.AdvanceSkill("EverdamnedMain", XPgained)
	self.Dispel()
endFunction


function OnEffectStart(Actor akTarget, Actor akCaster)

	HPStart = akTarget.GetActorValue("Health")
	self.RegisterForSingleUpdate(19.5000)
	TheTarget = akTarget
	PlayerRef = akCaster
endFunction

