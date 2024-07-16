Scriptname ED_PlayerVampireGarkainBeast_Revert extends ActiveMagicEffect  

GLOBALVARIABLE PROPERTY pDLC1nVampireNecklaceBats Auto
GLOBALVARIABLE PROPERTY pDLC1nVampireNecklaceGargoyle Auto
GLOBALVARIABLE PROPERTY pDLC1nVampireRingBeast Auto
GLOBALVARIABLE PROPERTY pDLC1nVampireRingErudite Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Game.GetPlayer().RemoveSpell(ED_VampirePowers_GarkainBeast_Revert)
	
	;turn off all the vampire necklace/ring variables when we change back
    pDLC1nVampireNecklaceBats.setValue(0)
	pDLC1nVampireNecklaceGargoyle.setValue(0)
	pDLC1nVampireRingBeast.setValue(0)
	pDLC1nVampireRingErudite.setValue(0)

	If !Game.GetPlayer().IsInKillMove()
		ED_PlayerVampireGarkainQuest.Revert()
	endif
EndEvent


SPELL Property ED_VampirePowers_GarkainBeast_Revert  Auto  

ED_PlayerVampireGarkainChangeScript property ED_PlayerVampireGarkainQuest Auto
