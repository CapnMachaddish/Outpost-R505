/datum/quirk/bloodsucker
	name = "Bloodsucker"
	desc = "Whether by some biological function/mutation or twist of fate, you can only drink blood and some raw meats (Notice: There is a 'Bloodsucker' tongue located in the augments tab, which allows you to suck blood from carbons)."
	value = 0
	gain_text = "<span class='notice'>You feel thirsty for red stuff.</span>"
	lose_text = "<span class='notice'>You feel hungry for anything other than blood.</span>"
	medical_record_text = "Patient appears to have digestive system designated for only hemoglobin."

/datum/quirk/bloodsucker/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/species/species = human_holder.dna.species
	species.liked_food &= RAW
	species.disliked_food |= GRAIN | PINEAPPLE | JUNKFOOD | VEGETABLES | SUGAR | BREAKFAST | CLOTH | NUTS | FRUIT | DAIRY | GROSS | TOXIC
	RegisterSignal(human_holder, COMSIG_SPECIES_GAIN, .proc/on_species_gain)

/datum/quirk/bloodsucker/proc/on_species_gain(datum/source, datum/species/new_species, datum/species/old_species)
	new_species.liked_food &= RAW
	new_species.disliked_food |= GRAIN | PINEAPPLE | JUNKFOOD | VEGETABLES | SUGAR | BREAKFAST | CLOTH | NUTS | FRUIT | DAIRY | GROSS | TOXIC

/datum/quirk/bloodsucker/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder

	var/datum/species/species = human_holder.dna.species
	if(initial(species.liked_food) &  GRAIN | PINEAPPLE | JUNKFOOD | VEGETABLES | SUGAR | BREAKFAST | CLOTH | NUTS | FRUIT | DAIRY | GROSS | TOXIC)
		species.liked_food |=  GRAIN | PINEAPPLE | JUNKFOOD | VEGETABLES | SUGAR | BREAKFAST | CLOTH | NUTS | FRUIT | DAIRY | GROSS | TOXIC
	if(!(initial(species.disliked_food) &  GRAIN | PINEAPPLE | JUNKFOOD | VEGETABLES | SUGAR | BREAKFAST | CLOTH | NUTS | FRUIT | DAIRY | GROSS | TOXIC))
		species.disliked_food &= ~ GRAIN | PINEAPPLE | JUNKFOOD | VEGETABLES | SUGAR | BREAKFAST | CLOTH | NUTS | FRUIT | DAIRY | GROSS | TOXIC
	UnregisterSignal(human_holder, COMSIG_SPECIES_GAIN)