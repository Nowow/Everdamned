Scriptname ED_NIOverrideStuff_Script 

Function _removeAllVFDOverlays(Actor npc)
    debugConsole("Removing texture: Body blood")
    
    int i = 0
    bool isFemale =(npc.GetActorBase().GetSex() != 0)
    int slot = _find_empty_Slot(npc, isFemale, "Body")
    
    while (i<slot)
        string nodeName = "Body" + " [ovl" + i + "]"
        debugConsole("Filled slot 'Body': "+i)
        string tex = NiOverride.GetNodeOverrideString(npc, isFemale, nodeName, 9, 0)
        If StringContains(tex, "VFD")
            NiOverride.AddNodeOverrideString(npc, isFemale, nodeName, 9, 0, _DefaultOverlay(), true)
            Utility.Wait(0.01)
            NiOverride.RemoveNodeOverride(npc, isFemale, nodeName, 9, 0)
        EndIf
        i +=1
    endWhile

    i = 0

    debugConsole("Removing texture Face blood")
    slot = _find_empty_Slot(npc, isFemale, "Face")

    while (i<slot)
        string nodeName = "Face" + " [ovl" + i + "]"
        debugConsole("Filled slot Body: "+i)
        string tex = NiOverride.GetNodeOverrideString(npc, isFemale, nodeName, 9, 0)
        If StringContains(tex, "VFD")
            NiOverride.AddNodeOverrideString(npc, isFemale, nodeName, 9, 0, _DefaultOverlay(), true)
            Utility.Wait(0.01)
            NiOverride.RemoveNodeOverride(npc, isFemale, nodeName, 9, 0)
        EndIf
        i +=1
    endWhile

Endfunction

int function _find_empty_Slot(Actor target, bool isFemale, string area)
	string nodeName = area + " [ovl0]"
	int lastOverlay = NiOverride.GetNumBodyOverlays() - 1
	int n = 0
	bool full = NiOverride.HasNodeOverride(target, isFemale, nodeName, 9, 0)
	if (full)
		full = (NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0) != _DefaultOverlay())
		while (full)
			n += 1
			nodeName = area + " [ovl" + n + "]"
			full = NiOverride.HasNodeOverride(target, isFemale, nodeName, 9, 0)
			Utility.Wait(0.01)
			if(full)
				full = (NiOverride.GetNodeOverrideString(target, isFemale, nodeName, 9, 0) != _DefaultOverlay())
			endif
			Utility.Wait(0.01)
			if (n==lastOverlay)
				full = false
			endif
		endWhile
	endif
	;Debug.Notification(n)
	return n
endfunction
