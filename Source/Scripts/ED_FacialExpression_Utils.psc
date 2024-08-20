Scriptname ED_FacialExpression_Utils Hidden

function EmotionalTide(Actor akTarget, int id, int strength, int delta) global
	
	int i = 0
	while i < strength
		akTarget.SetExpressionOverride(id, i)
		i = i + delta
		if (i > 95)
			i = 95
		Endif
		Utility.Wait(0.1)
	endwhile
	
endfunction

function PhonemeTide(Actor akTarget, int id, int strength, int delta) global
	
	int i = 0
	while i < strength
		MfgConsoleFunc.SetPhoneme(akTarget, id, i)
		i = i + delta
		if (i > 95)
			i = 95
		Endif
		Utility.Wait(0.1)
	endwhile
	
endfunction

function ModifierTideDouble(Actor akTarget, int id1, int id2, int strength, int delta) global

	int i = 0
	while i < strength
		MfgConsoleFunc.SetModifier(akTarget, id1, i)
		MfgConsoleFunc.SetModifier(akTarget, id2, i)
		i = i + delta
		if (i > 95)
			i = 95
		Endif
		Utility.Wait(0.1)
	endwhile
	
endfunction
