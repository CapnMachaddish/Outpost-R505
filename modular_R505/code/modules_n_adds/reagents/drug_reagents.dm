/datum/reagent/drug/dopamine
	name = "dopamine"
	description = "Pure happiness"
	taste_description = "passion fruit, banana and hint of apple"
	color = "#97ffee"
	glass_name = "dopamine"
	glass_desc = "A deliciously flavored reagent. You feel happy even looking at it."
	reagent_state = LIQUID
	overdose_threshold = 8

/datum/reagent/drug/dopamine/on_mob_add(mob/living/carbon/human/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_start", /datum/mood_event/dopamine, name)
	..()

/datum/reagent/drug/dopamine/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(2)
	if(prob(7))
		M.emote(pick("shiver","moan"))
	..()

/datum/reagent/drug/dopamine/overdose_start(mob/living/M)
	..()
	M.apply_status_effect(/datum/status_effect/convulsing)

/datum/reagent/drug/dopamine/overdose_process(mob/living/M, delta_time, times_fired)
	M.jitteriness += 2
