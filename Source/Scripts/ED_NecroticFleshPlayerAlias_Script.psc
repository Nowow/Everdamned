Scriptname ED_NecroticFleshPlayerAlias_Script extends ReferenceAlias


event OnInit()
	BlackSkinColor = Game.GetFormFromFile(0xD56A61, "Everdamned.esp") as colorform
endevent


Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	PO3_SKSEFunctions.BlendColorWithSkinTone(playerRef, BlackSkinColor, 0, false, 1.4)
endevent


Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	PO3_SKSEFunctions.BlendColorWithSkinTone(playerRef, BlackSkinColor, 0, false, 1.4)
endevent


actor property playerRef auto
colorform property BlackSkinColor auto
