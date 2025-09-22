Scriptname ED_CustomConsoleScript Hidden

import PO3_SKSEFunctions

string function PlayVisualEffectFromString(string editorID) global
	
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString called!")
	
	visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString got this form: " + levfx)
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef()
	if !__targetThing
		__targetThing = Game.GetPlayer() as ObjectReference
	endif
	
	
	;levfx.Stop(__targetThing)
	
	art leform = ED_SKSEnativebindings.LookupSomeFormByEditorID(editorID) as art
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
	visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
	
;	if editorID && editorID != ""
;		art leform = ED_SKSEnativebindings.LookupSomeFormByEditorID(editorID) as art
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
		
		visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
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
	
		visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
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
	
		visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
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

	effectshader leShader = ED_SKSEnativebindings.LookupSomeFormByEditorID(ShaderEditorID) as effectshader
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
	
	effectshader leShader = ED_SKSEnativebindings.LookupSomeFormByEditorID(ShaderEditorID) as effectshader
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
	
	effectshader leShader = ED_SKSEnativebindings.LookupSomeFormByEditorID(ShaderEditorID) as effectshader
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

string function PlayFeedIdle(int idleNum) global

	actor __targetThing = Game.GetCurrentConsoleRef() as actor
	
	if !__targetThing
		return "No target selected"
	endif
	
	actor playerRef = Game.GetPlayer()
	
	idle idleToPlay
	globalvariable FeedTypeVar = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_Mechanics_Global_FeedType") as globalvariable
	
	if idleNum == 0
		;vanilla
		FeedTypeVar.SetValue(0.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
		
	elseif idleNum == 3
		;social
		FeedTypeVar.SetValue(3.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	elseif idleNum == 2
		;jump feed
		FeedTypeVar.SetValue(4.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	elseif idleNum == 1
		;bleedout feed
		FeedTypeVar.SetValue(1.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	elseif idleNum == 4
		;overpower feed
		FeedTypeVar.SetValue(2.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	else
		return "1: bleedout feed, 2: jump feed, 3: social feed, 4: overpower feed"
	endif
	
	playerRef.PlayIdleWithTarget(idleToPlay, __targetThing)
	
endfunction

string function SetTimeSlowdown(float worldFactor, float playerFactor) global
	ED_SKSEnativebindings.SetTimeSlowdown(worldFactor, playerFactor)
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
	
	idle idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID(IdleEditorID) as idle
	
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
	
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_100_WickedWind_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_10_VigorMortis_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_20_ExtendedPerception_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_30_DeadlyStrength_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_45_NecroticFlesh_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_60_Celerity_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_75_Backstab_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Disciplines_90_FerociousSurge_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTree_Deception_10_EyesOfTheMoon_Perk") as perk)
	utility.wait(0.1)
	
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_FountainOfLife_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_CommandUndead_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_Echolocation_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_FlamesOfColdharbour_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_Gutwrench_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_IcyWinds_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_Maelstrom_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_MarchingFlesh_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_MistForm_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_NightCloak_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_PartingGift_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_ShamblingHordes_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_Tremble_Perk") as perk)
	utility.wait(0.1)
	;playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_UndyingLoyalty_Perk") as perk)
	;utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_UnearthlyWill_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_Vanilla_Chokehold_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_Vanilla_ConjureGargoyle_Perk") as perk)
	utility.wait(0.1)
	playerRef.addperk(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_PerkTreeVL_WingsOfTheStrix_Perk") as perk)
	
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodSeed_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodBrand_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodGarden_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodScourge_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodScourge_AnkhSwitchAb_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodVortex_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BloodBoil_Spell") as spell)
	utility.wait(0.1)
	playerRef.addspell(ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_VampireSpells_BorrowedTime_Spell") as spell)
	debug.Notification("Char setup finished")
endfunction

string function PlayAnImpactEffect(string editorId, string lenode) global
	debug.Trace("Everdamned DEBUG: PlayAnImpactEffect evd cc called")
	impactdataset aa = ED_SKSEnativebindings.LookupSomeFormByEditorID(editorId) as impactdataset
	if !aa
		return "Not found"
	endif
	
	ObjectReference __targetThing = Game.GetCurrentConsoleRef() as ObjectReference
	
	if !__targetThing
		return "No target selected"
	endif
	
	return __targetThing.PlayImpactEffect(aa, lenode, 0, 0, -1, 412, true, false)
	
endfunction
