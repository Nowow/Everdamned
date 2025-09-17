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

; ------------------------------------------------------------
; Rest

Int Cheats_NecromageToggle
float property Default_Cheats_NecromageToggle auto
GlobalVariable Property ED_Mechanics_Global_MCM_NecromageToggle Auto

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


function OnPageReset(String akPage)

	self.SetCursorFillMode(self.TOP_TO_BOTTOM)
	self.SetCursorPosition(0)
	self.AddHeaderOption("Blood Bar", 0)
	
	; ------------------------------------------------------------
	; Blood Meter
	
	BloodMeter_Enable = self.AddToggleOption("Enable blood pool bar", ED_Mechanics_BloodMeter_Enable_Global.GetValue() as Bool)
	
	BloodMeter_X = self.AddSliderOption("Blood pool bar X coordinate", ED_Mechanics_BloodMeter_X_Global.GetValue())
	BloodMeter_Y = self.AddSliderOption("Blood pool bar Y coordinate", ED_Mechanics_BloodMeter_Y_Global.GetValue())
	BloodMeter_Scale = self.AddSliderOption("Blood pool bar scale", ED_Mechanics_BloodMeter_Scale_Global.GetValue())
	BloodMeter_FillDirection = self.AddSliderOption("Blood pool bar fill direction", ED_Mechanics_BloodMeter_FillDirection_Global.GetValue())
	BloodMeter_Opacity = self.AddSliderOption("Blood pool bar opacity", ED_Mechanics_BloodMeter_Opacity_Global.GetValue())
	BloodMeter_DisplayTime = self.AddSliderOption("Seconds to fade when incative", ED_Mechanics_BloodMeter_DisplayTime_Global.GetValue())
	
	; ------------------------------------------------------------
	; Hotkeys
	self.AddEmptyOption()
	self.AddHeaderOption("Hotkeys", 0)
	Hotkeys_TestKey = AddKeyMapOption("Test hotkey", ED_Test_Hotkey.GetValue() as int)
	Hotkeys_HotkeyA = AddKeyMapOption("Celerity Hotkey", ED_Mechanics_Hotkeys_HotkeyA.GetValue() as int)
	Hotkeys_HotkeyB = AddKeyMapOption("Potence Hotkey", ED_Mechanics_Hotkeys_HotkeyB.GetValue() as int)
	
	; ------------------------------------------------------------
	; settings
	self.AddEmptyOption()
	self.AddHeaderOption("Settings", 0)
	
	Setting_SameSexPreference = self.AddToggleOption("Same sex preferency for seduction", ED_Mechanics_Global_MCM_SameSexPreference.GetValue() as Bool)
	Setting_CombatDrainAnim = self.AddSliderOption("Which combat drain anim to use", ED_Mechanics_Global_MCM_CombatDrainAnim.GetValue())
	Setting_SeductionDialogueXPCooldownHours = self.AddSliderOption("Speech XP for Seduction cooldown, hours", ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.GetValue())
	
	; ------------------------------------------------------------
	; cheats/compatibility
	self.AddEmptyOption()
	self.AddHeaderOption("Compatibility/Cheats", 0)
	
	Cheats_NecromageToggle = self.AddToggleOption("Disable Restoration healing penalty", ED_Mechanics_Global_MCM_NecromageToggle.GetValue() as Bool)
	Cheats_DisableHate = self.AddToggleOption("Disable hate when Blood Starved", ED_Mechanics_Global_MCM_DisableHate.GetValue() as Bool)
	Cheats_DisableScorchingSun = self.AddToggleOption("Disable Sun burning", ED_Mechanics_Global_MCM_DisableScorchingSun.GetValue() as Bool)
	Cheats_DisableAlchemyPenalty = self.AddToggleOption("Disable penalty to Health restoring potions", ED_Mechanics_Global_MCM_DisableAlchemyPenalty.GetValue() as Bool)
	Cheats_DisableChainedBeast = self.AddToggleOption("Disable Fortitude transformation", ED_Mechanics_Global_MCM_DisableChainedBeast.GetValue() as Bool)
	Cheats_ToggleArmorWatcherVL = self.AddToggleOption("Disable Equip Watcher for VL", ED_Mechanics_Global_MCM_ToggleArmorWatcherVL.GetValue() as Bool)
	
	; ------------------------------------------------------------
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
		
	elseIf akOp == BloodMeter_Enable
		ED_Mechanics_BloodMeter_Enable_Global.SetValue(Default_BloodMeter_Enable as Float)
		self.SetToggleOptionValue(BloodMeter_Enable, Default_BloodMeter_Enable as bool)
	
	elseIf akOp == BloodMeter_DisplayTime
		ED_Mechanics_BloodMeter_DisplayTime_Global.SetValue(Default_BloodMeter_DisplayTime as Float)
		self.SetSliderOptionValue(BloodMeter_DisplayTime, Default_BloodMeter_DisplayTime as Float)
	
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
		self.SetSliderOptionValue(Setting_CombatDrainAnim, Default_Setting_CombatDrainAnim)
	
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.SetValue(Default_Setting_SeductionDialogueXPCooldownHours as Float)
		self.SetSliderOptionValue(Setting_SeductionDialogueXPCooldownHours, Default_Setting_SeductionDialogueXPCooldownHours)
	
	; ------------------------------------------------------------
	; cheats
	
	elseIf akOp == Cheats_NecromageToggle
		ED_Mechanics_Global_MCM_NecromageToggle.SetValue(Default_Cheats_NecromageToggle)
		SetToggleOptionValue(Cheats_NecromageToggle, Default_Cheats_NecromageToggle as bool)
		
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
		self.SetSliderDialogInterval(2.00000)
		
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
	
	; ------------------------------------------------------------
	
	endIf
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
	
	elseIf akOp == BloodMeter_DisplayTime
		ED_Mechanics_BloodMeter_DisplayTime_Global.SetValue(akValue)
		self.SetSliderOptionValue(BloodMeter_DisplayTime, akValue)
		
	; ------------------------------------------------------------
	; settings
	
	elseIf akOp == Setting_CombatDrainAnim
		ED_Mechanics_Global_MCM_CombatDrainAnim.SetValue(akValue)
		self.SetSliderOptionValue(Setting_CombatDrainAnim, akValue)
	
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		ED_Mechanics_FeedDialogue_Seduction_XPCooldownHours.SetValue(akValue)
		self.SetSliderOptionValue(Setting_SeductionDialogueXPCooldownHours, akValue)
	
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
		
	; ------------------------------------------------------------
	; settings
	elseif akOp == Setting_SameSexPreference
		ED_Mechanics_Global_MCM_NecromageToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_SameSexPreference.GetValue())
		SetToggleOptionValue(Setting_SameSexPreference, ED_Mechanics_Global_MCM_SameSexPreference.GetValue() as bool)
	
	; ------------------------------------------------------------
	; cheats
	elseif akOp == Cheats_NecromageToggle
		ED_Mechanics_Global_MCM_NecromageToggle.SetValue(1 as Float - ED_Mechanics_Global_MCM_NecromageToggle.GetValue())
		SetToggleOptionValue(Cheats_NecromageToggle, ED_Mechanics_Global_MCM_NecromageToggle.GetValue() as bool)
	
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
		self.SetInfoText("TEST: Intricate Description of X coordinate")
	elseif akOp == BloodMeter_Y
		self.SetInfoText("TEST: Intricate Description of Y coordinate")
	elseIf akOp == BloodMeter_Scale
		self.SetInfoText("TEST: Intricate Description of meter scale")
	elseIf akOp == BloodMeter_FillDirection
		self.SetInfoText("The position at which the meter fills from, 0 = right, 1 = center, 2 = left. Default: right")
	elseIf akOp == BloodMeter_Opacity
		self.SetInfoText("TEST: Intricate Description of opacity")
	elseIf akOp == BloodMeter_Enable
		self.SetInfoText("Enable blood bar")
	elseIf akOp == BloodMeter_DisplayTime
		self.SetInfoText("How much seconds before blood bar fades after displaying last change. Setting to 0 disables fading. May not be exact amount of seconds due to bar update rate")
		
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
	elseIf akOp == Setting_SameSexPreference
		self.SetInfoText("Female animation: jump feed, male: overpower feed. 1: use sex specific animation; 2: use opposite; 3: use both randomly")
	elseIf akOp == Setting_SeductionDialogueXPCooldownHours
		self.SetInfoText("How many hours between you get XP for successful seduction")
	
	; ------------------------------------------------------------
	; cheats
	elseIf akOp == Cheats_NecromageToggle
		self.SetInfoText("Disables healing penalty, as if you got the Necromage perk. Can be necessary for compatibility with perk overhauls or if you dont feel like getting the perk properly but want to heal with Restoration")
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
