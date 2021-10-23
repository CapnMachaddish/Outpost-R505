////////////////////////
///SPANKING PROCEDURE///
////////////////////////

//Hips are red after spanking
/datum/status_effect/spanked
	id = "spanked"
	duration = 300 SECONDS
	alert_type = null

/mob/living/carbon/human/examine(mob/user)
	.=..()
	var/mob/living/U = user

	if(stat != DEAD && !HAS_TRAIT(src, TRAIT_FAKEDEATH) && src != U)
		if(src != user)
			if(has_status_effect(/datum/status_effect/spanked) && is_bottomless())
				. += span_purple("[user.p_their(TRUE)] butt has a red tint to it.") + "\n"

//Mood boost for masochist
/datum/mood_event/perv_spanked
	description = span_purple("Ah, yes! More! Punish me!\n")	//lmao
	mood_change = 3
	timeout = 5 MINUTES

/////////////////////
///SUBSPACE EFFECT///
/////////////////////

/datum/status_effect/subspace
	id = "subspace"
	tick_interval = 10
	duration = 5 MINUTES
	alert_type = null

/datum/status_effect/subspace/on_apply()
	. = ..()
	var/mob/living/carbon/human/target = owner
	SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "subspace", /datum/mood_event/subspace)

/datum/status_effect/subspace/on_remove()
	. = ..()
	var/mob/living/carbon/human/target = owner
	SEND_SIGNAL(target, COMSIG_CLEAR_MOOD_EVENT, "subspace", /datum/mood_event/subspace)

/datum/mood_event/subspace
	description = span_purple("Everything is so woozy... Pain feels so... Awesome.\n")
	mood_change = 4
