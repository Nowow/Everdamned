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
effectshader property ed_Test_Art_Shader_MagicArmorEbonyFleshFXS auto
keyword property ED_Mechanics_Keyword_NecroticFleshCIF auto
effectshader property ED_TestShader2_empty auto


textureset property ED_TEST_Art_TextureSet_Stoneskin_SkinBodyFemale auto

spell property ED_VampireSpells_BloodSeed_Spell auto

idle property pa_HugA auto
idle property ED_testidle auto
idle property pa_KillMoveDLC02RipHeartOut auto
idle property IdleVampireStandingFeedFront_Loose auto

idle property ED_KM_JumpFeed auto
idle property pa_KillMoveED_bleedoutFinisher auto
spell property ED_Art_Spell_MouthMuzzleFlash auto

visualeffect property ED_Art_VFX_VampireTransform_Begin auto
visualeffect property ED_Art_VFX_VampireTransform_End auto
hazard property ED_Art_Hazard_VampireTransformBats auto
idle property ED_Idle_Seduction_Blowkiss auto

message property ED_Mechanics_FeedDialogue_Message_SomeTestM auto
topic property ED_HelloTopic_FeedDialogue auto
topic property ED_CommentOnResult_PostMortem_FeedDialogue_Topic auto
topic property ED_Recommendation_PostMortem_FeedDialogue_Topic auto
activator property FXEmptyActivator auto

idle property ED_Idle_Seduction_TouchHairPlayful auto
idle property ResetRoot auto
idle property ED_Idle_Seduction_NPCSequenceStart auto

referencealias property ED_FeedDialogue_Target auto
scene property ED_ForceGreetIntoFeedDialogue_FeedDialogue_Scene auto

keyword property ED_Mechanics_Keyword_RollFeedDialogueScore auto

int counter
bool __switch
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentTestHotkey
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		actor __targetThing = Game.GetCurrentConsoleRef() as actor
		
		actor pl = Game.GetPlayer()
		
		pl.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, __targetThing)
		
		
		
		;__targetThing.PlayIdle(ED_Idle_Seduction_NPCSequenceStart)
		;debug.SendAnimationEvent(__targetThing, "NPC_TurnLeft180")
		
		bool __var
		
		;__var = __targetThing.GetAnimationVariableBool("bIdlePlaying")
		;debug.Trace("Everdamned DEBUG: Var: " + __var)
		
		if !__switch
			
		else
			;__targetThing.SetAnimationVariableBool("bIdlePlaying", !__var)
			;debug.SendAnimationEvent(__targetThing, "ed_seduction_NPCSeq_end")
		endif
		
		__switch = !__switch
		;pl.SetSubGraphFloatVariable("ftoggleBlend", 1.3)
		
		;
		;pl.SetSubGraphFloatVariable("ftoggleBlend", 0.0)
		
		
		;bool _avar = __targetThing.GetAnimationVariableBool("TDM_TargetLock")
		;debug.Trace("Everdamned DEBUG: Animvar: " + _avar)
		
		;__targetThing.SetAnimationVariableBool("TDM_TargetLock", !_avar)
		
		;_avar = __targetThing.GetAnimationVariableBool("TDM_TargetLock")
		;debug.Trace("Everdamned DEBUG: Animvar: " + _avar)
		
		
		;__targetThing.SetAnimationVariableBool("bSprintOK", __isSprintOK)
		
		;__targetThing.SetAnimationVariableBool("bSprintOK", !__isSprintOK)
		;if __isSprintOK
		;	input.TapKey(input.GetMappedKey("Sprint"))
		;endif
		
		;pl.SetHeadTracking(False)
		;(__targetThing as actor).SetHeadTracking(False)
		
		;counter += 1
		
		;if (__targetThing as actor)
		;
		;	float zOffset = __targetThing.GetHeadingAngle(pl)
		;	__targetThing.SetAngle(__targetThing.GetAngleX(), __targetThing.GetAngleY(), __targetThing.GetAngleZ() + zOffset)
		;	
		;	if counter % 2 == 0
		;		debug.Trace("Everdamned DEBUG: even")
		;		pl.PlayIdleWithTarget(ED_KM_JumpFeed, __targetThing)
		;	else
		;		debug.Trace("Everdamned DEBUG: odd")
		;		pl.PlayIdleWithTarget(pa_KillMoveED_bleedoutFinisher, __targetThing)
		;		
		;	endif
		;
		;endif
		
		;float zOffset = __targetThing.GetHeadingAngle(pl)
		;__targetThing.SetAngle(__targetThing.GetAngleX(), __targetThing.GetAngleY(), __targetThing.GetAngleZ() + zOffset)
		;pl.StartVampireFeed(__targetThing as actor)
		
		;if counter % 2 == 0
		;	pl.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, __targetThing)
		;else
		;	pl.PlayIdleWithTarget(pa_HugA, __targetThing)
		;endif
		;counter += 1
		
		;CustomSkills.IncrementSkillBy("EverdamnedMain", 5)
		;CustomSkills.ShowSkillIncreaseMessage("EverdamnedMain")
		
		;debug.Trace("Everdamned DEBUG: " + ED_VampireSpells_BloodSeed_Spell.GetPerk())
		
		;unsuccessfull end cast for both hands at once always
		;RegisterForAnimationEvent(playerRef, "InterruptCast")
		;RegisterForAnimationEvent(playerRef, "Unequip")
		;RegisterForAnimationEvent(playerRef, "weaponSheathe")
		
		;successfull cast (concentration special case and not needed)
		;RegisterForAnimationEvent(playerRef, "MRh_SpellRelease_Event")
		;RegisterForAnimationEvent(playerRef, "MRL_SpellRelease_Event")
		
		;start cast
		;RegisterForAnimationEvent(playerRef, "MRh_SpellSelfStart")
		;RegisterForAnimationEvent(playerRef, "MRl_SpellSelfStart")
		;RegisterForAnimationEvent(playerRef, "MRh_SpellAimedStart")
		;RegisterForAnimationEvent(playerRef, "MRl_SpellAimedStart")
		
		
		;debug.Trace("Everdamned DEBUG: " + (__targetThing AS ACTOR).GetEquippedArmorInSlot(61))
		
		;ED_SKSEnativebindings.StopAllShadersExceptThis(ed_Test_Art_Shader_MagicArmorEbonyFleshFXS, ED_Mechanics_Keyword_NecroticFleshCIF, ED_TestShader2_empty)
		
		;po3_SKSEFunctions.ReplaceSkinTextureSet(PlayerRef, ED_TEST_Art_TextureSet_Stoneskin_SkinBodyFemale, ED_TEST_Art_TextureSet_Stoneskin_SkinBodyFemale, 32, -1) ; Body
		
		;playerRef.addspell(ED_VampirePowers_Power_DeadlyStrengthTog)
		;playerRef.addspell(ED_VampirePowers_Power_Celerity)
		;playerRef.addspell(ED_VampirePowers_Power_ExtendedPerceptionTog)
		;playerRef.addspell(ED_VampirePowers_Pw_NecroticFlesh_Tog_Spell)
		
		;ED_Art_VFX_BatsCloakDUPLICATE001.Play(__targetThing)
		
		;AddSkinOverrideTextureSet
		
		
		
		
	
		
			

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

event OnAnimationEvent(ObjectReference akSource, string asEventName)
	debug.Trace("Everdamned DEBUG: Animevent caught: " + asEventName)
endevent


action property ActionJump auto

actor property playerRef auto