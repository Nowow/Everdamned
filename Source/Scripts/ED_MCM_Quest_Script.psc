Scriptname ED_MCM_Quest_Script extends SKI_ConfigBase

; ------------------------------------------------------------
; Blood Meter

Int BloodMeter_Enable
float property Default_BloodMeter_Enable auto
GlobalVariable Property ED_Mechanics_BloodMeter_Enable_Global Auto  

Int BloodMeter_X
float property Default_BloodMeter_X auto
GlobalVariable Property ED_Mechanics_BloodMeter_X_Global  Auto  

Int BloodMeter_Y
float property Default_BloodMeter_Y auto
GlobalVariable Property ED_Mechanics_BloodMeter_Y_Global  Auto

Int BloodMeter_Scale
float property Default_BloodMeter_Scale auto
GlobalVariable Property ED_Mechanics_BloodMeter_Scale_Global Auto

int BloodMeter_Opacity
float property Default_BloodMeter_Opacity auto
GlobalVariable property ED_Mechanics_BloodMeter_Opacity_Global auto

int BloodMeter_OpacityAtRest
float property Default_BloodMeter_OpacityAtRest auto
GlobalVariable property ED_Mechanics_BloodMeter_Opacity_Global_AtRest auto

int BloodMeter_HideWhenFull
float property Default_BloodMeter_HideWhenFull auto
GlobalVariable property ED_Mechanics_BloodMeter_HideWhenAtRestFull_Global auto

int BloodMeter_FillDirection
int property Default_BloodMeter_FillDirection auto
GlobalVariable property ED_Mechanics_BloodMeter_FillDirection_Global auto

int BloodMeter_DisplayTime
int property Default_BloodMeter_DisplayTime auto
GlobalVariable property ED_Mechanics_BloodMeter_DisplayTime_Global auto

; ------------------------------------------------------------
; Hotkeys

int Hotkeys_TestKey
int property Default_Hotkeys_TestKey auto
GlobalVariable Property ED_Test_Hotkey Auto

int Hotkeys_HotkeyA
int property Default_Hotkeys_HotkeyA auto
GlobalVariable Property ED_Mechanics_Hotkeys_HotkeyA Auto

int Hotkeys_HotkeyB
int property Default_Hotkeys_HotkeyB auto
GlobalVariable Property ED_Mechanics_Hotkeys_HotkeyB Auto

; ------------------------------------------------------------
; Settings

Int Setting_SameSexPreference 
float property Default_Setting_SameSexPreference auto
GlobalVariable Property ED_Mechanics_Global_MCM_SameSexPreference Auto

Int Setting_CombatDrainAnim
float property Default_Setting_CombatDrainAnim auto
GlobalVariable Property ED_Mechanics_Global_MCM_CombatDrainAnim Auto

Int Setting_SeductionDialogueXPCooldownHours
float property Default_Setting_SeductionDialogueXPCooldownHours auto
GlobalVariable Property ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours Auto

Int Setting_LevelXPMult
float property Default_Setting_LevelXPMult auto
GlobalVariable Property ED_Mechanics_SkillTree_LevelXPMult_Global Auto

Int Setting_DisableBloodstarvedTint
float property Default_Setting_DisableBloodstarvedTint auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableBloodstarvedTint Auto

Int Setting_DisableDisintegrate
float property Default_Setting_DisableDisintegrate auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableDisintegrate Auto

Int Setting_NightSightMaxLevel
float property Default_Setting_NightSightMaxLevel auto
GlobalVariable Property ED_Mechanics_Global_MCM_NightSightMaxLevel Auto

Int Setting_NightSightMinLevel
float property Default_Setting_NightSightMinLevel auto
GlobalVariable Property ED_Mechanics_Global_MCM_NightSightMinLevel Auto

Int Setting_NightSightDisableAdaptive
float property Default_Setting_NightSightDisableAdaptive auto
GlobalVariable Property ED_Mechanics_Global_MCM_NightSightDisableAdaptive Auto

Int Setting_NightSightStrengthMult
float property Default_Setting_NightSightStrengthMult auto
GlobalVariable Property ED_Mechanics_Global_MCM_NightSightStrengthMult Auto

Int Setting_VampireSkillExpMult
float property Default_Setting_VampireSkillExpMult auto
GlobalVariable Property ED_Mechanics_SkillTree_XPMult_Global Auto

Int Setting_VampireAgeMult
float property Default_Setting_VampireAgeMult auto
GlobalVariable Property ED_Mechanics_VampireAgeExpMult Auto

Int Setting_EnableShadowRegen
float property Default_Setting_EnableShadowRegen auto
GlobalVariable Property ED_Mechanics_Global_EnableShadowRegen Auto

; ------------------------------------------------------------
; Rest

Int Cheats_NecromageToggle
float property Default_Cheats_NecromageToggle auto
GlobalVariable Property ED_Mechanics_Global_MCM_NecromageToggle Auto

Int Cheats_MasterOfTheMindToggle
float property Default_Cheats_MasterOfTheMindToggle auto
GlobalVariable Property ED_Mechanics_Global_MCM_MasterOfTheMindToggle Auto

Int Cheats_DisableHate
float property Default_Cheats_DisableHate auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableHate Auto

Int Cheats_DisableScorchingSun
float property Default_Cheats_DisableScorchingSun auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableScorchingSun Auto

Int Cheats_DisableAlchemyPenalty
float property Default_Cheats_DisableAlchemyPenalty auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableAlchemyPenalty Auto

Int Cheats_DisableChainedBeast
float property Default_Cheats_DisableChainedBeast auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableChainedBeast Auto

Int Cheats_ToggleArmorWatcherVL
float property Default_Cheats_ToggleArmorWatcherVL auto
GlobalVariable Property ED_Mechanics_Global_MCM_ToggleArmorWatcherVL Auto

