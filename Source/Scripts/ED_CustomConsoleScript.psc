Scriptname ED_CustomConsoleScript Hidden

import PO3_SKSEFunctions
import ED_SKSEnativebindings

string function PlayVisualEffectFromString(string editorID) global
	
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString called!")
	
	visualeffect levfx = LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString got this form: " + levfx)
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef()
	if !__targetThing
		__targetThing = Game.GetPlayer() as ObjectReference
	endif
	
	
	;levfx.Stop(__targetThing)
	
	art leform = LookupSomeFormByEditorID(editorID) as art
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString got this form: " + leform)
	
	if !leform
		return "Didnt find shi"
	endif
	
	SetArtObject(levfx, leform)
	
	
	
	levfx.Play(__targetThing)
	
	return "Model path: " + leform.GetModelPath()
	;if editorID == "A"
	;	return
	;endif
	
	;return editorID
endfunction

function StopLeVFX(string editorID) global
	visualeffect levfx = LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
	
;	if editorID && editorID != ""
;		art leform = LookupSomeFormByEditorID(editorID) as art
;		SetArtObject(levfx, leform)
;	endif

	ObjectReference __targetThing = Game.GetCurrentConsoleRef()
	if !__targetThing
		__targetThing = Game.GetPlayer() as ObjectReference
	endif
	
	levfx.Stop(__targetThing)
	
endfunction


function SetupFormMaps() global
	
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	
	ArtIterator.SetupFormMaps()
	
endfunction

function SetCurrentIndex(int artIndex) global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.SetCurrentIndex(artIndex)
endfunction

function PlayNext() global
	debug.Trace("Everdamned DEBUG: PlayNext called")
	
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.GetNextForm(true)
	
	debug.Trace("Everdamned DEBUG: Current Form: " + ArtIterator.CurrentForm)
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef()
	if !__targetThing
		__targetThing = Game.GetPlayer() as ObjectReference
	endif
	
	if ArtIterator.SelectedFormType == 1
		
		visualeffect levfx = LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
		levfx.Stop(__targetThing)
		
		SetArtObject(levfx, ArtIterator.CurrentForm as art)
		levfx.Play(__targetThing)
	else
		__targetThing.placeatme(ArtIterator.CurrentForm)
	endif
	
endfunction

function PlayPrevious() global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.GetNextForm(false)
	
	debug.Trace("Everdamned DEBUG: Current Form: " + ArtIterator.CurrentForm)
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef()
	if !__targetThing
		__targetThing = Game.GetPlayer() as ObjectReference
	endif
	
	if ArtIterator.SelectedFormType == 1
	
		visualeffect levfx = LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
		levfx.Stop(__targetThing)
		
		SetArtObject(levfx, ArtIterator.CurrentForm as art)
		levfx.Play(__targetThing)
	else
		__targetThing.placeatme(ArtIterator.CurrentForm)
	endif
endfunction

function SaveCurrentForm(string commentStr) global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.LogCurrentForm(commentStr)
endfunction

function PlayCurrentFormAgain() global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef()
	if !__targetThing
		__targetThing = Game.GetPlayer() as ObjectReference
	endif
	
	if ArtIterator.SelectedFormType == 1
	
		visualeffect levfx = LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
		levfx.Stop(__targetThing)
		
		SetArtObject(levfx, ArtIterator.CurrentForm as art)
		levfx.Play(__targetThing)
	else
		__targetThing.placeatme(ArtIterator.CurrentForm)
	endif
endfunction

function SelectModToBrowse(string modName) global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	
	ArtIterator.SelectedModName = modName
	ArtIterator.SetCurrentIndex(-1)
endfunction

function SelectFormTypeToBrowse(int formTyp) global
	
	if formTyp < 1 || formTyp > 5
		debug.Trace("Everdamned DEBUG: ERROR, form type selected is INVALID")
		return
	endif

	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.SelectedFormType = formTyp
	ArtIterator.SetCurrentIndex(-1)
endfunction

; ---------- SHADERS


