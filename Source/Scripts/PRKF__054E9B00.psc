;/ Decompiled by Champollion V1.0.1
Source   : DLC1_PRKF_DLC1VampiricGrip_0100599A.psc
Modified : 2020-12-09 01:41:33
Compiled : 2020-12-09 01:41:34
User     : maxim
Computer : CANOPUS
/;
scriptName DLC1_PRKF_DLC1VampiricGrip_0100599A extends Perk hidden

;-- Properties --------------------------------------
imagespacemodifier property VampireTransformDecreaseISMD auto
message property DLCPlayerVampireFeedMsg auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function Fragment_1(ObjectReference akTargetRef, Actor akActor)

	VampireTransformDecreaseISMD.applyCrossFade(2.00000)
	utility.wait(2.00000)
	imagespacemodifier.removeCrossFade(1.00000)
	(akTargetRef as Actor).DamageAV("health", 25 as Float)
	game.IncrementStat("Necks Bitten", 1)
	DLCPlayerVampireFeedMsg.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
endFunction
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname PRKF__054E9B00 Extends Perk Hidden

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
