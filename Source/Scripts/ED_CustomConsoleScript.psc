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
	
	if idleNum == 3
		;social
		FeedTypeVar.SetValue(3.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	elseif idleNum == 2
		;jump feed
		FeedTypeVar.SetValue(2.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	elseif idleNum == 1
		;bleedout feed
		FeedTypeVar.SetValue(1.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	elseif idleNum == 4
		;overpower feed
		FeedTypeVar.SetValue(1.0)
		idleToPlay = ED_SKSEnativebindings.LookupSomeFormByEditorID("IdleVampireStandingFeedFront_Loose") as idle
	else
		return "1: bleedout feed, 2: jump feed, 3: social feed, 4: overpower feed"
	endif
	
	playerRef.PlayIdleWithTarget(idleToPlay, __targetThing)
	
endfunction
