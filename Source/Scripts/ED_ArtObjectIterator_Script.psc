Scriptname ED_ArtObjectIterator_Script extends Quest  

import ED_SKSEnativebindings

string property TargetModName = "" auto
int property CurrentIndex = 0 auto

art property CurrentArtObject auto
explosion property CurrentExplosion auto
projectile property CurrentProjectile auto
activator property CurrentActivator auto
hazard property CurrentHazard auto

form property CurrentForm auto

int property SelectedFormType = 1 auto
string property SelectedModName auto

string property CurrentFormEditorID auto
string property CurrentModName auto
		 

function SetCurrentIndex(int i)
	CurrentIndex = i
	debug.Trace("Everdamned DEBUG: Art Iterator current index is now: " + CurrentIndex)
endfunction


function SetupFormMaps()
	debug.Trace("Everdamned DEBUG: Art Iterator set up form maps")
	ED_SKSEnativebindings.SetupFormMaps()
endfunction

function GetNextForm(bool forward)
	
	CurrentArtObject = None
	CurrentFormEditorID = None
	CurrentModName = None
	
	if forward
		SetCurrentIndex(CurrentIndex + 1)
	else
		SetCurrentIndex(CurrentIndex - 1)
	endif
	
	if SelectedFormType < 1 || SelectedFormType > 5
		debug.Trace("Everdamned DEBUG: ERROR, cant give you needed form because form type is wrong")
	endif
	
	if SelectedFormType == 1
		CurrentArtObject = GetArtObjectByIndex(SelectedModName, CurrentIndex)
		CurrentForm = CurrentArtObject as form
	elseif SelectedFormType == 2
		CurrentExplosion= GetExplosionByIndex(SelectedModName, CurrentIndex)
		CurrentForm = CurrentExplosion as form
	elseif SelectedFormType == 3
		CurrentProjectile = GetProjectileByIndex(SelectedModName, CurrentIndex)
		CurrentForm = CurrentProjectile as form
	elseif SelectedFormType == 4
		CurrentActivator = GetActivatorByIndex(SelectedModName, CurrentIndex)
		CurrentForm = CurrentActivator as form
	elseif SelectedFormType == 5
		CurrentHazard = GetHazardByIndex(SelectedModName, CurrentIndex)
		CurrentForm = CurrentHazard as form
	endif

	
	if !CurrentForm
		debug.Trace("Everdamned DEBUG: Art Iterator tried to get Form at index " + CurrentIndex + ", but it was None")
		return
	endif
	
	CurrentFormEditorID = PO3_SKSEFunctions.GetFormEditorID(CurrentForm)
	CurrentModName = PO3_SKSEFunctions.GetFormModName(CurrentForm, false)
		
	debug.Trace("Everdamned DEBUG: Current form: " + CurrentFormEditorID + " from mod " + CurrentModName + " " + CurrentForm)
	
endfunction

function LogCurrentForm(string commentStr)
	debug.Trace("Everdamned DEBUG: FORM IS CHOSEN FOR ASCENTION: ;" + CurrentFormEditorID + ";" + commentStr +";" + CurrentModName + ";" + CurrentForm)
endfunction
