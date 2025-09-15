Scriptname ED_SKSEnativebindings hidden

; casts summon/reanimate/command spell and return summoned actor
;form function CommandSpellAndReturnActor() global native

;string function PapyrusNativeFunctionBinding(int numba) global native

;string function GetProvidedSpellName(spell spellWithName) global native

;actor function GetEffectCaster(activemagiceffect AMEffect) global native

actor function GetActiveEffectCommandedActor(activemagiceffect AMEffect) global native

function IncreaseActiveEffectDuration(activemagiceffect AMEffect, float delta) global native

int[] function GetAdjustedAvForComparison(actor thisActor, int playerLevel, int skillsPerLevelSetting, int skillBaseSetting) global native

bool function DispelAllSlowTimeEffects() global native

function SetTimeSlowdown(float worldFactor, float playerFactor) global native

bool function ValidateArmorRace(armor leArmor) global native


function StopAllShadersExceptThis(effectshader a_effectShader, keyword someKeyword, effectshader ED_TestShader2_empty) global native

form function LookupSomeFormByEditorID(string editorID) global native

function SetupFormMaps() global native

art function GetArtObjectByIndex(string SelectedModName, int i) global native
explosion function GetExplosionByIndex(string SelectedModName, int i) global native
projectile function GetProjectileByIndex(string SelectedModName, int i) global native
activator function GetActivatorByIndex(string SelectedModName, int i) global native
hazard function GetHazardByIndex(string SelectedModName, int i) global native