Int Cheats_DisableFortitude
float property Default_Cheats_DisableFortitude auto
GlobalVariable Property ED_Mechanics_Global_MCM_DisableFortitudeRevive Auto

Int Cheats_ToggleExtractor
float property Default_Cheats_ToggleExtractor auto
GlobalVariable Property ED_Mechanics_Global_MCM_ExtractorToggle Auto

Int Cheats_AllureToggle
float property Default_Cheats_AllureToggle auto
GlobalVariable Property ED_Mechanics_Global_MCM_AllureToggle Auto

Int Cheats_PersuasionToggle
float property Default_Cheats_PersuasionToggle auto
GlobalVariable Property ED_Mechanics_Global_MCM_PersuasionToggle Auto


function OnPageReset(String akPage)

	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	
	; ------------------------------------------------------------
	; settings
	self.AddHeaderOption("Settings", 0)
	
	Setting_SameSexPreference = self.AddToggleOption("Same sex preference for seduction", ED_Mechanics_Global_MCM_SameSexPreference.GetValue() as Bool)
	Setting_CombatDrainAnim = self.AddSliderOption("Combat Drain type", ED_Mechanics_Global_MCM_CombatDrainAnim.GetValue(), "Type {0}")
	Setting_SeductionDialogueXPCooldownHours = self.AddSliderOption("Speech XP Seduction cooldown", ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.GetValue(), "{0} hours")
	Setting_LevelXPMult = self.AddSliderOption("Level XP gain mult", ED_Mechanics_SkillTree_LevelXPMult_Global.GetValue(), "{0} times")
	Setting_DisableBloodstarvedTint = self.AddToggleOption("No red tint when Blood Starved ", ED_Mechanics_Global_MCM_DisableBloodstarvedTint.GetValue() as Bool)
	Setting_DisableDisintegrate = self.AddToggleOption("No disintegrate on death ", ED_Mechanics_Global_MCM_DisableDisintegrate.GetValue() as Bool)
	Setting_VampireSkillExpMult = self.AddSliderOption("Vampire skill XP mult", ED_Mechanics_SkillTree_XPMult_Global.GetValue())
	Setting_VampireAgeMult = self.AddSliderOption("Vampire aging mult", ED_Mechanics_VampireAgeExpMult.GetValue())
	Setting_EnableShadowRegen = self.AddToggleOption("Light level based Sun Weakness", ED_Mechanics_Global_EnableShadowRegen.GetValue() as Bool)
	
	; ------------------------------------------------------------
	; Night Sight
	self.AddEmptyOption()
	self.AddHeaderOption("Night Sight", 0)
	Setting_NightSightMaxLevel = self.AddSliderOption("Strength max level", ED_Mechanics_Global_MCM_NightSightMaxLevel.GetValue())
	Setting_NightSightMinLevel = self.AddSliderOption("Strength min level", ED_Mechanics_Global_MCM_NightSightMinLevel.GetValue())
	Setting_NightSightDisableAdaptive = self.AddToggleOption("Disable adaptive strength", ED_Mechanics_Global_MCM_NightSightDisableAdaptive.GetValue() as Bool)
	Setting_NightSightStrengthMult = self.AddSliderOption("Strength %", ED_Mechanics_Global_MCM_NightSightStrengthMult.GetValue() * 100.0)
	
	; ------------------------------------------------------------
	; Blood Meter
	self.AddEmptyOption()
	self.AddHeaderOption("Vitae Bar", 0)
	;BloodMeter_Enable = self.AddToggleOption("Enable blood pool bar", ED_Mechanics_BloodMeter_Enable_Global.GetValue() as Bool)
	
	BloodMeter_X = self.AddSliderOption("Vitae bar X coordinate", ED_Mechanics_BloodMeter_X_Global.GetValue())
	BloodMeter_Y = self.AddSliderOption("Vitae bar Y coordinate", ED_Mechanics_BloodMeter_Y_Global.GetValue())
	BloodMeter_Scale = self.AddSliderOption("Vitae bar scale", ED_Mechanics_BloodMeter_Scale_Global.GetValue())
	BloodMeter_FillDirection = self.AddSliderOption("Vitae bar fill direction", ED_Mechanics_BloodMeter_FillDirection_Global.GetValue())
	BloodMeter_Opacity = self.AddSliderOption("Vitae bar opacity", ED_Mechanics_BloodMeter_Opacity_Global.GetValue())
	BloodMeter_OpacityAtRest = self.AddSliderOption("Vitae bar inactive opacity ", ED_Mechanics_BloodMeter_Opacity_Global_AtRest.GetValue())
	BloodMeter_HideWhenFull = self.AddToggleOption("Hide full inactive bar", ED_Mechanics_BloodMeter_HideWhenAtRestFull_Global.GetValue() as Bool)
	BloodMeter_DisplayTime = self.AddSliderOption("Seconds to fade when incative", ED_Mechanics_BloodMeter_DisplayTime_Global.GetValue(), "{0} seconds")
	
	; ------------------------------------------------------------
	; Hotkeys
	
	self.AddEmptyOption()
	self.SetCursorPosition(1)
	self.AddHeaderOption("Compatibility/Cheats", 0)
	
	Hotkeys_HotkeyA = AddKeyMapOption("Celerity Hotkey", ED_Mechanics_Hotkeys_HotkeyA.GetValue() as int)
	Hotkeys_HotkeyB = AddKeyMapOption("Potence Hotkey", ED_Mechanics_Hotkeys_HotkeyB.GetValue() as int)
	
	
	; ------------------------------------------------------------
	; cheats/compatibility
	
	self.AddEmptyOption()
	self.AddHeaderOption("Hotkeys", 0)
	
	Cheats_NecromageToggle = self.AddToggleOption("Disable Restoration healing penalty", ED_Mechanics_Global_MCM_NecromageToggle.GetValue() as Bool)
	Cheats_AllureToggle = self.AddToggleOption("Assume Allure perk", ED_Mechanics_Global_MCM_AllureToggle.GetValue() as Bool)
	Cheats_PersuasionToggle = self.AddToggleOption("Assume Persuasion perk", ED_Mechanics_Global_MCM_PersuasionToggle.GetValue() as Bool)
	Cheats_MasterOfTheMindToggle = self.AddToggleOption("Mimic Master of the Mind", ED_Mechanics_Global_MCM_MasterOfTheMindToggle.GetValue() as Bool)
	Cheats_DisableHate = self.AddToggleOption("Disable hate when Blood Starved", ED_Mechanics_Global_MCM_DisableHate.GetValue() as Bool)
	Cheats_DisableScorchingSun = self.AddToggleOption("Disable Sun burning", ED_Mechanics_Global_MCM_DisableScorchingSun.GetValue() as Bool)
	Cheats_DisableAlchemyPenalty = self.AddToggleOption("Disable penalty to Health restoring potions", ED_Mechanics_Global_MCM_DisableAlchemyPenalty.GetValue() as Bool)
	Cheats_DisableChainedBeast = self.AddToggleOption("Disable Fortitude transformation", ED_Mechanics_Global_MCM_DisableChainedBeast.GetValue() as Bool)
	Cheats_ToggleArmorWatcherVL = self.AddToggleOption("Toggle Equip Watcher for VL", ED_Mechanics_Global_MCM_ToggleArmorWatcherVL.GetValue() as Bool)
	Cheats_DisableFortitude = self.AddToggleOption("Toggle Fortitude", ED_Mechanics_Global_MCM_DisableFortitudeRevive.GetValue() as Bool)
	Cheats_ToggleExtractor = self.AddToggleOption("Force have blood extractor", ED_Mechanics_Global_MCM_ExtractorToggle.GetValue() as Bool)
	
	; ------------------------------------------------------------
	
	self.AddEmptyOption()
	
