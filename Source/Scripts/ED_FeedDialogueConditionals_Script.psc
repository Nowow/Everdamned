Scriptname ED_FeedDialogueConditionals_Script extends Quest  Conditional

int property LastScore auto conditional
int property LastScore_Category auto conditional

bool property Bonus_Dibella auto conditional
bool property Bonus_DibellaAmulet auto conditional
bool property Bonus_Clothes auto conditional
bool property Bonus_Thane auto conditional
bool property Bonus_HighRelationship auto conditional
bool property Bonus_Faction auto conditional
bool property Bonus_GiftOfCharity auto conditional
bool property Bonus_IllusionMood auto conditional
bool property Bonus_SpeechPerks auto conditional

bool property Penalty_AIData auto conditional
bool property Penalty_TargetHasSomeone auto conditional
bool property Penalty_Faction auto conditional
bool property Penalty_LowRelationship auto conditional


function ResetFlags()
	Bonus_Dibella = false
	Bonus_DibellaAmulet = false
	Bonus_Clothes = false
	Bonus_Thane = false
	Bonus_HighRelationship = false
	Bonus_Faction = false
	Penalty_AIData = false
	Penalty_TargetHasSomeone = false
	Penalty_Faction = false
	Penalty_LowRelationship = false
	Bonus_GiftOfCharity = false
	Bonus_IllusionMood = false
	Bonus_SpeechPerks = false
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue conditional flags were reset!")
endfunction


function SetLastScore(int score)
	LastScore = score
	if score >= 30
		LastScore_Category = 1
	elseif score >= 0
		LastScore_Category = 2
	elseif score >= -30
		LastScore_Category = 3
	else
		LastScore_Category = 4
	endif
	
	debug.Trace("Everdamned DEBUG: Feed Dialogue LastScore: " + LastScore + ", Category: " + LastScore_Category)
endfunction
