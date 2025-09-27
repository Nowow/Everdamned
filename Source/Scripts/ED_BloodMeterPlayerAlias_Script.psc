Scriptname ED_BloodMeterPlayerAlias_Script extends ReferenceAlias  


event OnPlayerLoadGame()
	(GetOwningQuest() as ED_BloodMeterUpdate).OnGameReload()
endEvent
