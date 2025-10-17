Scriptname ED_IMODnSoundFX_Script extends activemagiceffect  

int soundID
Event OnEffectStart(Actor Target, Actor Caster)
	ED_Art_Imod_BloodSenseIntro.Apply()
	soundID = ED_Art_SoundM_Bloodsense.Play(Target)
	utility.wait(1.5)
	ED_Art_Imod_BloodSenseIntro.PopTo(ED_Art_Imod_BloodSenseLoop)
endevent

Event OnEffectFinish(Actor Target, Actor Caster)
	ED_Art_Imod_BloodSenseLoop.PopTo(ED_Art_Imod_BloodSenseOutro)
	Sound.StopInstance(soundID)
	ED_Art_Imod_BloodSenseIntro.Remove()
endevent


imagespacemodifier property ED_Art_Imod_BloodSenseIntro auto
imagespacemodifier property ED_Art_Imod_BloodSenseLoop auto
imagespacemodifier property ED_Art_Imod_BloodSenseOutro auto
sound property ED_Art_SoundM_Bloodsense auto