endFunction


; on pressing R for default i guess?
function OnOptionDefault(Int akOp)

	; ------------------------------------------------------------
	; Blood Meter
	If akOp == BloodMeter_X
		ED_Mechanics_BloodMeter_X_Global.SetValue(Default_BloodMeter_X as Float)
		self.SetSliderOptionValue(BloodMeter_X, Default_BloodMeter_X)
		
	elseif akOp == BloodMeter_Y
		ED_Mechanics_BloodMeter_Y_Global.SetValue(Default_BloodMeter_Y as Float)
		self.SetSliderOptionValue(BloodMeter_Y, Default_BloodMeter_Y)
		
	elseIf akOp == BloodMeter_Scale
		ED_Mechanics_BloodMeter_Scale_Global.SetValue(Default_BloodMeter_Scale as Float)
		self.SetSliderOptionValue(BloodMeter_Scale, Default_BloodMeter_Scale)
		
	elseIf akOp == BloodMeter_FillDirection
		ED_Mechanics_BloodMeter_FillDirection_Global.SetValue(Default_BloodMeter_FillDirection as Float)
		self.SetSliderOptionValue(BloodMeter_FillDirection, Default_BloodMeter_FillDirection as Float)
		
	elseIf akOp == BloodMeter_Opacity
		ED_Mechanics_BloodMeter_Opacity_Global.SetValue(Default_BloodMeter_Opacity as Float)
		self.SetSliderOptionValue(BloodMeter_Opacity, Default_BloodMeter_Opacity)
		
	elseIf akOp == BloodMeter_OpacityAtRest
		ED_Mechanics_BloodMeter_Opacity_Global_AtRest.SetValue(Default_BloodMeter_OpacityAtRest as Float)
		self.SetSliderOptionValue(BloodMeter_OpacityAtRest, Default_BloodMeter_OpacityAtRest)
	
	elseIf akOp == BloodMeter_DisplayTime
		ED_Mechanics_BloodMeter_DisplayTime_Global.SetValue(Default_BloodMeter_DisplayTime as Float)
		self.SetSliderOptionValue(BloodMeter_DisplayTime, Default_BloodMeter_DisplayTime as Float, "{0} seconds")
		
	elseIf akOp == BloodMeter_HideWhenFull
		ED_Mechanics_BloodMeter_HideWhenAtRestFull_Global.SetValue(Default_BloodMeter_HideWhenFull as Float)
		self.SetToggleOptionValue(BloodMeter_HideWhenFull, Default_BloodMeter_HideWhenFull as bool)
		
	elseIf akOp == BloodMeter_Enable
		ED_Mechanics_BloodMeter_Enable_Global.SetValue(Default_BloodMeter_Enable as Float)
		self.SetToggleOptionValue(BloodMeter_Enable, Default_BloodMeter_Enable as bool)
	
	; ------------------------------------------------------------
	; Hotkeys
	
	elseIf akOp == Hotkeys_TestKey
		AssignKey(ED_Test_Hotkey, Hotkeys_TestKey, Default_Hotkeys_TestKey, "", "")
	
	elseIf akOp == Hotkeys_HotkeyA
		AssignKey(ED_Mechanics_Hotkeys_HotkeyA, Hotkeys_HotkeyA, Default_Hotkeys_HotkeyA, "", "")
		
	elseIf akOp == Hotkeys_HotkeyB
		AssignKey(ED_Mechanics_Hotkeys_HotkeyB, Hotkeys_HotkeyB, Default_Hotkeys_HotkeyB, "", "")

	; ------------------------------------------------------------
	; settings
	
	elseIf akOp == Setting_SameSexPreference
		ED_Mechanics_Global_MCM_SameSexPreference.SetValue(Default_Setting_SameSexPreference)
		SetToggleOptionValue(Setting_SameSexPreference, Default_Setting_SameSexPreference as bool)
	
	elseIf akOp == Setting_CombatDrainAnim
		ED_Mechanics_Global_MCM_CombatDrainAnim.SetValue(Default_Setting_CombatDrainAnim as Float)
		self.SetSliderOptionValue(Setting_CombatDrainAnim, Default_Setting_CombatDrainAnim, "Type {0}")
	
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.SetValue(Default_Setting_SeductionDialogueXPCooldownHours as Float)
		self.SetSliderOptionValue(Setting_SeductionDialogueXPCooldownHours, Default_Setting_SeductionDialogueXPCooldownHours, "{0} hours")
	
	elseIf akOp == Setting_LevelXPMult
		ED_Mechanics_SkillTree_LevelXPMult_Global.SetValue(Default_Setting_LevelXPMult as Float)
		self.SetSliderOptionValue(Setting_LevelXPMult, Default_Setting_LevelXPMult, "{0} times")
		
	elseIf akOp == Setting_DisableBloodstarvedTint
		ED_Mechanics_Global_MCM_SameSexPreference.SetValue(Default_Setting_DisableBloodstarvedTint)
		SetToggleOptionValue(Setting_DisableBloodstarvedTint, Default_Setting_DisableBloodstarvedTint as bool)
		
	elseIf akOp == Setting_DisableDisintegrate
		ED_Mechanics_Global_MCM_DisableDisintegrate.SetValue(Default_Setting_DisableDisintegrate)
		SetToggleOptionValue(Setting_DisableDisintegrate, Default_Setting_DisableDisintegrate as bool)
	
	elseIf akOp == Setting_NightSightMaxLevel
		ED_Mechanics_Global_MCM_NightSightMaxLevel.SetValue(Default_Setting_NightSightMaxLevel as Float)
		self.SetSliderOptionValue(Setting_NightSightMaxLevel, Default_Setting_NightSightMaxLevel)
		
	elseIf akOp == Setting_NightSightMinLevel
		ED_Mechanics_Global_MCM_NightSightMinLevel.SetValue(Default_Setting_NightSightMinLevel as Float)
		self.SetSliderOptionValue(Setting_NightSightMinLevel, Default_Setting_NightSightMinLevel)
		
	elseIf akOp == Setting_NightSightDisableAdaptive
		ED_Mechanics_Global_MCM_NightSightDisableAdaptive.SetValue(Default_Setting_NightSightDisableAdaptive)
		SetToggleOptionValue(Setting_NightSightDisableAdaptive, Default_Setting_NightSightDisableAdaptive as bool)
		
	elseIf akOp == Setting_NightSightStrengthMult
		ED_Mechanics_Global_MCM_NightSightStrengthMult.SetValue(Default_Setting_NightSightStrengthMult as Float)
		self.SetSliderOptionValue(Setting_NightSightStrengthMult, Default_Setting_NightSightStrengthMult * 100.0)
	
	elseIf akOp == Setting_VampireSkillExpMult
		ED_Mechanics_SkillTree_XPMult_Global.SetValue(Default_Setting_VampireSkillExpMult as Float)
		self.SetSliderOptionValue(Setting_VampireSkillExpMult, Default_Setting_VampireSkillExpMult)
	
	elseIf akOp == Setting_VampireAgeMult
		ED_Mechanics_VampireAgeExpMult.SetValue(Default_Setting_VampireAgeMult as Float)
		self.SetSliderOptionValue(Setting_VampireAgeMult, Default_Setting_VampireAgeMult)
	
	elseIf akOp == Setting_EnableShadowRegen
		ED_Mechanics_Global_EnableShadowRegen.SetValue(Default_Setting_EnableShadowRegen as float)
		self.SetToggleOptionValue(Setting_EnableShadowRegen, Default_Setting_EnableShadowRegen as bool)

	; ------------------------------------------------------------
	; cheats
	
	elseIf akOp == Cheats_NecromageToggle
		ED_Mechanics_Global_MCM_NecromageToggle.SetValue(Default_Cheats_NecromageToggle)
		SetToggleOptionValue(Cheats_NecromageToggle, Default_Cheats_NecromageToggle as bool)
		
	elseIf akOp == Cheats_AllureToggle
		ED_Mechanics_Global_MCM_AllureToggle.SetValue(Default_Cheats_AllureToggle)
		SetToggleOptionValue(Cheats_AllureToggle, Default_Cheats_AllureToggle as bool)
		
	elseIf akOp == Cheats_PersuasionToggle
		ED_Mechanics_Global_MCM_PersuasionToggle.SetValue(Default_Cheats_PersuasionToggle)
		SetToggleOptionValue(Cheats_PersuasionToggle, Default_Cheats_PersuasionToggle as bool)
	
	elseIf akOp == Cheats_MasterOfTheMindToggle
		ED_Mechanics_Global_MCM_MasterOfTheMindToggle.SetValue(Default_Cheats_MasterOfTheMindToggle)
		SetToggleOptionValue(Cheats_MasterOfTheMindToggle, Default_Cheats_MasterOfTheMindToggle as bool)
		
	elseIf akOp == Cheats_DisableHate
		ED_Mechanics_Global_MCM_DisableHate.SetValue(Default_Cheats_DisableHate)
		SetToggleOptionValue(Cheats_DisableHate, Default_Cheats_DisableHate as bool)
	
	elseIf akOp == Cheats_DisableScorchingSun
		ED_Mechanics_Global_MCM_DisableScorchingSun.SetValue(Default_Cheats_DisableScorchingSun)
		SetToggleOptionValue(Cheats_DisableScorchingSun, Default_Cheats_DisableScorchingSun as bool)
		
	elseIf akOp == Cheats_DisableAlchemyPenalty
		ED_Mechanics_Global_MCM_DisableAlchemyPenalty.SetValue(Default_Cheats_DisableAlchemyPenalty)
		SetToggleOptionValue(Cheats_DisableAlchemyPenalty, Default_Cheats_DisableAlchemyPenalty as bool)
		
	elseIf akOp == Cheats_DisableChainedBeast
		ED_Mechanics_Global_MCM_DisableChainedBeast.SetValue(Default_Cheats_DisableChainedBeast)
		SetToggleOptionValue(Cheats_DisableChainedBeast, Default_Cheats_DisableChainedBeast as bool)
	
	elseIf akOp == Cheats_ToggleArmorWatcherVL
		ED_Mechanics_Global_MCM_ToggleArmorWatcherVL.SetValue(Default_Cheats_ToggleArmorWatcherVL)
		SetToggleOptionValue(Cheats_ToggleArmorWatcherVL, Default_Cheats_ToggleArmorWatcherVL as bool)
		
	elseIf akOp == Cheats_DisableFortitude
		ED_Mechanics_Global_MCM_DisableFortitudeRevive.SetValue(Default_Cheats_DisableFortitude)
		SetToggleOptionValue(Cheats_DisableFortitude, Default_Cheats_DisableFortitude as bool)
		
	elseIf akOp == Cheats_ToggleExtractor
		ED_Mechanics_Global_MCM_ExtractorToggle.SetValue(Default_Cheats_ToggleExtractor)
		SetToggleOptionValue(Cheats_ToggleExtractor, Default_Cheats_ToggleExtractor as bool)
		
	endif
	
	
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endfunction


