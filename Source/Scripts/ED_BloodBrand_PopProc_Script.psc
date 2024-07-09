Scriptname ED_BloodBrand_PopProc_Script extends ActiveMagicEffect  


;-- Properties --------------------------------------
Bool property SCS_FromCaster auto
spell property SCS_Proc auto
Float property SCS_Value auto
spell property SCS_CastSpell auto
Bool property SCS_DispelAfterMinDur auto
Float property SCS_MinDur auto

;-- Variables ---------------------------------------
Bool CanTrigger = false

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function OnEffectFinish(Actor akTarget, Actor akCaster)

	if CanTrigger
;		if SCS_FromCaster
;			SCS_Proc.Cast(akCaster as objectreference, akTarget as objectreference)
;		else
			SCS_Proc.Cast(akTarget as objectreference, none)
;		endIf
	endIf
endFunction

; Skipped compiler generated GetState

function OnEffectStart(Actor akTarget, Actor akCaster)

	self.RegisterForSingleUpdate(SCS_MinDur)
endFunction

function OnUpdate()

	CanTrigger = true
	if SCS_DispelAfterMinDur
		self.GetTargetActor().DispelSpell(SCS_CastSpell)
	endIf
endFunction