string function DoParticleTexture(string ShaderEditorID, string newTexturePath) global
	
	if !ShaderEditorID
		return "No shader specified"
	endif

	effectshader leShader = LookupSomeFormByEditorID(ShaderEditorID) as effectshader
	if !leShader
		return "Shader was not found"
	endif
	
	string oldTexture = GetParticleShaderTexture(leshader)
	
	if !newTexturePath
		return "For shader " + leShader + "; Current particle texture path: " + oldTexture
	endif
		
	SetParticleShaderTexture(leshader, newTexturePath)
	return "For shader " + leShader + "; old particle texture path: " + oldTexture + ", new: " + newTexturePath
endfunction

string function DoParticleCount(string ShaderEditorID, float newParticleCount, float newParticleCount2) global

	if !ShaderEditorID
		return "No shader specified"
	endif
	
	effectshader leShader = LookupSomeFormByEditorID(ShaderEditorID) as effectshader
	if !leShader
		return "Shader was not found"
	endif
	
	float oldFullCount = GetParticleFullCount(leShader)
	float oldPersisentCount = GetParticlePersistentCount(leShader)
	
	if !newParticleCount && !newParticleCount2
		"For shader " + leShader + "nothing new set; Full count: " + oldFullCount + ", Persistent count: " + oldPersisentCount
	endif
	
	if newParticleCount2
		SetParticleFullCount(leShader, newParticleCount)
		SetParticlePersistentCount(leShader, newParticleCount2)
	else
		SetParticleFullCount(leShader, newParticleCount)
		SetParticlePersistentCount(leShader, newParticleCount)
	endif
	
	return "For shader " + leShader + "; Old full count: " + oldFullCount + ", old persistent count: " + oldPersisentCount
endfunction


string function DoParticlecolor(string ShaderEditorID, int theKey, int Rval, int Gval, int Bval, float Aval, float Timeval) global

	if !ShaderEditorID
		return "No shader specified"
	endif
	
	effectshader leShader = LookupSomeFormByEditorID(ShaderEditorID) as effectshader
	if !leShader
		return "Shader was not found"
	endif
	
	int[] RGB = new int[3]
	RGB[0] = Rval
	RGB[1] = Gval
	RGB[2] = Bval
	
	SetParticleColorKeyData(leShader, theKey, RGB, Aval, Timeval)
	
	debug.Trace("Everdamned DEBUG: Setting color for shader " + ShaderEditorID + " " + leShader)
	debug.Trace("Everdamned DEBUG: Key: " + theKey+ "; R:" + Rval + "; G:" + Gval + "; B:" + Bval + "; Alpha: " + Aval + "; Timekey: " + Timeval)
	
endfunction


string function SendAnimevent(string leevent) global

	actor __targetThing = Game.GetCurrentConsoleRef() as actor
	
	if __targetThing
		debug.SendAnimationEvent(__targetThing, leevent)
	endif
	
endfunction