function OnOptionSliderOpen(Int akOp)
	
	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodMeter_X
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_X_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_X)
		self.SetSliderDialogRange(0.0000, 1000.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_Y
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Y_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_Y)
		self.SetSliderDialogRange(50.000000, 700.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_Scale
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Scale_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_Scale)
		self.SetSliderDialogRange(10.000000, 200.0000)
		self.SetSliderDialogInterval(2.00000)
		
	elseIf akOp == BloodMeter_FillDirection
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_FillDirection_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_FillDirection as float)
		self.SetSliderDialogRange(0.000000, 2.0000)
		self.SetSliderDialogInterval(1.00000)
		
	elseIf akOp == BloodMeter_Opacity
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Opacity_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_Opacity)
		self.SetSliderDialogRange(0.000000, 100.0000)
		self.SetSliderDialogInterval(1.00000)
	
	elseIf akOp == BloodMeter_OpacityAtRest
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_Opacity_Global_AtRest.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_OpacityAtRest)
		self.SetSliderDialogRange(0.000000, 100.0000)
		self.SetSliderDialogInterval(1.00000)
		
	elseIf akOp == BloodMeter_DisplayTime
		self.SetSliderDialogStartValue(ED_Mechanics_BloodMeter_DisplayTime_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_BloodMeter_DisplayTime as Float)
		self.SetSliderDialogRange(0.000000, 20.0000)
		self.SetSliderDialogInterval(1.0)

	; ------------------------------------------------------------
	; settings
	
	elseIf akOp == Setting_CombatDrainAnim
		self.SetSliderDialogStartValue(ED_Mechanics_Global_MCM_CombatDrainAnim.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_CombatDrainAnim)
		self.SetSliderDialogRange(1.000000, 3.0000)
		self.SetSliderDialogInterval(1.00000)
		
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		self.SetSliderDialogStartValue(ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_SeductionDialogueXPCooldownHours)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(1.00000)
		
	elseIf akOp == Setting_LevelXPMult
		self.SetSliderDialogStartValue(ED_Mechanics_SkillTree_LevelXPMult_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_LevelXPMult)
		self.SetSliderDialogRange(0.000000, 4.0000)
		self.SetSliderDialogInterval(0.10000)
		
	elseIf akOp == Setting_NightSightMaxLevel
		self.SetSliderDialogStartValue(ED_Mechanics_Global_MCM_NightSightMaxLevel.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_NightSightMaxLevel)
		self.SetSliderDialogRange(1.0, 5.0)
		self.SetSliderDialogInterval(1.0)
		
	elseIf akOp == Setting_NightSightMinLevel
		self.SetSliderDialogStartValue(ED_Mechanics_Global_MCM_NightSightMinLevel.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_NightSightMinLevel)
		self.SetSliderDialogRange(1.0, 5.0)
		self.SetSliderDialogInterval(1.0)
	
	elseIf akOp == Setting_NightSightStrengthMult
		self.SetSliderDialogStartValue(ED_Mechanics_Global_MCM_NightSightStrengthMult.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_NightSightStrengthMult * 100.0)
		self.SetSliderDialogRange(50, 200)
		self.SetSliderDialogInterval(1)
		
	elseIf akOp == Setting_VampireSkillExpMult
		self.SetSliderDialogStartValue(ED_Mechanics_SkillTree_XPMult_Global.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_VampireSkillExpMult)
		self.SetSliderDialogRange(0.1, 5.0)
		self.SetSliderDialogInterval(0.1)
		
	elseIf akOp == Setting_VampireAgeMult
		self.SetSliderDialogStartValue(ED_Mechanics_VampireAgeExpMult.GetValue())
		self.SetSliderDialogDefaultValue(Default_Setting_VampireAgeMult)
		self.SetSliderDialogRange(0.1, 5.0)
		self.SetSliderDialogInterval(0.1)
	
	; ------------------------------------------------------------
	
	endIf
	
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endFunction

