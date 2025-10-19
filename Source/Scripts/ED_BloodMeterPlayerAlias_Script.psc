Scriptname ED_BloodMeterPlayerAlias_Script extends ReferenceAlias  


event OnPlayerLoadGame()
	debug.Trace("Everdamned DEBUG: Blood Meter quest player alias on load called")
	(GetOwningQuest() as ED_BloodMeterUpdate).OnGameReload()
endEvent
