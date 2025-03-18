Scriptname ED_BlueBlood_Quest_Script extends Quest  


int property Reward_ChainedBeast = 2 auto
int property Reward_EmbraceTheBeast = 8 auto
int property Reward_PerkPoints = 10 auto
int property ThatMuchPerkPoints = 4 auto

int property VIPsTasted auto


function InitFeedList()

	Int i = 0
	while i < ED_Mechanics_BlueBlood_FormList.GetSize()
		ED_Mechanics_BlueBlood_Track_FormList.AddForm(ED_Mechanics_BlueBlood_FormList.GetAt(i))
		i += 1
	endWhile
	debug.Trace("Everdamned INFO: Blue Blood track list initialized")
endFunction

function ProcessVIP(actorbase TheVIP)
	
	ED_Mechanics_BlueBlood_Message_OnVIPFeeding.Show()

	;TODO: add ebony warrior as hidden?

	VIPsTasted += 1
	
	if     VIPsTasted == Reward_ChainedBeast
		playerRef.addperk(ED_Mechanics_Ab_ChainedBeast_Perk)
		playerRef.addspell(ED_Mechanics_Ab_ChainedBeast_Spell)
		debug.Trace("Everdamned DEBUG: Blue Blood quest rewarded player with Chained Beast")
		
	elseif VIPsTasted == Reward_EmbraceTheBeast
		playerRef.addperk(ED_Mechanics_Ab_ChainedBeast_EmbraceTheBeast_Perk)
		setstage(150)
		debug.Trace("Everdamned DEBUG: Blue Blood quest rewarded player with Embrace The Beast")
		
	elseif VIPsTasted == Reward_PerkPoints
		game.AddPerkPoints(ThatMuchPerkPoints)
		ED_Mechanics_BlueBlood_Message_PerkPointsAdded.Show()
		debug.Trace("Everdamned DEBUG: Blue Blood quest rewarded player with Perk Points")
	endif
	
	
	
	if TheVIP == TitusMedeII
		game.IncrementSkillBy("Speechcraft", 5)
		ED_Mechanics_BlueBlood_Message_TitusMedeII.Show()
	elseif TheVIP == Ulfric
		game.IncrementSkillBy("Block", 2)
		game.IncrementSkillBy("HeavyArmor", 2)
		ED_Mechanics_BlueBlood_Message_Ulfric.Show()
		
	elseif TheVIP == Delphine
		game.IncrementSkillBy("Marksman", 3)
		game.IncrementSkillBy("Alchemy", 2)
		ED_Mechanics_BlueBlood_Message_Delphine.Show()
		;archery
		;alchemy
	elseif TheVIP == SavosAren
		game.IncrementSkillBy("Alteration", 1)
		game.IncrementSkillBy("Destruction", 1)
		game.IncrementSkillBy("Conjuration", 1)
		game.IncrementSkillBy("Illusion", 1)
		ED_Mechanics_BlueBlood_Message_SavosAren.Show()
	elseif TheVIP == Astrid
		game.IncrementSkillBy("Sneak", 2)
		game.IncrementSkillBy("OneHanded", 2)
		ED_Mechanics_BlueBlood_Message_Astrid.Show()
		;sneak
		;one-handed
	elseif TheVIP == MercerFrey
		game.IncrementSkillBy("Lockpicking", 2)
		game.IncrementSkillBy("LightArmor", 2)
		ED_Mechanics_BlueBlood_Message_MercerFrey.Show()
		;lockpick
		;light-armor
	elseif TheVIP == DLC1Isran
		game.IncrementSkillBy("TwoHanded", 2)
		game.IncrementSkillBy("Restoration", 2)
		ED_Mechanics_BlueBlood_Message_Isran.Show()
		;two handed
		;restoration
	elseif TheVIP == Elenwen
		game.IncrementSkillBy("Speechcraft", 3)
		game.IncrementSkillBy("Illusion", 2)
		ED_Mechanics_BlueBlood_Message_Elenwen.Show()
		;desctruction
		;illusion
	elseif TheVIP == Arngeir
		game.IncrementSkillBy("Speechcraft", 4)
		game.IncrementSkillBy("Smithing", 4)
		ED_Mechanics_BlueBlood_Message_Arngeir.Show()
		;speechcraft
		;smithing
	elseif TheVIP == Linwe
		game.IncrementSkillBy("Lockpicking", 2)
		game.IncrementSkillBy("Pickpocket", 2)
		ED_Mechanics_BlueBlood_Message_Linwe.Show()
		;lockpick
		;pickpocket
	elseif TheVIP == DLC1AlthadanVyrthur
		game.IncrementSkillBy("Restoration", 2)
		game.IncrementSkillBy("Destruction", 2)
		ED_Mechanics_BlueBlood_Message_Vyrthur.Show()
		;restoration
		;conjuration
	elseif TheVIP == Karliah
		game.IncrementSkillBy("Marksman", 2)
		game.IncrementSkillBy("Sneak", 2)
		ED_Mechanics_BlueBlood_Message_Karliah.Show()
		;archery
		;sneak
	elseif TheVIP == GeneralTullius
		game.IncrementSkillBy("OneHanded", 2)
		game.IncrementSkillBy("HeavyArmor", 2)
		ED_Mechanics_BlueBlood_Message_GeneralTullius.Show()
		;one-handed
		;heavy armor
	elseif TheVIP == KodlakWhitemane
		game.IncrementSkillBy("HeavyArmor", 2)
		game.IncrementSkillBy("Block", 2)
		ED_Mechanics_BlueBlood_Message_Kodlak.Show()
		;heavy armor
		;block
	endif
	
	;TODO: during sleep, implement check for dead targets
	; or do an alias ability that triggers on death and removes them from track list
	Int RemainingSize = ED_Mechanics_BlueBlood_Track_FormList.GetSize()
	debug.Trace("Everdamned INFO: Targets remaining in Blue Blood track list: " + RemainingSize)
	if RemainingSize == 0
		debug.Trace("Everdamned INFO: No targets left in track list, finishing Blue Blood quest")
		self.SetStage(200)
	endIf