function OnOptionSliderAccept(Int akOp, Float akValue)

	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodMeter_X
		ED_Mechanics_BloodMeter_X_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_X, akValue)
	
	elseIf akOp == BloodMeter_Y
		ED_Mechanics_BloodMeter_Y_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_Y, akValue)
		
	elseIf akOp == BloodMeter_Scale
		ED_Mechanics_BloodMeter_Scale_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_Scale, akValue)
	
	elseIf akOp == BloodMeter_FillDirection
		ED_Mechanics_BloodMeter_FillDirection_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_FillDirection, akValue)
		
	elseIf akOp == BloodMeter_Opacity
		ED_Mechanics_BloodMeter_Opacity_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_Opacity, akValue)
		
	elseIf akOp == BloodMeter_OpacityAtRest
		ED_Mechanics_BloodMeter_Opacity_Global_AtRest.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_OpacityAtRest, akValue)
	
	elseIf akOp == BloodMeter_DisplayTime
		ED_Mechanics_BloodMeter_DisplayTime_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_DisplayTime, akValue, "{0} seconds")
		
	; ------------------------------------------------------------
	; settings
	
	elseIf akOp == Setting_CombatDrainAnim
		ED_Mechanics_Global_MCM_CombatDrainAnim.SetValue(akValue)
		self.SetSliderOptionValue(Setting_CombatDrainAnim, akValue, "Type {0}")
	
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.SetValue(akValue)
		self.SetSliderOptionValue(Setting_SeductionDialogueXPCooldownHours, akValue, "{0} hours")
		
	elseIf akOp == Setting_LevelXPMult
		ED_Mechanics_SkillTree_LevelXPMult_Global.SetValue(akValue)
		self.SetSliderOptionValue(Setting_LevelXPMult, akValue, "{0} times")
		
	elseIf akOp == Setting_NightSightMaxLevel
		if akValue < ED_Mechanics_Global_MCM_NightSightMinLevel.GetValue()
			akValue = ED_Mechanics_Global_MCM_NightSightMinLevel.GetValue()
		endif
		ED_Mechanics_Global_MCM_NightSightMaxLevel.SetValue(akValue)
		self.SetSliderOptionValue(Setting_NightSightMaxLevel, akValue)
		
	elseIf akOp == Setting_NightSightMinLevel
		if akValue > ED_Mechanics_Global_MCM_NightSightMaxLevel.GetValue()
			akValue = ED_Mechanics_Global_MCM_NightSightMaxLevel.GetValue()
		endif
		ED_Mechanics_Global_MCM_NightSightMinLevel.SetValue(akValue)
		self.SetSliderOptionValue(Setting_NightSightMinLevel, akValue)
		
	elseIf akOp == Setting_NightSightStrengthMult
		akValue = akValue / 100.0
		ED_Mechanics_Global_MCM_NightSightStrengthMult.SetValue(akValue)
		self.SetSliderOptionValue(Setting_NightSightStrengthMult, akValue)
	
	elseIf akOp == Setting_VampireSkillExpMult
		ED_Mechanics_SkillTree_XPMult_Global.SetValue(akValue)
		self.SetSliderOptionValue(Setting_VampireSkillExpMult, akValue)
	
	elseIf akOp == Setting_VampireAgeMult
		ED_Mechanics_VampireAgeExpMult.SetValue(akValue)
		self.SetSliderOptionValue(Setting_VampireAgeMult, akValue)
	
	; ------------------------------------------------------------
	
	endif
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endFunction


