Scriptname ED_UndyingLoyaltyQuest_Script extends Quest  

; in case reference gets yeeted we create another actor
; will deal with inventory later
actorbase property UndyingServant1_ActorBase auto


function HireServant(actor servantActor)
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest stores actor: " + servantActor)
	ED_UndyingServant1.ForceRefTo(servantActor)
	UndyingServant1_ActorBase = servantActor.GetActorBase()
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest stored alias reference: " + ED_UndyingServant1.GetReference())
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest stored actor base: " + UndyingServant1_ActorBase)
endfunction

function BanishServant(referencealias servantReference)
	
endfunction

function CloneServant(actorbase UndyingServant1_ActorBase)
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest lost the servant, cloning...")
	
	; should handle with care cause persistent
	; dont cast as actor intially, check if lalalala
	;actor clonedServant = playerRef.placeatme(UndyingServant1_ActorBase, 1, true, true) as actor
	
endfunction

function ConsistencyCheck()
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest consistncy check called")
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest UndyingServant1_ActorBase: " + ED_UndyingServant1.GetReference())
	debug.Trace("Everdamned DEBUG: Undying Loyalty Quest UndyingServant1_ActorBase: " + UndyingServant1_ActorBase)
	
endfunction

referencealias property ED_UndyingServant1 auto
actor property playerRef auto
