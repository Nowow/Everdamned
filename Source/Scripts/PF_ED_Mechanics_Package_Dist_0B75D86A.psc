;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PF_ED_Mechanics_Package_Dist_0B75D86A Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
;akActor.Say(SayTopic)
;akActor.PlayIdle(ResetRoot)
;akActor.PlayIdle(IdleSnapToAttention)

if !(akActor.IsInCombat())
	akActor.PushActorAway(AkActor, 0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
;akActor.Say(SayTopic)
;akActor.PlayIdle(ResetRoot)
;akActor.PlayIdle(IdleSnapToAttention)

if !(akActor.IsInCombat())
	akActor.PushActorAway(AkActor, 0)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Topic Property SayTopic  Auto  

Idle Property ResetRoot  Auto  

Idle Property IdleSnapToAttention  Auto  
