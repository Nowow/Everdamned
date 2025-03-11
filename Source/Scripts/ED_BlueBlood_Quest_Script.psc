Scriptname ED_BlueBlood_Quest_Script extends Quest  

formlist property ED_Mechanics_BlueBlood_FormList auto
formlist property ED_Mechanics_BlueBlood_Track_FormList auto
perk property ED_PerkTree_General_40_EmbraceTheBeast_Perk auto
message property ED_Mechanics_BlueBlood_OnVIPFeeding_Message auto

int property VIPsTasted auto
int property VIPsUntilEmbraceTheBeast auto

actor property playerRef auto

function InitFeedList()

	Int i = 0
	while i < ED_Mechanics_BlueBlood_FormList.GetSize()
		ED_Mechanics_BlueBlood_Track_FormList.AddForm(ED_Mechanics_BlueBlood_FormList.GetAt(i))
		i += 1
	endWhile
	debug.Trace("Everdamned INFO: Blue Blood track list initialized")
endFunction

function ProcessVIP(actorbase TheVIP)
	
	ED_Mechanics_BlueBlood_OnVIPFeeding_Message.Show()

	;TODO: add ebony warrior as hidden?
	
	VIPsTasted += 1
	if VIPsTasted == VIPsUntilEmbraceTheBeast
		playerRef.addperk(ED_PerkTree_General_40_EmbraceTheBeast_Perk)
		setstage(150)
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
		game.IncrementSkillBy("Conjuration", 2)
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
