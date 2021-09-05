/datum/species/pod
	// A mutation caused by a human being ressurected in a revival pod. These regain health in light, and begin to wither in darkness.
	name = "Primal Podperson"
	id = "pod"
	default_color = "59CE00"
	species_traits = list(MUTCOLORS,EYECOLOR, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_PLANT
	inherent_factions = list("plants", "vines")
	learnable_languages = list(/datum/language/common, /datum/language/sylvan) //I guess plants are smart and they can speak common
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	burnmod = 1.25
	heatmod = 1.5
	payday_modifier = 0.75
	meat = /obj/item/food/meat/slab/human/mutant/plant
	disliked_food = MEAT | DAIRY
	liked_food = VEGETABLES | FRUIT | GRAIN
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/plant
	cultures = list(/datum/cultural_info/culture/lavaland)
	locations = list(/datum/cultural_info/location/stateless)
	factions = list(/datum/cultural_info/faction/none)
	always_customizable = TRUE

/datum/species/pod/spec_life(mob/living/carbon/human/H, delta_time, times_fired)
	if(H.stat == DEAD)
		return

	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1, T.get_lumcount()) - 0.5
		H.adjust_nutrition(5 * light_amount * delta_time)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2) //if there's enough light, heal
			H.heal_overall_damage(0.5 * delta_time, 0.5 * delta_time, 0, BODYPART_ORGANIC)
			H.adjustToxLoss(-0.5 * delta_time)
			H.adjustOxyLoss(-0.5 * delta_time)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(1 * delta_time, 0)

/datum/species/pod/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, delta_time, times_fired)
	if(chem.type == /datum/reagent/toxin/plantbgone)
		H.adjustToxLoss(3 * REAGENTS_EFFECT_MULTIPLIER * delta_time)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * delta_time)
		return TRUE

/datum/species/pod/podweak
	name = "Podperson"
	id = "podweak"
	limbs_id = "pod"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list()

	cultures = list(CULTURES_EXOTIC, CULTURES_HUMAN)
	locations = list(LOCATIONS_GENERIC, LOCATIONS_HUMAN)
	factions = list(FACTIONS_GENERIC, FACTIONS_HUMAN)
	learnable_languages = list(/datum/language/common, /datum/language/sylvan)
