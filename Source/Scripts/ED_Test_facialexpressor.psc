Scriptname ED_Test_facialexpressor extends ActiveMagicEffect


Event OnEffectStart(Actor akTarget, Actor akCaster) 

debug.notification("start")
EmotionalAndPhonemeTide(akTarget, 10, 1, 95, 0.1)

EndEvent

function EmotionalTide(Actor akTarget, int e_id, int e_strength, float delta)
	
	int i = 0
	while i < e_strength
		akTarget.SetExpressionOverride(e_id,i)
		i = i + 5
		if (i > 95)
			i = 95
		Endif
		Utility.Wait(0.1)
	endwhile
	
endfunction

function EmotionalAndPhonemeTide(Actor akTarget, int e_id, int p_id, int strength, float delta)

	int i = 0
	while i < strength
		akTarget.SetExpressionOverride(e_id, i)
		MfgConsoleFunc.SetPhoneme(akTarget, p_id, i) 
		i = i + 5
		if (i > 95)
			i = 95
		Endif
		Utility.Wait(0.1)
	endwhile
	
endfunction


Event OnEffectFinish(Actor akTarget, Actor akCaster)
debug.notification("finish")
akTarget.ClearExpressionOverride()
MfgConsoleFunc.SetPhoneme(akTarget, 1, 0) 
EndEvent
