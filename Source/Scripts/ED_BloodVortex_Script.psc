Scriptname ED_BloodVortex_Script extends activemagiceffect  


ObjectReference TheOrb

function OnEffectStart(Actor akTarget, Actor akCaster)
	;remake hazard spawning from here
	;or make all spawning happen on alias to allow recasting in different place
	;or add cooldown of same length as spell duration to prefent spawning new
	TheOrb = akCaster.PlaceAtMe(ED_Art_BloodVortex, 1, false, true)
	TheOrb.SetAngle(0 as Float, 0 as Float, 0 as Float)
	TheOrb.MoveTo(akCaster as ObjectReference, 0 as Float, 0 as Float, 170 as Float, true)
	;TheOrb.SetScale(4.0)
	TheOrb.PlaceAtMe(ED_Art_Explosion_VampireAbsorb, 1, false, false)
	TheOrb.Enable(true)
	ED_Art_VFX_BatsCloak.Play(TheOrb)
	if 
	ED_BloodVortex.ForceRefTo(TheOrb)
	
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	; command finish 
endFunction


activator property ED_Art_BloodVortex auto

ReferenceAlias Property ED_BloodVortex  Auto 

Explosion Property ED_Art_Explosion_VampireAbsorb auto

VisualEffect property ED_Art_VFX_BatsCloak auto