Scriptname ED_SKSEnativebindings hidden

; casts summon/reanimate/command spell and return summoned actor
;form function CommandSpellAndReturnActor() global native

;string function PapyrusNativeFunctionBinding(int numba) global native

;string function GetProvidedSpellName(spell spellWithName) global native

;actor function GetEffectCaster(activemagiceffect AMEffect) global native

actor function GetActiveEffectCommandedActor(activemagiceffect AMEffect) global native

function IncreaseActiveEffectDuration(activemagiceffect AMEffect, float delta) global native
