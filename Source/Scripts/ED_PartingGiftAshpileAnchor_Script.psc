Scriptname ED_PartingGiftAshpileAnchor_Script extends ObjectReference  


function OnLoad()
	; create landing target
	
	actor victim = ED_PartingGiftLastTarget.GetReference() as actor
	
	if victim
		victim.disable()
		utility.wait(0.1)
		victim.moveto(self)
		victim.enable(true)
		utility.wait(0.1)
		victim.SetCriticalStage(victim.CritStage_DisintegrateStart)
		victim.AttachAshPile(ED_Art_Ashpile_RedGoo)
		victim.SetCriticalStage(victim.CritStage_DisintegrateEnd)
		debug.Trace("Everdamned DEBUG: Parting Gift ashpile attached from anchor")
	else
		debug.Trace("Everdamned ERROR: Parting Gift anchor COULD NOT attach ashpile because nothing in ED_PartingGiftLastTarget alias")
	endif
	
	utility.Wait(0.500000)
	self.Delete()
endFunction


referencealias property ED_PartingGiftLastTarget auto
activator property ED_Art_Ashpile_RedGoo auto
