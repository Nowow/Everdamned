Scriptname ED_NecroticFleshQuest_Script extends Quest  


string defaultOverlayPath = "Actors\\Character\\Overlays\\Default.dds"
string NecroticFleshOverlayPath_Body = "textures\\Everdamned\\overlays\\necrotic_flesh_body_stony.dds"
string storageKeyOverride = "Everdamned_NF_"

;body parts: "Body", "Face"

int property BodyOverlaySlot auto
int property FaceOverlaySlot auto



string function _getAppliedBodypaintName(Actor target, bool isFemale, string area, int slot)
	string nodeName = area + " [ovl" + slot + "]"
	return NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0)
endfunction


int function _find_empty_Slot(Actor target, bool isFemale, string bodyPart)
	string nodeName = bodyPart + " [ovl0]"
	int lastOverlay = NiOverride.GetNumBodyOverlays() - 1
	int n = 0
	bool full = NiOverride.HasNodeOverride(target, isFemale, nodeName, 9, 0)
	if (full)
		full = (NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0) != defaultOverlayPath)
		while (full)
			n += 1
			nodeName = bodyPart + " [ovl" + n + "]"
			full = NiOverride.HasNodeOverride(target, isFemale, nodeName, 9, 0)
			Utility.Wait(0.01)
			if(full)
				full = (NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0) != defaultOverlayPath)
			endif
			Utility.Wait(0.01)
			if (n==lastOverlay)
				full = false
			endif
		endWhile
	endif

	return n
endfunction


Function _addTexture(Actor npc, string texture, string bodyPart, int nifTextureIndex = 0)
	
	int nifTextureKey = 9
	
    debug.Trace("Everdamned DEBUG: Adding texture to "+bodyPart+": "+ texture + " storageKey: "+storageKeyOverride)
    

    bool isFemale =(npc.GetActorBase().GetSex() != 0)
    string stKey = storageKeyOverride+bodyPart
	int slot = 0

    if texture
		slot = _find_empty_Slot(npc, isFemale, bodyPart)
		
		string nodeName = bodyPart + " [ovl" + slot + "]"

		debug.Trace("Everdamned DEBUG: Overlay-slot: " + nodeName)
		debug.Trace("Everdamned DEBUG: overlay index: "+ nifTextureIndex)

		;string currenText = NiOverride.GetNodeOverrideString(npc, isFemale, nodeName, nifTextureKey, nifTextureIndex)
		; debugConsole("after Current texture: "+currenText)
		
		NiOverride.AddNodeOverrideString(npc, isFemale, nodeName, nifTextureKey, 0, texture, true)        
		;NiOverride.AddNodeOverrideInt(npc, isFemale, nodeName, 0, nifTextureIndex, BlackSkinColor.GetColor(), true)
		NiOverride.AddOverlays(npc)
		
		if bodyPart == "Body"
			BodyOverlaySlot = slot
		else
			FaceOverlaySlot = slot
		endif
		;body parts: "Body", "Face"

		debug.Trace("Everdamned DEBUG: Applied  " + _getAppliedBodypaintName(npc, isFemale, bodyPart, slot))
		;debug.Trace("Everdamned DEBUG: StorageUtil "+ stKey + "size - "+StorageUtil.IntListCount(npc, stKey))
		
	endif
    
EndFunction

Function _removeTexture(Actor npc, string bodyPart)
    debug.Trace("Everdamned DEBUG: Removing texture from "+bodyPart)
    
	int slot
	if bodyPart == "Body"
		slot = BodyOverlaySlot
	else
		slot = FaceOverlaySlot
	endif
	
    bool isFemale =(npc.GetActorBase().GetSex() != 0)
    string stKey = storageKeyOverride+bodyPart
	string nodeName = bodyPart + " [ovl" + slot + "]"
	
	debug.Trace("Everdamned DEBUG: Removing decal: " + _getAppliedBodypaintName(npc, isFemale, bodyPart, slot))
	
	NiOverride.AddNodeOverrideString(npc, isFemale, nodeName, 9, 0, defaultOverlayPath, true)
	Utility.Wait(0.01)
	NiOverride.RemoveNodeOverride(npc, isFemale, nodeName, 9, 0)

EndFunction


Function addStonyOverlays()
    debug.Trace("Everdamned DEBUG: Necrotic Flesh Quests adds overlays")
    
    ;_addTexture(npc, faceTextureList, "Face")
    _addTexture(playerRef, NecroticFleshOverlayPath_Body, "Body")

EndFunction

Function removeStonyOverlays()
    debug.Trace("Everdamned DEBUG: Necrotic Flesh Quests adds overlays")
   
    _removeTexture(playerRef, "Body")

EndFunction


function OnStartup()
	playerRef.AddSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell, false)
	ED_Art_Shader_NecroticFleshToggleOn.Play(playerRef, 1.0)
	utility.wait(0.3)
	PO3_SKSEFunctions.BlendColorWithSkinTone(playerRef, BlackSkinColor, 0, false, 1.4)
	addStonyOverlays()
	ED_Art_Shader_NecroticFleshToggleOn.Stop(playerRef)
	ED_Art_Shader_NecroticFleshToggleOnStoneskin.Play(playerRef, 5.0)
endfunction

function OnShutdown()
	playerRef.RemoveSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell)
	removeStonyOverlays()
	ED_Art_Shader_NecroticFleshToggleOff.Play(playerRef, 2.0)
	;fade in time, full duration = 1.0
	utility.wait(0.5)
	ED_Art_Shader_GargoyleStoneChips.Play(playerRef, 2.0)
	PO3_SKSEFunctions.BlendColorWithSkinTone(playerRef, BlackSkinColor, 0, false, 0.0)
endfunction

function PauseUnpause()
	if playerRef.HasSpell(ED_VampirePowers_Pw_NecroticFlesh_Spell)
		debug.Trace("Everdamned DEBUG: Necrotic Flesh Quests PAUSES effect")
		OnShutdown()
	else
		debug.Trace("Everdamned DEBUG: Necrotic Flesh Quests UNPAUSES effect")
		
		OnStartup()
	endif
endfunction


event OnInit()
	BlackSkinColor = Game.GetFormFromFile(0xD56A61, "Everdamned.esp") as colorform
endevent


actor property playerRef auto
colorform property BlackSkinColor auto
spell property ED_VampirePowers_Pw_NecroticFlesh_Spell auto

effectshader property ED_Art_Shader_GargoyleStoneChips auto
effectshader property ED_Art_Shader_NecroticFleshToggleOff auto
effectshader property ED_Art_Shader_NecroticFleshToggleOnStoneskin auto
effectshader property ED_Art_Shader_NecroticFleshToggleOn auto
