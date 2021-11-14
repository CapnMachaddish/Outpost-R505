/datum/component/arousal/proc/get_arousal_level()
	return !can_be_aroused ? AROUSAL_NONE : arousalloss >= erect_threshold ? AROUSAL_FULL : arousalloss >= chub_threshold ? AROUSAL_PARTIAL : AROUSAL_NONE

//Returns 0 to 10
/datum/component/arousal/proc/get_arousal_percentage()
	return can_be_aroused ? round((arousalloss / maximum_arousal) * 10)*10 : 0

/datum/component/arousal/proc/getGenitalCount()
	return can_be_aroused ? genitals.len : 0

/datum/component/arousal/proc/getExposedGenitalCount()
	return exposed_genitals

/datum/component/arousal/proc/can_use_activity()
	return world.time > mb_cooldown + cooldown_for_mb

/proc/find_random_genital_accessory(key)	//I never want to work with genitals and their sprite accessories ever again
	switch(key)
		if("breasts")
			return /datum/sprite_accessory/genital/breasts/pair
		if("penis")
			return pick(/datum/sprite_accessory/genital/penis/human,
						/datum/sprite_accessory/genital/penis/knotted,
						/datum/sprite_accessory/genital/penis/flared,
						/datum/sprite_accessory/genital/penis/thick)
		if("testicles")
			return /datum/sprite_accessory/genital/testicles/pair

/proc/is_chest_exposed(mob/M)
	if(!ismob(M))
		return FALSE
	if(!ishuman(M))
		return TRUE
	var/mob/living/carbon/human/H = M
	if(H.wear_suit)
		if(istype(H.wear_suit, /obj/item/clothing/under/misc/gear_harness))
			return TRUE
		return FALSE
	if(H.w_uniform)
		return FALSE
	return TRUE

/proc/is_groin_exposed(mob/M)
	if(!ismob(M))
		return FALSE
	if(!ishuman(M))
		return TRUE
	var/mob/living/carbon/human/H = M
	//TODO: Check for skirts and bottomless clothing
	if(H.belt)
		return FALSE
	return is_chest_exposed(M)

/mob/living/carbon/human/proc/get_genital_sprite_accessory(key)
	if(!dna.species.mutant_bodyparts[key])
		return
	return GLOB.sprite_accessories[key][dna.species.mutant_bodyparts[key][MUTANT_INDEX_NAME]]

/mob/living/carbon/human/proc/get_genital_visibility(key)
	var/datum/sprite_accessory/genital/G = get_genital_sprite_accessory(key)
	if(!G)
		return
	return !G.is_hidden(src)

/mob/living/carbon/human/proc/get_penis_sprite()
	return get_genital_sprite_accessory("penis")

/mob/living/carbon/human/proc/get_penis_visibility()
	return get_genital_visibility("penis")

/mob/living/carbon/human/proc/get_breasts_sprite()
	return get_genital_sprite_accessory("breasts")

/mob/living/carbon/human/proc/get_breast_visibility()
	return get_genital_visibility("breasts")

/mob/living/carbon/human/proc/get_testicles_sprite()
	return get_genital_sprite_accessory("testicles")

/mob/living/carbon/human/proc/get_testicle_visibility()
	return get_genital_visibility("testicles")

/mob/living/carbon/human/proc/get_vagina_sprite()
	return get_genital_sprite_accessory("vagina")

/mob/living/carbon/human/proc/get_vagina_visibility()
	return get_genital_visibility("vagina")

/obj/item/organ/genital/breasts/proc/should_lactate()
	if(!owner)
		return FALSE
	if(!lactates)
		return FALSE
	AROUSAL_VAR(A, owner)
	if(A)
		if(A.get_arousal_level() >= AROUSAL_PARTIAL)
			return TRUE
		return FALSE
	return TRUE

/obj/item/organ/genital/proc/return_fluid(remove_fluid=FALSE, multiplier=1)
	var/amount_to_take = min(round(fluid_amount * productivity) * multiplier, max_fluid_amount)
	var/datum/reagents/R = new(10000)
	for(var/X in fluid_type)
		R.add_reagent(X, amount_to_take * fluid_type[X], reagtemp=DEFAULT_REAGENT_TEMPERATURE+15)
	if(remove_fluid)
		fluid_amount -= amount_to_take
	return R

/obj/item/organ/genital/proc/return_arousal()
	if(forced_arousal != AROUSAL_CANT)
		return forced_arousal
	return aroused

/obj/item/organ/genital/proc/return_proper_name()
	return "bad code"

/obj/item/organ/genital/penis/return_proper_name()
	return "[genital_type] penis"

/obj/item/organ/genital/testicles/return_proper_name()
	return "testicles"

/obj/item/organ/genital/breasts/return_proper_name()
	return "[genital_type == "pair" ? "pair of" : genital_type] breasts"

/obj/item/organ/genital/vagina/return_proper_name()
	return genital_type == "cloaca" ? "cloaca" : "[genital_name] vagina"

/obj/item/organ/genital/womb/return_proper_name()
	return "womb"

/datum/component/arousal/proc/has_pseudo_genital(key)
	switch(key)
		if(ORGAN_SLOT_PENIS)
			return pseudo_penis
		if(ORGAN_SLOT_TESTICLES)
			return pseudo_testicles
		if(ORGAN_SLOT_BREASTS)
			return pseudo_breasts
		if(ORGAN_SLOT_VAGINA)
			return pseudo_vagina
		if(ORGAN_SLOT_WOMB)
			return pseudo_womb
	return FALSE

/datum/component/arousal/proc/get_owner_organ(slot)
	if(is_carbon)
		var/mob/living/carbon/C = holder
		return C.getorganslot(slot)
	return has_pseudo_genital(slot)

/datum/component/arousal/proc/get_organ_visibility(key)
	if(is_human)
		var/mob/living/carbon/human/H = holder
		return H.get_genital_visibility(key)
	return has_pseudo_genital(key)

/datum/component/arousal/proc/get_all_genitals()
	. = list()
	. += get_owner_organ(ORGAN_SLOT_PENIS)
	. += get_owner_organ(ORGAN_SLOT_TESTICLES)
	. += get_owner_organ(ORGAN_SLOT_BREASTS)
	. += get_owner_organ(ORGAN_SLOT_VAGINA)
	. += get_owner_organ(ORGAN_SLOT_WOMB)