endfunction


spell property ED_Mechanics_Ab_ChainedBeast_Spell auto
perk property ED_Mechanics_Ab_ChainedBeast_Perk auto
perk property ED_Mechanics_Ab_ChainedBeast_EmbraceTheBeast_Perk auto

actor property playerRef auto
formlist property ED_Mechanics_BlueBlood_FormList auto
formlist property ED_Mechanics_BlueBlood_Track_FormList auto


message property ED_Mechanics_BlueBlood_Message_OnVIPFeeding auto
message property ED_Mechanics_BlueBlood_Message_PerkPointsAdded auto


actorbase property TitusMedeII auto
actorbase property Ulfric auto
actorbase property Delphine auto
actorbase property SavosAren auto
actorbase property Astrid auto
actorbase property MercerFrey auto
actorbase property DLC1Isran auto
actorbase property Elenwen auto
actorbase property Arngeir auto
actorbase property Linwe auto
actorbase property DLC1AlthadanVyrthur auto
actorbase property Karliah auto
actorbase property GeneralTullius auto
actorbase property KodlakWhitemane auto

message property ED_Mechanics_BlueBlood_Message_TitusMedeII auto
message property ED_Mechanics_BlueBlood_Message_Ulfric auto
message property ED_Mechanics_BlueBlood_Message_Delphine auto
message property ED_Mechanics_BlueBlood_Message_SavosAren auto
message property ED_Mechanics_BlueBlood_Message_Astrid auto
message property ED_Mechanics_BlueBlood_Message_MercerFrey auto
message property ED_Mechanics_BlueBlood_Message_Isran auto
message property ED_Mechanics_BlueBlood_Message_Elenwen auto
message property ED_Mechanics_BlueBlood_Message_Arngeir auto
message property ED_Mechanics_BlueBlood_Message_Linwe auto
message property ED_Mechanics_BlueBlood_Message_Vyrthur auto
message property ED_Mechanics_BlueBlood_Message_Karliah auto
message property ED_Mechanics_BlueBlood_Message_GeneralTullius auto
message property ED_Mechanics_BlueBlood_Message_Kodlak auto
