/datum/species/teshari
	//Very small, light and agile bird/raptors, but very fragile
	//TODO: sprite custom genitals for this lad, literally everything is cursed besides maybe large af dicks
	name = "Teshari"
	id = "teshari"
	limbs_id = "tesh"
	blurb = "NOTE: Missing/incorrect icons"
	limbs_icon = 'modular_R505/icons/ported/mob/teshari/bodyparts.dmi'
	eyes_icon = 'modular_R505/icons/ported/mob/teshari/eyes.dmi'
	say_mod = "chirps"
	default_color = "#001144"
	blood_color = "#D514F7"
	override_fire = "Generic_mob_"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		FACEHAIR,
		NO_UNDERWEAR,
		NOT_DIGITIGRADE
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	mutantlungs = /obj/item/organ/lungs/teshari
	default_mutant_bodyparts = list(
		"tail" = "Feathery Tail",
		"ears" = "Teshari Ears",
		"feathers" = "Default",
		"s_hair" = "Teshari Generic"
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	unambiguous_gender = FALSE
	handcuff_icon = 'modular_R505/icons/ported/mob/teshari/clothing/handcuffs.dmi'
	legcuff_icon = 'modular_R505/icons/ported/mob/teshari/clothing/handcuffs.dmi'

	offset_features = list(OFFSET_GENITALS_BREASTS = list(0,-4), OFFSET_GENITALS_VAGINA = list(0,-4))

	total_health = 50
	health_hud_intensity = 6
	speedmod = -0.70	//very fast
	snow_movement = 2	//snow makes us half as slow as normal
	blood_volume = 400
	hunger_factor = HUNGER_FACTOR * 0.5
	payday_modifier = 1 //R505 Change - Equal pay
	attack_verb = "claw"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	cough_sounds = list('modular_R505/sound/effects/tesharicough_1.ogg', 'modular_R505/sound/effects/tesharicough_2.ogg')
	sneeze_sounds = list('modular_R505/sound/effects/tesharisneeze.ogg')

	cold_level_1 = 180	//very resistant to cold
	cold_level_2 = 130
	cold_level_3 = 70
	heat_level_1 = 335	//body temp is 310
	heat_level_2 = 370
	heat_level_3 = 600

	cold_discomfort_level = 190
	cold_discomfort_flavor = list(
		"You ruffle your feathers against the cold.",
		"You press your hands against your ears to preserve heat.",
		"You feel a bit chilly.",
		"You move your arms close to your body to shield yourself from the cold."
	)
	heat_discomfort_level = 325
	heat_discomfort_flavor = list(
		"Your feathers prickle in the heat.",
		"You feel uncomfortably warm",
		"Your body feels weak as it tries to regulate the heat."
	)
	var/list/flight_bodyparts = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_ARM,
		BODY_ZONE_R_LEG
	)
	var/list/flight_blockers = list(
		/obj/item/clothing/suit/space,
		/obj/item/clothing/suit/straight_jacket
	)


/datum/species/teshari/handle_z_falling(mob/living/carbon/human/H, turf/T, levels)
	. = FALSE
	if(!istype(H) || !istype(T))
		return
	if(H.stat != CONSCIOUS)
		return

	//Are we buckled to something?
	if(H.buckled)
		to_chat(H, "<span class='warning'>You try to spread your wings to slow your fall, but you're buckled to \a [H.buckled]!")
		return

	//Do we actually have wings?
	if(H.dna.features["feathers"] == "None")
		to_chat(H, "<span class='warning'>You try to spready your wings to slow your fall, but you don't have any feathers!</span>")
		return

	//Is there enough air in the atmosphere?
	var/datum/gas_mixture/environment = T.return_air()
	if(environment.return_pressure() < ONE_ATMOSPHERE * 0.75)
		to_chat(H, "<span class='warning'>You spread your wings to slow your fall, but the air is too thin!</span>")
		return

	//Are we wearing an item that weighs us down?
	if(H.wear_suit)
		for(var/b_type in flight_blockers)
			if(istype(H.wear_suit, b_type))
				to_chat(H, "<span class='warning'>You spread your wings to slow your fall, but [H.wear_suit] weighs you down!</span>")
				return

	//Do we have working wings?
	var/parts_found
	for(var/obj/item/bodypart/bp in H.bodyparts)
		if(!(bp.body_zone in flight_bodyparts))
			continue
		parts_found++
		if(bp.species_id != limbs_id)
			to_chat(H, "<span class='warning'>You spread your wings to slow your fall, but they don't have feathers!</span>")
			return
		if(bp.bodypart_disabled)
			to_chat(H, "<span class='warning'>You try and spread your wings to slow your fall, but you can't use them!</span>")
			return
	if(flight_bodyparts.len > parts_found)
		to_chat(H, "<span class='warning'>You try and spread your wings to slow your fall, but you're missing them!</span>")
		return

	//All is well
	return TRUE

/datum/species/teshari/successful_zfall(mob/living/carbon/human/H, turf/T, levels)
	H.visible_message("<span class='notice'>[H] glides down from above, landing safely.</span>",
		"<span class='notice'>You catch the air in your wings and glide downwards.</span>",
		"<I>You hear something fall.</I>")
	playsound(H, pick('sound/effects/rustle1.ogg', 'sound/effects/rustle2.ogg'), 25, TRUE)
	H.Stun(1)

/obj/item/organ/lungs/teshari
	//TODO: different icon?
	name = "teshari lungs"
	cold_level_1_threshold = 180
	cold_level_2_threshold = 100
	cold_level_3_threshold = 60
	heat_level_1_threshold = 350
	heat_level_2_threshold = 400
	heat_level_3_threshold = 800
	safe_oxygen_min = 12