function OnOptionSelect(Int akOp)
	; ------------------------------------------------------------
	; Blood Meter
	if akOp == BloodMeter_Enable
		ED_Mechanics_BloodMeter_Enable_Global.SetValue(1 as Float - ED_Mechanics_BloodMeter_Enable_Global.GetValue())
		self.SetToggleOptionValue(BloodMeter_Enable, ED_Mechanics_BloodMeter_Enable_Global.GetValue() as Bool)
		
	elseif akOp == BloodMeter_HideWhenFull
		ED_Mechanics_BloodMeter_HideWhenAtRestFull_Global.SetValue(1 as Float - ED_Mechanics_BloodMeter_HideWhenAtRestFull_Global.GetValue())
		self.SetToggleOptionValue(BloodMeter_HideWhenFull, ED_Mechanics_BloodMeter_HideWhenAtRestFull_Global.GetValue() as Bool)
		
	; ------------------------------------------------------------
	; settings
	elseif akOp == Setting_SameSexPreference
		ED_Mechanics_Global_MCM_SameSexPreference.SetValue(1 as Float - ED_Mechanics_Global_MCM_SameSexPreference.GetValue())
		SetToggleOptionValue(Setting_SameSexPreference, ED_Mechanics_Global_MCM_SameSexPreference.GetValue() as bool)
		
	elseif akOp == Setting_DisableBloodstarvedTint
		ED_Mechanics_Global_MCM_DisableBloodstarvedTint.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableBloodstarvedTint.GetValue())
		SetToggleOptionValue(Setting_DisableBloodstarvedTint, ED_Mechanics_Global_MCM_DisableBloodstarvedTint.GetValue() as bool)
		
	elseif akOp == Setting_DisableDisintegrate
		ED_Mechanics_Global_MCM_DisableDisintegrate.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableDisintegrate.GetValue())
		SetToggleOptionValue(Setting_DisableDisintegrate, ED_Mechanics_Global_MCM_DisableDisintegrate.GetValue() as bool)
		
	elseif akOp == Setting_NightSightDisableAdaptive
		ED_Mechanics_Global_MCM_NightSightDisableAdaptive.SetValue(1 as Float - ED_Mechanics_Global_MCM_NightSightDisableAdaptive.GetValue())
		SetToggleOptionValue(Setting_NightSightDisableAdaptive, ED_Mechanics_Global_MCM_NightSightDisableAdaptive.GetValue() as bool)
		
	elseif akOp == Setting_EnableShadowRegen
		ED_Mechanics_Global_EnableShadowRegen.SetValue(1 as Float - ED_Mechanics_Global_EnableShadowRegen.GetValue())
		SetToggleOptionValue(Setting_EnableShadowRegen, ED_Mechanics_Global_EnableShadowRegen.GetValue() as bool)
	
	; ------------------------------------------------------------
	; cheats
	elseif akOp == Cheats_NecromageToggle
		ED_Mechanics_Global_MCM_NecromageToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_NecromageToggle.GetValue())
		SetToggleOptionValue(Cheats_NecromageToggle, ED_Mechanics_Global_MCM_NecromageToggle.GetValue() as bool)
		
	elseif akOp == Cheats_AllureToggle
		ED_Mechanics_Global_MCM_AllureToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_AllureToggle.GetValue())
		SetToggleOptionValue(Cheats_AllureToggle, ED_Mechanics_Global_MCM_AllureToggle.GetValue() as bool)
	
	elseif akOp == Cheats_PersuasionToggle
		ED_Mechanics_Global_MCM_PersuasionToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_PersuasionToggle.GetValue())
		SetToggleOptionValue(Cheats_PersuasionToggle, ED_Mechanics_Global_MCM_PersuasionToggle.GetValue() as bool)
		
	elseif akOp == Cheats_MasterOfTheMindToggle
		ED_Mechanics_Global_MCM_MasterOfTheMindToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_MasterOfTheMindToggle.GetValue())
		SetToggleOptionValue(Cheats_MasterOfTheMindToggle, ED_Mechanics_Global_MCM_MasterOfTheMindToggle.GetValue() as bool)
	
	elseif akOp == Cheats_DisableHate
		ED_Mechanics_Global_MCM_DisableHate.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableHate.GetValue())
		SetToggleOptionValue(Cheats_DisableHate, ED_Mechanics_Global_MCM_DisableHate.GetValue() as bool)
	
	elseif akOp == Cheats_DisableScorchingSun
		ED_Mechanics_Global_MCM_DisableScorchingSun.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableScorchingSun.GetValue())
		SetToggleOptionValue(Cheats_DisableScorchingSun, ED_Mechanics_Global_MCM_DisableScorchingSun.GetValue() as bool)
	
	elseif akOp == Cheats_DisableAlchemyPenalty
		ED_Mechanics_Global_MCM_DisableAlchemyPenalty.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableAlchemyPenalty.GetValue())
		SetToggleOptionValue(Cheats_DisableAlchemyPenalty, ED_Mechanics_Global_MCM_DisableAlchemyPenalty.GetValue() as bool)
	
	elseif akOp == Cheats_DisableChainedBeast
		ED_Mechanics_Global_MCM_DisableChainedBeast.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableChainedBeast.GetValue())
		SetToggleOptionValue(Cheats_DisableChainedBeast, ED_Mechanics_Global_MCM_DisableChainedBeast.GetValue() as bool)
	
	elseif akOp == Cheats_ToggleArmorWatcherVL
		ED_Mechanics_Global_MCM_ToggleArmorWatcherVL.SetValue(1 as Float - ED_Mechanics_Global_MCM_ToggleArmorWatcherVL.GetValue())
		SetToggleOptionValue(Cheats_ToggleArmorWatcherVL, ED_Mechanics_Global_MCM_ToggleArmorWatcherVL.GetValue() as bool)
		
	elseif akOp == Cheats_DisableFortitude
		ED_Mechanics_Global_MCM_DisableFortitudeRevive.SetValue(1 as Float - ED_Mechanics_Global_MCM_DisableFortitudeRevive.GetValue())
		SetToggleOptionValue(Cheats_DisableFortitude, ED_Mechanics_Global_MCM_DisableFortitudeRevive.GetValue() as bool)
		if ED_Mechanics_Global_MCM_DisableFortitudeRevive.GetValue() == 1.0
			Game.GetPlayer().RemoveSpell(ED_Mechanics_Ab_ChainedBeast_Spell)
		endif
		
	elseif akOp == Cheats_ToggleExtractor
		ED_Mechanics_Global_MCM_ExtractorToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_ExtractorToggle.GetValue())
		SetToggleOptionValue(Cheats_ToggleExtractor, ED_Mechanics_Global_MCM_ExtractorToggle.GetValue() as bool)
	
	; ------------------------------------------------------------
	endif
	ED_BloodMeter_Quest.UpdateMeterBasicSettings()
