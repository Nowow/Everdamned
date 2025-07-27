Scriptname ED_CustomConsoleScript Hidden

string function PlayVisualEffectFromString(string editorID) global
	
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString called!")
	
	visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString got this form: " + levfx)
	
	levfx.Stop(Game.GetPlayer())
	
	art leform = ED_SKSEnativebindings.LookupSomeFormByEditorID(editorID) as art
	debug.Trace("Everdamned DEBUG: PlayVisualEffectFromString got this form: " + leform)
	
	if !leform
		return "Didnt find shi"
	endif
	
	PO3_SKSEFunctions.SetArtObject(levfx, leform)
	
	levfx.Play(Game.GetPlayer())
	
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
;		PO3_SKSEFunctions.SetArtObject(levfx, leform)
;	endif
	
	levfx.Stop(Game.GetPlayer())
	
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
	
	if ArtIterator.SelectedFormType == 1
	
		visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
		levfx.Stop(Game.GetPlayer())
		
		PO3_SKSEFunctions.SetArtObject(levfx, ArtIterator.CurrentForm as art)
		levfx.Play(Game.GetPlayer())
	else
		Game.GetPlayer().placeatme(ArtIterator.CurrentForm)
	endif
	
endfunction

function PlayPrevious() global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.GetNextForm(false)
	
	debug.Trace("Everdamned DEBUG: Current Form: " + ArtIterator.CurrentForm)
	
	if ArtIterator.SelectedFormType == 1
	
		visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
		levfx.Stop(Game.GetPlayer())
		
		PO3_SKSEFunctions.SetArtObject(levfx, ArtIterator.CurrentForm as art)
		levfx.Play(Game.GetPlayer())
	else
		Game.GetPlayer().placeatme(ArtIterator.CurrentForm)
	endif
endfunction

function SaveCurrentForm(string commentStr) global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	ArtIterator.LogCurrentForm(commentStr)
endfunction

function PlayCurrentFormAgain() global
	ED_ArtObjectIterator_Script ArtIterator = Quest.GetQuest("ED_Mechanics_HotKeys_Quest") as ED_ArtObjectIterator_Script
	
	if ArtIterator.SelectedFormType == 1
	
		visualeffect levfx = ED_SKSEnativebindings.LookupSomeFormByEditorID("ED_TEST_Vfx") as visualeffect
		levfx.Stop(Game.GetPlayer())
		
		PO3_SKSEFunctions.SetArtObject(levfx, ArtIterator.CurrentForm as art)
		levfx.Play(Game.GetPlayer())
	else
		Game.GetPlayer().placeatme(ArtIterator.CurrentForm)
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
