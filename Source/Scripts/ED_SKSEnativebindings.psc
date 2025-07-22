Scriptname ED_SKSEnativebindings hidden

; casts summon/reanimate/command spell and return summoned actor
;form function CommandSpellAndReturnActor() global native

;string function PapyrusNativeFunctionBinding(int numba) global native

;string function GetProvidedSpellName(spell spellWithName) global native

;actor function GetEffectCaster(activemagiceffect AMEffect) global native

actor function GetActiveEffectCommandedActor(activemagiceffect AMEffect) global native

function IncreaseActiveEffectDuration(activemagiceffect AMEffect, float delta) global native

int[] function GetAdjustedAvForComparison(actor thisActor, int playerLevel, int skillsPerLevelSetting, int skillBaseSetting) global native

function StopAllShadersExceptThis(effectshader a_effectShader, keyword someKeyword, effectshader ED_TestShader2_empty) global native

form function LookupSomeFormByEditorID(string editorID) global native