string function PlayFeedIdle(int idleNum, bool solo) global

	actor __targetThing = Game.GetCurrentConsoleRef() as actor
	
	if !__targetThing
		return "No target selected"
	endif
	
	actor playerRef = Game.GetPlayer()
	
	idle idleToPlay
	idle idleToPlaySoloVictim
	idle idleToPlaySoloPlayer
	float backupAnimationVictimOffset
	
	
	globalvariable FeedTypeVar = LookupSomeFormByEditorID("ED_Mechanics_Global_FeedType") as globalvariable
	
	idle IdleHandCut = LookupSomeFormByEditorID("IdleHandCut") as idle
	idle ED_Idle_FeedKM_Solo_Player_Ground = LookupSomeFormByEditorID("ED_Idle_FeedKM_Solo_Player_Ground") as idle
	idle ED_Idle_FeedKM_Solo_Player_Jumpfeed = LookupSomeFormByEditorID("ED_Idle_FeedKM_Solo_Player_Jumpfeed") as idle
	idle ED_Idle_FeedKM_Solo_Player_Bleedout = LookupSomeFormByEditorID("ED_Idle_FeedKM_Solo_Player_Bleedout") as idle
	idle ED_Idle_FeedKM_Solo_Victim_Social = LookupSomeFormByEditorID("ED_Idle_FeedKM_Solo_Victim_Social") as idle
	idle ED_Idle_FeedKM_Solo_Player_Social = LookupSomeFormByEditorID("ED_Idle_FeedKM_Solo_Player_Social") as idle	
	idle ResetRoot = LookupSomeFormByEditorID("ResetRoot") as idle
	
	spell ED_Mechanics_Spell_SetDontMove = LookupSomeFormByEditorID("ED_Mechanics_Spell_SetDontMove") as spell
	spell ED_BeingVampire_VampireFeed_VictimMark_Spell = LookupSomeFormByEditorID("ED_BeingVampire_VampireFeed_VictimMark_Spell") as spell
	
	
	if idleNum == 0
		;vanilla
		solo = false
		FeedTypeVar.SetValue(0.0)
		idleToPlay = LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
		
	elseif idleNum == 3
		FeedTypeVar.SetValue(3.0)
	
		backupAnimationVictimOffset = 50.0  
		
		idleToPlaySoloPlayer = ED_Idle_FeedKM_Solo_Player_Social
		idleToPlaySoloVictim = ED_Idle_FeedKM_Solo_Victim_Social
		
		; paired
		idleToPlay = LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
		
	elseif idleNum == 2
		;jump feed
		FeedTypeVar.SetValue(4.0)
		
		idleToPlaySoloPlayer = ED_Idle_FeedKM_Solo_Player_Jumpfeed
		idleToPlaySoloVictim = IdleHandCut
		backupAnimationVictimOffset = 65.0
		
		; paired
		idleToPlay = LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
		
	elseif idleNum == 1
		;bleedout feed
		FeedTypeVar.SetValue(1.0)
		
		backupAnimationVictimOffset = 60.0
		idleToPlaySoloPlayer = ED_Idle_FeedKM_Solo_Player_Bleedout
		idleToPlaySoloVictim = IdleHandCut
		
		; paired
		idleToPlay = LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
		
	elseif idleNum == 4
		;overpower feed
		FeedTypeVar.SetValue(2.0)
		
		idleToPlaySoloPlayer = ED_Idle_FeedKM_Solo_Player_Ground
		idleToPlaySoloVictim = IdleHandCut
		backupAnimationVictimOffset = 52.0
		
		; paired
		idleToPlay = LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
		
	else
		return "1: bleedout feed, 2: jump feed, 3: social feed, 4: overpower feed"
	endif
	
	float zOffset = __targetThing.GetHeadingAngle(playerRef)
	__targetThing.SetAngle(__targetThing.GetAngleX(), __targetThing.GetAngleY(), __targetThing.GetAngleZ() + zOffset)
			
	ED_BeingVampire_VampireFeed_VictimMark_Spell.Cast(playerRef, __targetThing)
	
	if solo
		
		float playerZ = playerRef.GetPositionZ()
		float targetZ = __targetThing.GetPositionZ()
		
		if playerZ > targetZ
			__targetThing.SetPosition(__targetThing.GetPositionX(), __targetThing.GetPositionY(), playerRef.GetPositionZ())
		else
			playerRef.SetPosition(playerRef.GetPositionX(), playerRef.GetPositionY(), __targetThing.GetPositionZ())
		endif
				
		float playerAngleZsin = math.sin(playerRef.GetAngleZ())
		float playerAngleZcos = math.cos(playerRef.GetAngleZ())
		float targetX = playerRef.GetPositionX() + backupAnimationVictimOffset*playerAngleZsin
		float targetY = playerRef.GetPositionY() + backupAnimationVictimOffset*playerAngleZcos
		
		__targetThing.TranslateTo(targetX, targetY, playerRef.GetPositionZ(),\
								playerRef.GetAngleX(), playerRef.GetAngleY(), playerRef.GetAngleZ() - 180.0,\
								700.0)
		
		ED_Mechanics_Spell_SetDontMove.Cast(__targetThing, __targetThing)
		
		; dont know if needed
		playerRef.PlayIdle(ResetRoot)
		__targetThing.PlayIdle(ResetRoot)
		
		playerRef.PlayIdle(idleToPlaySoloPlayer)
		__targetThing.PlayIdle(idleToPlaySoloVictim)
	else
		playerRef.PlayIdleWithTarget(idleToPlay, __targetThing)
		
		bool __playerIsSynced = playerRef.GetAnimationVariableBool("bIsSynced")
		bool __victimIsSynced = __targetThing.GetAnimationVariableBool("bIsSynced")
		debug.Trace("Everdamned DEBUG: player bIsSynced: " + __playerIsSynced)
		debug.Trace("Everdamned DEBUG: victim bIsSynced: " + __victimIsSynced)
	endif
	
