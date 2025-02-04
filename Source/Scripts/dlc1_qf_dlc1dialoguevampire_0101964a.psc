;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 70
Scriptname DLC1_QF_DLC1DialogueVampire_0101964A Extends Quest Hidden

;BEGIN FRAGMENT Fragment_64
Function Fragment_64()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
    game.GetPlayer().AddSpell(ED_VampireSpellsVL_IcyWinds_Spell, true)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_59
Function Fragment_59()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_63
Function Fragment_63()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_66
Function Fragment_66()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
    game.GetPlayer().AddSpell(ED_VampireSpellsVL_FlamesOfColdharbour_Spell, true)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    game.GetPlayer().AddSpell(DLC1DetectLife, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
        game.GetPlayer().AddSpell(DLC1ConjureGargoyleLeftHand, true)
    endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_48
Function Fragment_48()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_69
Function Fragment_69()
;BEGIN CODE
game.GetPlayer().EquipSpell(ED_VampireSpellsVL_Raze_Spell, 1)
game.IncrementStat("NumVampirePerks", 1)
DLC1PlayerVampireQuest.EstablishLeveledSpells()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_68
Function Fragment_68()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
        game.GetPlayer().AddSpell(ED_VampireSpellsVL_ShamblingHordes_Spell, true)
    endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
; strix
    game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_65
Function Fragment_65()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
        game.GetPlayer().AddSpell(ED_VampireSpellsVL_Maelstrom_Spell, true)
    endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_53
Function Fragment_53()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
; Royal Bloodline
    game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
        game.GetPlayer().AddSpell(DLC1CorpseCurse, true)
    endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    game.GetPlayer().AddSpell(DLC1VampireMistform, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
; poison talons
    game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
        game.GetPlayer().AddSpell(DLC1VampiresGrip, true)
    endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
game.GetPlayer().AddSpell(DLC1NightCloak, true)
    game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_57
Function Fragment_57()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    game.GetPlayer().RemoveItem(DLC1ClothesVampireLordArmor as form, 2, true, none)
    game.GetPlayer().EquipItem(DLC1ClothesVampireLordRoyalArmor as form, false, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_51
Function Fragment_51()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
; fountain of life
    game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
; tremble
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
; unearthly will
    game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_55
Function Fragment_55()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_67
Function Fragment_67()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
    if DLC1VampireLevitateStateGlobal.GetValue() == 2 as Float
        game.GetPlayer().AddSpell(ED_VampireSpellsVL_MarchingFlesh_Spell, true)
    endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_49
Function Fragment_49()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_56
Function Fragment_56()
;BEGIN CODE
game.GetPlayer().AddSpell(ED_VampirePowersVL_RoyalGuardian_Ab_Spell, true)
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_61
Function Fragment_61()
;BEGIN CODE
game.IncrementStat("NumVampirePerks", 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

spell property ED_VampirePowersVL_RoyalGuardian_Ab_Spell auto
spell property ED_VampireSpellsVL_FlamesOfColdharbour_Spell auto
spell property ED_VampireSpellsVL_IcyWinds_Spell auto
spell property ED_VampireSpellsVL_MarchingFlesh_Spell auto
spell property ED_VampireSpellsVL_ShamblingHordes_Spell auto
spell property ED_VampireSpellsVL_Raze_Spell auto

spell property DLC1VampireMistform auto
spell property DLC1VampiresGrip auto
spell property DLC1CorpseCurse auto
dlc1playervampirechangescript property DLC1PlayerVampireQuest auto
globalvariable property DLC1VampireLevitateStateGlobal auto
spell property DLC1NightCloak auto
spell property ED_VampireSpellsVL_Maelstrom_Spell auto
spell property DLC1ConjureGargoyleLeftHand auto
spell property DLC1VampireBats auto
armor property DLC1ClothesVampireLordRoyalArmor auto
armor property DLC1ClothesVampireLordArmor auto
spell property DLC1DetectLife auto
