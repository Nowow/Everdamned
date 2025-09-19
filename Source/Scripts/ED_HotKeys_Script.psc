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

visualeffect property ED_TEST_VfxTargeted auto
visualeffect property ED_Art_VFX_ExsanguinateBuildup auto

hazard property ED_Art_Hazard_BloodVortex auto
spell property ED_VampireSpells_BloodVortex_Spell_SpawnHazard auto
spell property Flames auto

ED_BloodVortexQuest_Script Property ED_Mechanics_Quest_BloodVortex Auto

sound property ED_Art_SoundM_FlameInglitesSwoosh auto

projectile property ED_Art_Projectile_InfluenceShockwave  auto
spell property ED_VampirePowers_Pw_Dominate_Spell_ProjectileVFX auto

idle property IdleHandCut auto
idle property ED_Idle_FeedKM_Solo_Player_Ground auto
idle property ED_Idle_FeedKM_Solo_Player_Bleedout auto
idle property ED_Idle_FeedKM_Solo_Player_Jumpfeed auto
idle property ED_Idle_FeedKM_Solo_Player_Social auto
idle property ED_Idle_FeedKM_Solo_Victim_Social auto

globalvariable property ED_Test_testglobal auto
globalvariable property ED_Mechanics_Global_FeedType auto

spell property ED_Art_Spell_BackwardsShockwave auto

visualeffect property ED_Art_VFX_AbsorbBloodPool auto
sound property ED_Art_SoundM_PartingGiftBuildup auto


activator property ED_Art_Activator_HavokDummy auto
explosion property ED_Art_Explosion_Exsanguinate auto
spell property ED_VampireSpellsVL_IcyWinds_Release_Spell auto

hazard property ED_Art_Hazard_ColdFlamePyre auto
visualeffect property ED_Art_VFX_ColdFlameBanishFX auto

referencealias property undyingservant auto

keyword property ED_Mechanics_Keyword_UndyingLoyaltyLaunch auto

armor property DLC1ClothesVampireLordRoyalArmor auto
armor property ArmorDragonplateCuirass auto

race property DLC1VampireBeastRace auto

globalvariable property ED_Test_testglobalX auto
globalvariable property ED_Test_testglobalY auto
globalvariable property ED_Test_testglobalZ auto



