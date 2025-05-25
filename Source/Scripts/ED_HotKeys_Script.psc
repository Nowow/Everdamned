Scriptname ED_HotKeys_Script extends Quest  


GlobalVariable Property ED_Test_Hotkey Auto

ED_HotkeyA_Script property HotkeyA_Script auto
ED_HotkeyB_Script property HotkeyB_Script auto

int __currentTestHotkey
Function InitializeHotkeys()

	HotkeyA_Script.RegisterHotkey()
	HotkeyB_Script.RegisterHotkey()

	__currentTestHotkey = ED_Test_Hotkey.GetValue() as int
	RegisterForKey(__currentTestHotkey)
EndFunction

Function UnRegisterHotkeys()
	HotkeyA_Script.UnregisterHotkey()
	HotkeyB_Script.UnregisterHotkey()

	UnRegisterForKey(__currentTestHotkey)
	__currentTestHotkey = 0
EndFunction

Function RegisterHotkeys()
	UnRegisterHotkeys()
	InitializeHotkeys()
endfunction

spell property ED_VampirePowers_Power_DeadlyStrengthTog auto
spell property ED_VampirePowers_Power_Celerity auto
spell property ED_VampirePowers_Power_ExtendedPerceptionTog auto
spell property ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell auto
visualeffect property ED_Art_VFX_BatsCloakDUPLICATE001 auto
effectshader property ed_Test_Art_Shader_MagicArmorEbonyFleshFXS auto
keyword property ED_Mechanics_Keyword_NecroticFleshCIF auto
effectshader property ED_TestShader2_empty auto


textureset property ED_TEST_Art_TextureSet_Stoneskin_SkinBodyFemale auto

Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentTestHotkey
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		objectreference __targetThing = Game.GetCurrentConsoleRef()
		
		;debug.Trace("Everdamned DEBUG: " + (__targetThing AS ACTOR).GetEquippedArmorInSlot(61))
		
		ED_SKSEnativebindings.StopAllShadersExceptThis(ed_Test_Art_Shader_MagicArmorEbonyFleshFXS, ED_Mechanics_Keyword_NecroticFleshCIF, ED_TestShader2_empty)
		
		;po3_SKSEFunctions.ReplaceSkinTextureSet(PlayerRef, ED_TEST_Art_TextureSet_Stoneskin_SkinBodyFemale, ED_TEST_Art_TextureSet_Stoneskin_SkinBodyFemale, 32, -1) ; Body
		
		;playerRef.addspell(ED_VampirePowers_Power_DeadlyStrengthTog)
		;playerRef.addspell(ED_VampirePowers_Power_Celerity)
		;playerRef.addspell(ED_VampirePowers_Power_ExtendedPerceptionTog)
		;playerRef.addspell(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell)
		
		;ED_Art_VFX_BatsCloakDUPLICATE001.Play(__targetThing)
		
		;AddSkinOverrideTextureSet
		
		;bool __isSprintOK = __targetThing.GetAnimationVariableBool("bSprintOK")
		;debug.Trace("Everdamned DEBUG: Sprint is ok: " + __isSprintOK)
		
		;__targetThing.SetAnimationVariableBool("bSprintOK", !__isSprintOK)
		;__targetThing.SetAnimationVariableBool("bSprintOK", __isSprintOK)
		
		;__targetThing.SetAnimationVariableBool("bSprintOK", !__isSprintOK)
		;if __isSprintOK
		;	input.TapKey(input.GetMappedKey("Sprint"))
		;endif
	
		
			

		;while !(__activator.Is3DLoaded())
		;	debug.Trace("Everdamned DEBUG: FXEmptyActivator 3d is not yet loaded!")
		;	utility.wait(0.1)
		;endwhile

		;float __activatorAngleZ = __activator.GetAngleZ()
		;__activator.MoveTo(__targetThing, 100.0*math.sin(__activatorAngleZ), 100.0*math.cos(__activatorAngleZ), 100.0)
		;__activator.SetAngle(__activator.GetAngleX(), __activator.GetAngleY(), __activatorAngleZ + 180.0)

		;Firebolt.RemoteCast(__activator, __targetThing as actor, __targetThing)
		
	Endif
EndEvent


;Event OnKeyUp(Int KeyCode, Float HoldTime)
	
;endevent


action property ActionJump auto

actor property playerRef auto