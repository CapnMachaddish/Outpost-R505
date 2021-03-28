/mob/living/simple_animal/pet/bumbles
	name = "Bumbles"
	desc = "Bumbles, the very humble bumblebee."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "bumbles"
	icon_living = "bumbles"
	icon_dead = "bumbles_dead"
	turns_per_move = 1
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "brushes aside"
	response_help_simple = "brush aside"
	response_harm_continuous = "squashes"
	response_harm_simple = "squash"
	speak_emote = list("buzzes")
	friendly_verb_continuous = "bzzs"
	friendly_verb_simple = "bzz"
	density = FALSE
	is_flying_animal = TRUE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	verb_say = "buzzs"
	verb_ask = "buzzes inquisitively"
	verb_exclaim = "buzzes intensely"
	verb_yell = "buzzes intensely"
	emote_see = list("buzzes.", "makes a loud buzz.", "rolls several times.", "buzzes happily.")
	speak_chance = 1
	unique_name = TRUE

/mob/living/simple_animal/pet/bumbles/Initialize()
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)


/mob/living/simple_animal/pet/bumbles/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if (resting)
		icon_state = "[icon_living]_rest"
	else
		icon_state = "[icon_living]"
	regenerate_icons()

/mob/living/simple_animal/pet/bumbles/bee_friendly()
	return TRUE //treaty signed at the Beeneeva convention

/mob/living/simple_animal/pet/bumbles/handle_automated_movement()
	. = ..()

/mob/living/simple_animal/pet/bumbles/Life(delta_time = SSMOBS_DT, times_fired)
	if(!stat && !buckled && !client)
		if(DT_PROB(0.5, delta_time))
			manual_emote(pick("curls up on the surface below.", "is looking very sleepy.", "buzzes happily.", "looks around for a flower nap."))
			REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)
			set_resting(TRUE)
		else if(DT_PROB(0.5, delta_time))
			if (resting)
				manual_emote(pick("wakes up with a smiling buzz.", "rolls upside down before waking up.", "stops resting."))
				ADD_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)
				set_resting(FALSE)
			else
				manual_emote(pick("buzzes softly."))
	..()