endfunction


Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if option == Hotkeys_TestKey
		AssignKey(ED_Test_Hotkey, option, keyCode, conflictControl, conflictName)
	
	elseif option == Hotkeys_HotkeyA
		AssignKey(ED_Mechanics_Hotkeys_HotkeyA, option, keyCode, conflictControl, conflictName)
	
	elseif option == Hotkeys_HotkeyB
		AssignKey(ED_Mechanics_Hotkeys_HotkeyB, option, keyCode, conflictControl, conflictName)
	
	endIf
endEvent


; proper description of the option when you highlight it with a mouse
; displayed somewhere
function OnOptionHighlight(Int akOp)

	; ------------------------------------------------------------
	; Blood Meter
	If akOp == BloodMeter_X
		self.SetInfoText("X coordinate (vertical) of Vitae bar left bottom corner")
	elseif akOp == BloodMeter_Y
		self.SetInfoText("Y coordinate (vertical) of Vitae bar left bottom corner")
	elseIf akOp == BloodMeter_Scale
		self.SetInfoText("Scale of Vitae bar")
	elseIf akOp == BloodMeter_FillDirection
		self.SetInfoText("The position at which the meter fills from, 0 = right, 1 = center, 2 = left. Default: right")
	elseIf akOp == BloodMeter_Opacity
		self.SetInfoText("How opaque is Vitae bar")
	elseIf akOp == BloodMeter_Enable
		self.SetInfoText("Enable Vitae bar")
	elseIf akOp == BloodMeter_DisplayTime
		self.SetInfoText("How much seconds before blood bar fades after displaying last change. Setting to 0 disables fading. May not be exact amount of seconds due to bar update rate")
	elseIf akOp == BloodMeter_OpacityAtRest
		self.SetInfoText("How opaque is Vitae bar when faded")
	elseIf akOp == BloodMeter_HideWhenFull
		self.SetInfoText("Hide Vitae bar completely (0 opacity) when faded while full")
		
	; ------------------------------------------------------------
	; Hotkeys
	elseIf akOp == Hotkeys_TestKey
		self.SetInfoText("Test key")
	elseIf akOp == Hotkeys_HotkeyA
		self.SetInfoText("Hold: Cast Extended Perception or Dispel it or Celerity ; Tap: Celerity; Tap when Celerity is active: Wicked Wind")
	elseIf akOp == Hotkeys_HotkeyB
		self.SetInfoText("Tap: Toggle Deadly Strength, Hold: charge next jump heigth")
		
	; ------------------------------------------------------------
	; settings
	elseIf akOp == Setting_SameSexPreference
		self.SetInfoText("Dibella related bonuses (canonically) give advantage when dealing with opposite sex. In this mod, they also give bonuses to seduction through dialogue chances. This changes it to same sex preference")
	elseIf akOp == Setting_CombatDrainAnim
		self.SetInfoText("Female animation: jump feed, male: overpower feed. 1: use sex specific animation; 2: use opposite; 3: use both randomly. Takes effect after next combat drain")
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		self.SetInfoText("How many hours between you get XP for successful seduction")
	elseIf akOp == Setting_DisableBloodstarvedTint
		self.SetInfoText("Disable red tint when in combat while Blood Starved")
	elseIf akOp == Setting_DisableDisintegrate
		self.SetInfoText("Disable disintegrate into ashpile on death for you, in case you need it for compatibility with other vampire/npc mod")
	elseIf akOp == Setting_NightSightMaxLevel
		self.SetInfoText("Maximum strength of Vampire's Sight night vision. Can't be lower than minimum strength setting. Takes effect on next cast.")
	elseIf akOp == Setting_NightSightMinLevel
		self.SetInfoText("Minimum strength of Vampire's Sight night vision. Can't be higher than maximum strength setting. Takes effect on next cast.")
	elseIf akOp == Setting_NightSightDisableAdaptive
		self.SetInfoText("Disable Vampire's Sight night vision adaptive strength. Use if your lightning mods make it behave improperly. If disabled, maximum strength setting will be used at all times. Takes effect on next cast.")
	elseIf akOp == Setting_NightSightStrengthMult
		self.SetInfoText("Vampire's Sight night vision overral effectiveness.")
	elseIf akOp == Setting_VampireSkillExpMult
		self.SetInfoText("Vampire skill tree experience gain multiplicator. Does not work retroactively.")
	elseIf akOp == Setting_VampireSkillExpMult
		self.SetInfoText("Vampire ageing multiplicator. Does not work retroactively.")
	elseIf akOp == Setting_VampireSkillExpMult
		self.SetInfoText("When this is ON, stainding in a shadow (light level < 50) disables Sun Weakness effects other than attribute loss. Actual behavior depends on your lightning mods, so disable if ruins immersion")
	elseIf akOp == Setting_LevelXPMult
		self.SetInfoText("How much Vampirism skill contributes to player level progression, relative to regular skills. As damaging vampiric powers do not contribute to any player skill directly AND do not use regular perk points, 0 by default.")
	
	; ------------------------------------------------------------
	; cheats
	elseIf akOp == Cheats_NecromageToggle
		self.SetInfoText("Disables healing penalty, as if you got the Necromage perk. Use if perk is unattainable due to perk overhaul compatibility")
	elseIf akOp == Cheats_NecromageToggle
		self.SetInfoText("Vampiric effects that would affect undead, daedra and automatons on the basis of having vanilla Master of the Mind perk now do regardless. Use if perk is unattainable due to perk overhaul compatibility")
	elseIf akOp == Cheats_DisableHate
		self.SetInfoText("Disable hate when Blood Starved. Takes effect next time you become Blood Starved")
	elseIf akOp == Cheats_DisableScorchingSun
		self.SetInfoText("Sun no longer does Health damage when at 0 Blood Points. Other penalties are intact")
	elseIf akOp == Cheats_DisableAlchemyPenalty
		self.SetInfoText("Health restoring alchemy (Health/Health regen potions) has full effect on you")
	elseIf akOp == Cheats_DisableChainedBeast
		self.SetInfoText("Upon taking fatal damage, you will die as usual instead of turning into Vampire Beast. After getting Embrace The Beast, this setting has no effect")
	elseIf akOp == Cheats_ToggleArmorWatcherVL
		self.SetInfoText("Vampire Transformations automatically uneqip any regular armor/weapon if you happen to equip them (accidentally through looting menu, for example)")
	elseIf akOp == Cheats_DisableFortitude
		self.SetInfoText("Disable Fortitude and Chained Beast mechanics altogether. Embrace the Beast perk only gives you the change spell.")
	elseIf akOp == Cheats_ToggleExtractor
		self.SetInfoText("Allow extracting Blood Potions from Blood Dolls (victims of seduction through dialogue several times) without having Septimus essense extractor")
	
	; ------------------------------------------------------------
	endif
endfunction

; ------------------------------------------------------------
; Helper functions

Function AssignKey(globalvariable hotKeyGlobal, int option, int keyCode, string conflictControl, string conflictName)
		bool continue = true
		if (conflictControl != "")
			string msg
			if (conflictName != "")
				msg = "This key is already mapped to:\n" + conflictControl + "\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n" + conflictControl + "\n\nAre you sure you want to continue?"
			endIf

			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
		if (continue)
			hotKeyGlobal.Value = keyCode
			SetKeymapOptionValue(option, keyCode)
			ED_Mechanics_HotKeys_Quest.RegisterHotkeys()
		endIf
EndFunction

ED_BloodMeterUpdate property ED_BloodMeter_Quest auto
ED_HotKeys_Script property ED_Mechanics_HotKeys_Quest auto
spell property ED_Mechanics_Ab_ChainedBeast_Spell auto
