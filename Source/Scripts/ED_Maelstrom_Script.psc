Scriptname ED_Maelstrom_Script extends ObjectReference  

referencealias property ED_Maelstrom_Source auto
spell property ED_VampireSpellsVL_Maelstrom_Proc_Spell auto


function OnLoad()

	ED_Maelstrom_Source.ForceRefTo(self as ObjectReference)
	ED_VampireSpellsVL_Maelstrom_Proc_Spell.Cast(self as ObjectReference, none)
	utility.Wait(2.00000)
	ED_Maelstrom_Source.Clear()
	self.Delete()
endFunction