endfunction

string function SetTimeSlowdown(float worldFactor, float playerFactor) global
	SetTimeSlowdown(worldFactor, playerFactor)
endfunction

string function BlendSkinColor(int r, int g, int b, int blendMode, bool autoLum, float opacity) global
	
	actor playerRef = Game.GetPlayer()
	colorform aColor = playerRef.GetActorBase().GetHairColor()
	
	int argb = aColor.GetColor()
	debug.Trace("Everdamned DEBUG: The COLOR: " + argb)
	
	argb = ColorComponent.SetRed(argb, r)
	argb = ColorComponent.SetGreen(argb, g)
	argb = ColorComponent.SetBlue(argb, b)
	
	debug.Trace("Everdamned DEBUG: The COLOR: " + argb)
	
	aColor.SetColor(argb)
	
	PO3_SKSEFunctions.BlendColorWithSkinTone(playerRef, aColor, blendMode, autoLum, opacity)
	
	utility.wait(2)
	PO3_SKSEFunctions.ResetActor3D(playerRef, "PO3_TINT")
	

endfunction

string function PlayPairedIdle(string IdleEditorID, bool reverse) global
	
	debug.Trace("Everdamned DEBUG: args: " + IdleEditorID + ", " + reverse)

	actor __targetThing = Game.GetCurrentConsoleRef() as actor
	
	if !__targetThing
		return "No target selected"
	endif
	
	idle idleToPlay = LookupSomeFormByEditorID(IdleEditorID) as idle
	
	debug.Trace("Everdamned DEBUG: Idle To Play: " + idleToPlay)
	
	if !idleToPlay
		return "No such idle was found"
	endif
	
	actor playerRef = Game.GetPlayer()
	
	if reverse
		__targetThing.PlayIdleWithTarget(idleToPlay, playerRef)
	else
		playerRef.PlayIdleWithTarget(idleToPlay, __targetThing)
	endif
	
endfunction

string function SetupNewTestCharacter() global
	actor playerRef = Game.GetPlayer()
	
	playerRef.SetActorValue("Health", 10000)
	playerRef.SetActorValue("Magicka", 10000)
	playerRef.SetActorValue("Stamina", 10000)
	playerRef.SetActorValue("ED_BloodPool", 10000)
	
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_100_WickedWind_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_10_VigorMortis_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_20_ExtendedPerception_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_30_DeadlyStrength_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_45_NecroticFlesh_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_60_Celerity_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_75_Backstab_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Disciplines_90_FerociousSurge_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTree_Deception_10_EyesOfTheMoon_Perk") as perk)
	utility.wait(0.1)
	
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_FountainOfLife_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_CommandUndead_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_Echolocation_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_FlamesOfColdharbour_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_Gutwrench_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_IcyWinds_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_Maelstrom_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_MarchingFlesh_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_MistForm_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_NightCloak_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_PartingGift_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_ShamblingHordes_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_Tremble_Perk") as perk)
	utility.wait(0.1)
	;playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_UndyingLoyalty_Perk") as perk)
	;utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_UnearthlyWill_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_Vanilla_Chokehold_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_Vanilla_ConjureGargoyle_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(LookupSomeFormByEditorID("ED_PerkTreeVL_WingsOfTheStrix_Perk") as perk)
	
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodSeed_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodBrand_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodGarden_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodScourge_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodScourge_AnkhSwitchAb_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodVortex_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BloodBoil_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(LookupSomeFormByEditorID("ED_VampireSpells_BorrowedTime_Spell") as spell)
	debug.Notification("Char setup finished")