int counter
bool __switch
art leart
string art_name
string mod_name
Event OnKeyDown(int keyCode)
	if Utility.IsInMenuMode()
		return
	endif
	
	If keyCode == __currentTestHotkey
		debug.Trace("Everdamned DEBUG: test key was pressed! ---------------------------------------------")
		
		;ObjectReference __targetThing = Game.GetCurrentConsoleRef()
		actor __targetThing = Game.GetCurrentConsoleRef() as actor
		
		actor pl = Game.GetPlayer()
		
		
		CustomSkills.IncrementSkill("EverdamnedXP")
		ED_SKSEnativebindings.AddThisMuchXP(600)
		
		;pl.SetDontMove(false)
		
		
		;objectreference undyingservantobj = undyingservant.GetReference()
		;debug.Trace("Everdamned DEBUG: Undying servant: " + undyingservantobj)
		
		;string leNode = "NPC L Hand [LHnd]"
		;debug.Trace("Everdamned DEBUG: Target has node " + leNode + ": " + __targetThing.HasNode(leNode))
		
		;leNode = "NPC Head [Head]"
		;debug.Trace("Everdamned DEBUG: Target has node " + leNode + ": " + __targetThing.HasNode(leNode))
		
		;leNode = "MagicEffectsNode"
		;debug.Trace("Everdamned DEBUG: Target has node " + leNode + ": " + __targetThing.HasNode(leNode))
		
		
		;falmers falmervampire
		;spriggan
		;ashman
		;hulkingdraugr
		;werebear werewolf
		;giant
		;hagraven
		;skeleton
		;troll
		

		;objectreference dummy = __targetThing.placeatme(ED_Art_Explosion_Exsanguinate)
		
		;dummy.moveto(pl, 0, -100.0, 100.0)
	
		;utility.wait(1.0)
		
		;string humanoidNode = "NPC R Foot [Rft ]"
		;string humanoidNode = "NPC R Clavicle [RClv]"
		
		;string dummyNode = "AttachDummy"
		;string humanoidRHand = "NPC L Hand [LHnd]"
		;debug.Trace("Everdamned DEBUG: Dummy has node " + dummyNode + ": " + dummy.HasNode(dummyNode))
		
		;If __targetThing != None && __targetThing.Is3DLoaded()
		;	debug.Trace("Everdamned DEBUG: cursor target 3d loaded")
		;	If __targetThing.HasNode(humanoidNode)
		;		debug.Trace("Everdamned DEBUG: cursor target had node " + humanoidNode + ": " + __targetThing.HasNode(humanoidNode))
		;		
		;		;dummy.MoveTo(__targetThing, 0, 0, 0)
		;		__targetThing.forceAddRagdollToWorld()
		;		pl.forceAddRagdollToWorld()
		;		;If (game.addHavokBallAndSocketConstraint(__targetThing, humanoidNode, dummy, dummyNode, 0, 0, 0)) == True
		;		If (game.addHavokBallAndSocketConstraint(__targetThing, humanoidNode, dummy, dummyNode, 0, 0, 0)) == True
		;			debug.Trace("Everdamned DEBUG: Ball and Socket constraint successfully added")
		;			__targetThing.ApplyHavokImpulse(0.0, 0.0, 1.0, 0.1)
		;		Else
		;			debug.Trace("Everdamned DEBUG: Ball and Socket FAILED")
		;		EndIf
		;	EndIf
		;EndIf
		
		;utility.wait(1.0)
		;float TheMagnitude = (dummy.GetDistance(pl) / 10)
		;dummy.SplineTranslateToRef(pl as ObjectReference, TheMagnitude, 100.0)
		
		
		
		;debug.Trace("Everdamned DEBUG: player has node " + humanoidRHand + ": " + pl.HasNode(humanoidRHand))
		
		;while true
			;utility.wait(0.2)
			;float TheMagnitude = (dummy.GetDistance(pl) / 10)
			
			;float Xc = pl.GetPositionX()
			;float Yx = pl.GetPositionY()
			;float Zc = pl.GetPositionZ() + 300.0
			;dummy.SplineTranslateTo(Xc, Yx, Zc, 0.0, 0.0, 0.0, TheMagnitude, 300.0)
			
			;dummy.SplineTranslateToRefNode(pl, humanoidRHand, TheMagnitude, 300.0)
			
		;endwhile
		
		
		;pl.pushactoraway(__targetThing, -1)
		;__targetThing.pushactoraway(pl, -1)
		;utility.wait(0.1)
		;debug.Trace("Everdamned DEBUG: constraint result: " + game.addHavokBallAndSocketConstraint(pl, "NPC R Hand [RHnd]", __targetThing, "NPC R Clavicle [RClv]", 0.0, 0.0, 11.0, 0.0, -10.0, 0.0))
		
		
		;__targetThing.TranslateTo(targetX, targetY, pl.GetPositionZ(),\
		;						pl.GetAngleX(), pl.GetAngleY(), pl.GetAngleZ() - 180.0,\
		;						700.0)
				
		;debug.Trace("Everdamned DEBUG: bIsSynced: " + __targetThing.GetAnimationVariableBool("bIsSynced"))
		
		;pl.SetAnimationVariableBool("bNoStagger", true)
		
		; distance 60
		;pl.PlayIdle(ED_Idle_FeedKM_Solo_Player_Bleedout)
		;__targetThing.PlayIdle(IdleHandCut)
		
		; distance 65
		;pl.PlayIdle(ED_Idle_FeedKM_Solo_Player_Jumpfeed)
		;__targetThing.PlayIdle(IdleHandCut)
		
		; distance 52
		;pl.SetDontMove(true)
		;__targetThing.SetDontMove(true)
		;pl.PlayIdle(ED_Idle_FeedKM_Solo_Player_Ground)
		;__targetThing.PlayIdle(IdleHandCut)
		
		
		
		
		
		
		
		
		;__targetThing.playidle(resetroot)
		;debug.SendAnimationEvent(__targetThing, "NPC_TurnLeft180")
		
		
		
		
		
		;ED_Art_SoundM_FlameInglitesSwoosh.Play(pl)
		
		  
		
		;debug.Trace("Everdamned DEBUG: Idle was played: " + __idlePlayed)
		
		;ED_Mechanics_Quest_BloodVortex.IncrementActorsDied(__targetThing as actor)
		
		
		
		;Flames.Cast(__targetThing, pl)
		;debug.Trace("Everdamned DEBUG: Found object: " + game.FindClosestReferenceOfTypeFromRef(ED_Art_Hazard_BloodVortex, pl, 10000))
		
		
		;ED_TEST_VfxTargeted.Play(pl, 5, __targetThing)
		
		;pl.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, __targetThing)
		
		;form leform = ED_SKSEnativebindings.LookupSomeFormByEditorID("HealTargetFX")
		
		
		
		
		;__targetThing.PlayIdle(ED_Idle_Seduction_NPCSequenceStart)
		;debug.SendAnimationEvent(__targetThing, "NPC_TurnLeft180")
		
		bool __var
		
		;__var = __targetThing.GetAnimationVariableBool("bIdlePlaying")
		;debug.Trace("Everdamned DEBUG: Var: " + __var)
		
		if !__switch
			;ED_SKSEnativebindings.SetTimeSlowdown(0.25, 0.6)
			;__targetThing.playidle(resetroot)	
			;bool __idlePlayed = __targetThing.PlayIdle(IdleBoyRitual)
			;utility.wait(0.5)
			;__targetThing.TranslateToRef(playerRef, 100.0)
			
		else
			;ED_SKSEnativebindings.SetTimeSlowdown(0.0, 0.0)
			
	
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