endfunction

string function PlayAnImpactEffect(string editorId, string lenode) global
	debug.Trace("Everdamned DEBUG: PlayAnImpactEffect evd cc called")
	impactdataset aa = LookupSomeFormByEditorID(editorId) as impactdataset
	if !aa
		return "Not found"
	endif
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef() as ObjectReference
	
	if !__targetThing
		return "No target selected"
	endif
	
	return __targetThing.PlayImpactEffect(aa, lenode, 0, 0, -1, 412, true, false)
	
endfunction

string function MeterFlash(int color = 2463422) global
	ED_BloodMeter leMeter = LookupSomeFormByEditorID("ED_BloodMeter_Quest") as ED_BloodMeter
	leMeter.FlashColor = color
	leMeter.StartFlash()
endfunction


string function MeterColors(int a_primaryColor, int a_secondaryColor = -1, int a_flashColor = -1) global
	ED_BloodMeter leMeter = LookupSomeFormByEditorID("ED_BloodMeter_Quest") as ED_BloodMeter
	leMeter.SetColors(a_primaryColor, a_secondaryColor, a_flashColor)
endfunction


string function MeterTransColors(int a_primaryColor, int a_secondaryColor = -1, int a_flashColor = -1, int a_duration = 1000) global
	ED_BloodMeter leMeter = LookupSomeFormByEditorID("ED_BloodMeter_Quest") as ED_BloodMeter
	leMeter.TransitionColors(a_primaryColor, a_secondaryColor, a_flashColor, a_duration)
endfunction

string function BlendSecondUIColor(float highShare, int highStandin, int lowStadin) global

	;bright purple to bright orange
	;11416450 -> 16752947
	colorform ED_Art_Color_UISecondColorHigh = LookupSomeFormByEditorID("ED_Art_Color_UISecondColorHigh") as colorform
	colorform ED_Art_Color_UISecondColorLow = LookupSomeFormByEditorID("ED_Art_Color_UISecondColorLow") as colorform
	
	int startARBG
	int endARGB
	
	debug.Trace("Everdamned DEBUG: highStandin " + highStandin)
	debug.Trace("Everdamned DEBUG: lowStadin " + lowStadin)
	
	if lowStadin != -1	
		ED_Art_Color_UISecondColorLow.SetColor(lowStadin)
	else
		
	endif
	if highStandin != -1
		ED_Art_Color_UISecondColorHigh.SetColor(highStandin)
	endif
	
	startARBG = ED_Art_Color_UISecondColorLow.GetColor()
	endARGB = ED_Art_Color_UISecondColorHigh.GetColor()

	endARGB = ColorComponent.SetRed(endARGB, (ED_Art_Color_UISecondColorHigh.GetRed()*highShare + ED_Art_Color_UISecondColorLow.GetRed()*(1.0-highShare)) as int)
	endARGB = ColorComponent.SetGreen(endARGB, (ED_Art_Color_UISecondColorHigh.GetGreen()*highShare + ED_Art_Color_UISecondColorLow.GetGreen()*(1.0-highShare)) as int)
	endARGB = ColorComponent.SetBlue(endARGB, (ED_Art_Color_UISecondColorHigh.GetBlue()*highShare + ED_Art_Color_UISecondColorLow.GetBlue()*(1.0-highShare)) as int)
	
	debug.Trace("Everdamned DEBUG: The COLOR ARBG: " + endARGB)
	
	ED_BloodMeter leMeter = LookupSomeFormByEditorID("ED_BloodMeter_Quest") as ED_BloodMeter
	leMeter.SetColors(11141120, endARGB, endARGB)
	
	
endfunction
