#define AROUS_SYS_LITTLE 30
#define AROUS_SYS_STRONG 70
#define AROUS_SYS_READYTOCUM 90
#define PAIN_SYS_LIMIT 50
#define PLEAS_SYS_EDGE 85

#define CUM_MALE 1
#define CUM_FEMALE 2
// #define ITEM_SLOT_PENIS (1<<20)

#define TRAIT_NYMPHOMANIA	"nymphomania"
#define TRAIT_MASOCHISM		"masochism"
#define TRAIT_SADISM		"sadism"
#define TRAIT_BIMBO 		"bimbo"
#define TRAIT_NEVERBONER	"neverboner"
#define TRAIT_SOBSESSED		"sexual obsession"
#define APHRO_TRAIT			"aphro"				///traits gained by brain traumas, can be removed if the brain trauma is gone
#define LEWDQUIRK_TRAIT		"lewdquirks"		///traits gained by quirks, cannot be removed unless the quirk itself is gone
#define LEWDCHEM_TRAIT		"lewdchem"			///traits gained by chemicals, you get the idea

#define STRAPON_TRAIT 		"strapon"

///////////-----Decals-----//////////
/obj/effect/decal/cleanable/cum
	name = "cum"
	desc = "Ew... Gross."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
	icon_state = "cum_1"
	random_icon_states = list("cum_1", "cum_2", "cum_3", "cum_4")
	beauty = -50

/obj/effect/decal/cleanable/femcum
	name = "female cum"
	desc = "Uhh... Someone had fun..."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
	icon_state = "femcum_1"
	random_icon_states = list("femcum_1", "femcum_2", "femcum_3", "femcum_4")
	beauty = -50

///////////-----Reagents-----///////////
/datum/reagent/consumable/girlcum
	name = "girlcum"
	description = "Uhh... Someone had fun."
	taste_description = "astringent and sweetish"
	color = "#ffffffb0"
	glass_name = "glass of girlcum"
	glass_desc = "A strange white liquid... Ew!"
	reagent_state = LIQUID
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/consumable/cum
	name = "cum"
	description = "A fluid secreted by the sexual organs of many species."
	taste_description = "musky and salty"
	color = "#ffffffff"
	glass_name = "glass of cum"
	glass_desc = "O-oh, my...~"
	reagent_state = LIQUID
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/consumable/milk/breast_milk
	name = "breast milk"
	description = "This looks familiar... Wait, it's milk!"
	taste_description = "warm and creamy"
	color = "#ffffffff"
	glass_name = "glass of breast milk"
	glass_desc = "almost like normal milk."
	reagent_state = LIQUID

/datum/reagent/drug/dopamine
	name = "dopamine"
	description = "Pure happiness"
	taste_description = "passion fruit, banana and hint of apple"
	color = "#97ffee"
	glass_name = "dopamine"
	glass_desc = "A deliciously flavored reagent. You feel happy even looking at it."
	reagent_state = LIQUID
	overdose_threshold = 10

/datum/reagent/drug/dopamine/on_mob_add(mob/living/carbon/human/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_start", /datum/mood_event/orgasm, name)
	..()

/datum/reagent/drug/dopamine/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(2)
	if(prob(7))
		M.emote(pick("shaking","moan"))
	..()

/datum/reagent/drug/dopamine/overdose_start(mob/living/carbon/human/M)
	if(!HAS_TRAIT(M, TRAIT_NYMPHOMANIA) || !HAS_TRAIT(M, TRAIT_BIMBO))
		to_chat(M, span_userdanger("You don't want to cum anymore!"))
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overgasm, name)
	return

/datum/reagent/drug/dopamine/overdose_process(mob/living/carbon/human/M)
	M.adjustArousal(0.5)
	M.adjustPleasure(0.3)
	M.adjustPain(-0.5)
	if(prob(2))
		M.emote(pick("moan","twitch_s"))
	return

///////////-----Initilaze------///////////

/obj/item/organ/genital
	var/datum/reagents/internal_fluids
	var/list/contained_item
	var/obj/item/inserted_item //Used for toys

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/breasts_count = 0
	var/size = 0.5
	if(DNA.features["breasts_size"] > 0)
		size = DNA.features["breasts_size"]

	switch(genital_type)
		if("pair")
			breasts_count = 2
		if("quad")
			breasts_count = 2.5
		if("sextuple")
			breasts_count = 3
	internal_fluids = new /datum/reagents(size * breasts_count * 60)

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/size = 0.5
	if(DNA.features["balls_size"] > 0)
		size = DNA.features["balls_size"]

	internal_fluids = new /datum/reagents(size * 20)

/obj/item/organ/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	internal_fluids = new /datum/reagents(10)

/mob/living/carbon/human
	var/arousal = 0
	var/pleasure = 0
	var/pain = 0

	var/pain_limit = 0
	var/arousal_status = AROUSAL_NONE

/mob/living/carbon/human/Initialize()
	. = ..()
	if(!istype(src,/mob/living/carbon/human/species/monkey))
		apply_status_effect(/datum/status_effect/aroused)
		apply_status_effect(/datum/status_effect/body_fluid_regen)

///////////-----Verbs------///////////
/mob/living/carbon/human/verb/arousal_panel()
	set name = "Climax"
	set category = "IC"

	if(!has_status_effect(/datum/status_effect/climax_cooldown))
		if(tgui_alert(usr, "Are you sure you want to cum?", "Climax", list("Yes", "No")) == "Yes")
			if(stat != CONSCIOUS)
				to_chat(usr, span_warning("You can't climax right now..."))
				return
			else
				climax(TRUE)
	else
		to_chat(src, span_warning("You can't cum right now!"))

////////////
///FLUIDS///
////////////

/datum/status_effect/body_fluid_regen
	id = "body fluid regen"
	tick_interval = 50
	duration = -1
	alert_type = null

/datum/status_effect/body_fluid_regen/tick()
	var/mob/living/carbon/human/H = owner
	if(owner.stat != DEAD && H.client?.prefs.sextoys_pref == "Yes")
		var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
		var/obj/item/organ/genital/breasts/breasts = owner.getorganslot(ORGAN_SLOT_BREASTS)
		var/obj/item/organ/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)

		var/interval = 5
		if(balls)
			if(H.arousal >= AROUS_SYS_LITTLE)
				var/regen = (H.arousal/25) * (balls.internal_fluids.maximum_volume/235) * interval
				balls.internal_fluids.add_reagent(/datum/reagent/consumable/cum, regen)

		if(breasts)
			if(breasts.lactates == TRUE)
				var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED/100))/100) * (breasts.internal_fluids.maximum_volume/11000) * interval
				breasts.internal_fluids.add_reagent(/datum/reagent/consumable/milk/breast_milk, regen)
				if(!breasts.internal_fluids.holder_full())
					owner.adjust_nutrition(regen / 2)
				else
					regen = regen

		if(vagina)
			if(H.arousal >= AROUS_SYS_LITTLE)
				var/regen = (H.arousal/25) * (vagina.internal_fluids.maximum_volume/250) * interval
				vagina.internal_fluids.add_reagent(/datum/reagent/consumable/girlcum, regen)
				if(vagina.internal_fluids.holder_full() && regen >= 0.15)
					regen = regen
			else
				vagina.internal_fluids.remove_any(0.05)

/////////////
///AROUSAL///
/////////////
/mob/living/carbon/human/proc/get_arousal()
	return arousal

/mob/living/carbon/human/proc/adjustArousal(arous = 0)
	if(stat != DEAD && client?.prefs.sextoys_pref == "Yes")
		arousal += arous

		var/arousal_flag = AROUSAL_NONE
		if(arousal >= AROUS_SYS_STRONG)
			arousal_flag = AROUSAL_FULL
		else if(arousal >= AROUS_SYS_LITTLE)
			arousal_flag = AROUSAL_PARTIAL

		if(arousal_status != arousal_flag) // Set organ arousal status
			arousal_status = arousal_flag
			if(istype(src,/mob/living/carbon/human))
				var/mob/living/carbon/human/M = src
				for(var/i=1,i<=M.internal_organs.len,i++)
					if(istype(M.internal_organs[i],/obj/item/organ/genital))
						var/obj/item/organ/genital/G = M.internal_organs[i]
						if(!G.aroused == AROUSAL_CANT)
							G.aroused = arousal_status
							G.update_sprite_suffix()
				M.update_body()
	else
		arousal -= abs(arous)

	if(HAS_TRAIT(src, TRAIT_NYMPHOMANIA))
		arousal = min(max(arousal,20),100)
	else
		arousal = min(max(arousal,0),100)

/datum/status_effect/aroused
	id = "aroused"
	tick_interval = 10
	duration = -1
	alert_type = null

/datum/status_effect/aroused/tick()
	var/mob/living/carbon/human/H = owner
	var/temp_arousal = -0.1
	var/temp_pleasure = -0.5
	var/temp_pain = -0.5
	if(H.stat != DEAD)

		var/obj/item/organ/genital/testicles/balls = H.getorganslot(ORGAN_SLOT_TESTICLES)
		if(balls)
			if(balls.internal_fluids.holder_full())
				temp_arousal += 0.08

		if(HAS_TRAIT(H, TRAIT_MASOCHISM))
			temp_pain -= 0.5
		if(HAS_TRAIT(H, TRAIT_NYMPHOMANIA))
			temp_pleasure += 0.25
			temp_arousal += 0.05
		if(HAS_TRAIT(H, TRAIT_NEVERBONER))
			temp_pleasure -= 50
			temp_arousal -= 50

		if(H.pain > H.pain_limit)
			temp_arousal -= 0.1
		if(H.arousal >= AROUS_SYS_STRONG && H.stat != DEAD)
			if(prob(3))
				H.emote(pick("moan","blush"))
			temp_pleasure += 0.1
			//moan
		if(H.pleasure >= PLEAS_SYS_EDGE && H.stat != DEAD)
			if(prob(3))
				H.emote(pick("moan","twitch_s"))
			//moan x2

	H.adjustArousal(temp_arousal)
	H.adjustPleasure(temp_pleasure)
	H.adjustPain(temp_pain)

////Pain////
/mob/living/carbon/human/proc/get_pain()
	return pain

/mob/living/carbon/human/proc/adjustPain(pn = 0)
	if(stat != DEAD && client?.prefs.sextoys_pref == "Yes")
		if(pain > pain_limit || pn > pain_limit / 10) // pain system // YOUR SYSTEM IS PAIN, WHY WE'RE GETTING AROUSED BY STEPPING ON ANTS?!
			if(HAS_TRAIT(src, TRAIT_MASOCHISM))
				var/p = pn - (pain_limit / 10)
				if(p > 0)
					adjustArousal(-p)
			else
				if(pn > 0)
					adjustArousal(-pn)
			if(prob(2) && pain > pain_limit && pn > pain_limit / 10)
				emote(pick("scream","shiver")) //SCREAM!!!
		else
			if(pn > 0)
				adjustArousal(pn)
			if(HAS_TRAIT(src, TRAIT_MASOCHISM))
				var/p = pn / 2
				adjustPleasure(p)
		pain += pn
	else
		pain -= abs(pn)
	pain = min(max(pain,0),100)

////Pleasure////
/mob/living/carbon/human/proc/get_pleasure()
	return pleasure

/mob/living/carbon/human/proc/adjustPleasure(pleas = 0)
	if(stat != DEAD && client?.prefs.sextoys_pref == "Yes")
		pleasure += pleas
		if(pleasure >= 100) // lets cum
			climax(FALSE)
	else
		pleasure -= abs(pleas)
	pleasure = min(max(pleasure,0),100)

// get damage for pain system
/datum/species/apply_damage(damage, damagetype, def_zone, blocked, mob/living/carbon/human/H, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness)
	. = ..()
	if(!.)
		return
	if(H.client?.prefs.sextoys_pref == "No")
		return
	var/hit_percent = (100-(blocked+armor))/100
	hit_percent = (hit_percent * (100-H.physiology.damage_resistance))/100
	switch(damagetype)
		if(BRUTE)
			var/amount = forced ? damage : damage * hit_percent * brutemod * H.physiology.brute_mod
			INVOKE_ASYNC(H, /mob/living/carbon/human/.proc/adjustPain, amount)
		if(BURN)
			var/amount = forced ? damage : damage * hit_percent * burnmod * H.physiology.burn_mod
			INVOKE_ASYNC(H, /mob/living/carbon/human/.proc/adjustPain, amount)

////////////
///CLIMAX///
////////////

/datum/mood_event/orgasm
	description = span_purple("Woah... This pleasant tiredness... I love it.\n")
	mood_change = 8 //yes, +8. Well fed buff gives same amount. This is Fair (tm).
	timeout = 5 MINUTES

/datum/mood_event/climaxself
	description = span_purple("I just came in my own underwear. Messy.\n")
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/overgasm
	description = span_warning("Uhh... I don't want to be horny anymore.\n") //Me too, buddy. Me too.
	mood_change = -6
	timeout = 10 MINUTES

/mob/living/carbon/human/proc/climax(manual = TRUE)
	var/obj/item/organ/genital/penis = getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/vagina = getorganslot(ORGAN_SLOT_VAGINA)
	if(manual == TRUE && !has_status_effect(/datum/status_effect/climax_cooldown) && client?.prefs.sextoys_pref == "Yes")
		if(!HAS_TRAIT(src, TRAIT_NEVERBONER) && !has_status_effect(/datum/status_effect/climax_cooldown))
			switch(gender)
				if(MALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)
				if(FEMALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE)
				else
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)

			if(vagina && penis)
				if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] is cumming!"), span_purple("You are cumming!"))
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] cums in their underwear!"), \
								span_purple("You cum in your underwear! Eww."))
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)

			else if(vagina)
				if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] is cumming!"), span_purple("You are cumming!"))
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] cums in their underwear!"), \
								span_purple("You cum in your underwear! Eww."))
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)

			else if(penis)
				if(is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] is cumming!"), span_purple("You are cumming!"))
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] cums in their underwear!"), \
								span_purple("You cum in your underwear! Eww."))
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)

			else
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				visible_message(span_purple("[src] twitches in orgasm!"), \
								span_purple("You cum in your underwear! Eww."))

		else
			visible_message(span_purple("[src] twitches, trying to cum, but with no result."), \
							span_purple("You can't have an orgasm!"))
		return TRUE

	else if(manual == FALSE && client?.prefs.sextoys_pref == "Yes")
		if(!HAS_TRAIT(src, TRAIT_NEVERBONER) && !has_status_effect(/datum/status_effect/climax_cooldown))
			switch(gender)
				if(MALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)
				if(FEMALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE)
				else
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)
			if(is_bottomless())
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				visible_message(span_purple("[src] is cumming!"), span_purple("You are cumming!"))
			else
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				visible_message(span_purple("[src] cums in their underwear!"), \
								span_purple("You cum in your underwear! Eww."))
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)
		else
			visible_message(span_purple("[src] twitches, trying to cum, but with no result."), \
							span_purple("You can't have an orgasm!"))
		return TRUE

	else
		return FALSE

/datum/status_effect/climax_cooldown
	id = "climax_cooldown"
	tick_interval = 10
	duration = 30 SECONDS
	alert_type = null

/datum/status_effect/climax_cooldown/tick()
	var/obj/item/organ/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/penis = owner.getorganslot(ORGAN_SLOT_PENIS)

	if(penis)
		penis.aroused = AROUSAL_NONE
	if(vagina)
		vagina.aroused = AROUSAL_NONE
	if(balls)
		balls.aroused = AROUSAL_NONE

/datum/status_effect/masturbation_climax
	id = "climax"
	tick_interval =  10
	duration = 50 //Multiplayer better than singleplayer mode.
	alert_type = null

/datum/status_effect/masturbation_climax/tick() //this one should not leave decals on the floor. Used in case if character cumming on somebody's face or in beaker.
	var/mob/living/carbon/human/H = owner
	if(H.client?.prefs.sextoys_pref == "Yes")
		var/temp_arousal = -12
		var/temp_pleasure = -12
		var/temp_stamina = 8

		owner.reagents.add_reagent(/datum/reagent/drug/dopamine, 0.3)
		owner.adjustStaminaLoss(temp_stamina)
		H.adjustArousal(temp_arousal)
		H.adjustPleasure(temp_pleasure)

/datum/status_effect/climax
	id = "climax"
	tick_interval =  10
	duration = 100
	alert_type = null

/datum/status_effect/climax/tick()
	var/mob/living/carbon/human/H = owner
	if(H.client?.prefs.sextoys_pref == "Yes")
		var/temp_arousal = -12
		var/temp_pleasure = -12
		var/temp_stamina = 15

		owner.reagents.add_reagent(/datum/reagent/drug/dopamine, 0.5)
		owner.adjustStaminaLoss(temp_stamina)
		H.adjustArousal(temp_arousal)
		H.adjustPleasure(temp_pleasure)

/datum/status_effect/climax/on_apply(obj/target)
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/penis = owner.getorganslot(ORGAN_SLOT_PENIS)

	if((H.client?.prefs.sextoys_pref == "Yes") && (H.stat != DEAD))
		if(penis && balls && H.wear_condom())
			if(prob(40))
				H.emote("moan")
			balls.reagents.remove_all(balls.reagents.total_volume * 0.6)
			var/obj/item/clothing/sextoy/condom/C = H.get_item_by_slot(ITEM_SLOT_PENIS)
			C.condom_use()
			if(C.condom_state == "broken")
				var/turf/T = get_turf(H)
				new /obj/effect/decal/cleanable/cum(T)

		if(balls && H.is_bottomless() && !H.wear_condom())
			var/turf/T = get_turf(H)
			new /obj/effect/decal/cleanable/cum(T)
			if(prob(40))
				H.emote("moan")
			balls.reagents.remove_all(balls.reagents.total_volume * 0.6)

		if(vagina && H.is_bottomless()) //Sry, futanari players, but condom's don't work like that for vagina, so yep.
			var/turf/T = get_turf(H)
			new /obj/effect/decal/cleanable/femcum(T)
			if(prob(40))
				H.emote("moan")
			vagina.reagents.remove_all()

	return ..()

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
	description = span_purple("Ah, yes! More! Punish me!\n")
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

///////////////////////
///AROUSAL INDICATOR///
///////////////////////

/obj/item/organ/brain/on_life(delta_time, times_fired) //All your horny is here *points to the head*
	. = ..()
	var/mob/living/carbon/human/brain_owner = owner
	if(istype(brain_owner, /mob/living/carbon/human) && brain_owner.client?.prefs.sextoys_pref == "Yes")
		if(!(organ_flags & ORGAN_FAILING))
			brain_owner.dna.species.handle_arousal(brain_owner, delta_time, times_fired)

//screen alert

/atom/movable/screen/alert/aroused_X
	name = "Aroused"
	desc = "It's a little hot in here"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	icon_state = "arousal_small"
	var/mutable_appearance/pain_overlay
	var/mutable_appearance/pleasure_overlay
	var/pain_level = "small"
	var/pleasure_level = "small"

/atom/movable/screen/alert/aroused_X/Initialize()
	.=..()
	pain_overlay = update_pain()
	pleasure_overlay = update_pleasure()

/atom/movable/screen/alert/aroused_X/proc/update_pain()
	if(pain_level)
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pain_[pain_level]")

/atom/movable/screen/alert/aroused_X/proc/update_pleasure()
	if(pleasure_level)
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pleasure_[pleasure_level]")

/datum/species/proc/throw_arousalalert(level, atom/movable/screen/alert/aroused_X/arousal_alert, mob/living/carbon/human/targeted_human)
	targeted_human.throw_alert("aroused", /atom/movable/screen/alert/aroused_X)
	arousal_alert?.icon_state = level
	arousal_alert?.update_icon()

/datum/species/proc/overlay_pain(level, atom/movable/screen/alert/aroused_X/arousal_alert)
	arousal_alert?.cut_overlay(arousal_alert.pain_overlay)
	arousal_alert?.pain_level = level
	arousal_alert?.pain_overlay = arousal_alert.update_pain()
	arousal_alert?.add_overlay(arousal_alert.pain_overlay)
	arousal_alert?.update_overlays()

/datum/species/proc/overlay_pleasure(level, atom/movable/screen/alert/aroused_X/arousal_alert)
	arousal_alert?.cut_overlay(arousal_alert.pleasure_overlay)
	arousal_alert?.pleasure_level = level
	arousal_alert?.pleasure_overlay = arousal_alert.update_pleasure()
	arousal_alert?.add_overlay(arousal_alert.pleasure_overlay)
	arousal_alert?.update_overlays()

/datum/species/proc/handle_arousal(mob/living/carbon/human/target_human, atom/movable/screen/alert/aroused_X)
	var/atom/movable/screen/alert/aroused_X/arousal_alert = target_human.alerts["aroused"]
	if(target_human.client?.prefs.sextoys_pref == "Yes")
		switch(target_human.arousal)
			if(-100 to 1)
				target_human.clear_alert("aroused", /atom/movable/screen/alert/aroused_X)
			if(1 to 25)
				throw_arousalalert("arousal_small", arousal_alert, target_human)
			if(25 to 50)
				throw_arousalalert("arousal_medium", arousal_alert, target_human)
			if(50 to 75)
				throw_arousalalert("arousal_high", arousal_alert, target_human)
			if(75 to INFINITY) //to prevent that 101 arousal that can make icon disappear or something.
				throw_arousalalert("arousal_max", arousal_alert, target_human)

		if(target_human.arousal > 1)
			switch(target_human.pain)
				if(-100 to 1) //to prevent same thing with pain
					arousal_alert?.cut_overlay(arousal_alert.pain_overlay)
				if(1 to 25)
					overlay_pain("small", arousal_alert)
				if(25 to 50)
					overlay_pain("medium", arousal_alert)
				if(50 to 75)
					overlay_pain("high", arousal_alert)
				if(75 to INFINITY)
					overlay_pain("max", arousal_alert)

		if(target_human.arousal > 1)
			switch(target_human.pleasure)
				if(-100 to 1) //to prevent same thing with pleasure
					arousal_alert?.cut_overlay(arousal_alert.pleasure_overlay)
				if(1 to 25)
					overlay_pleasure("small", arousal_alert)
				if(25 to 60)
					overlay_pleasure("medium", arousal_alert)
				if(60 to 85)
					overlay_pleasure("high", arousal_alert)
				if(85 to INFINITY)
					overlay_pleasure("max", arousal_alert)
		else
			if(arousal_alert?.pleasure_level in list("small", "medium", "high", "max"))
				arousal_alert.cut_overlay(arousal_alert.pleasure_overlay)
			if(arousal_alert?.pain_level in list("small", "medium", "high", "max"))
				arousal_alert.cut_overlay(arousal_alert.pain_overlay)

////////////////////////
///CUM.DM ASSIMILATED///
////////////////////////

//you got cum on your face bro *licks it off*
/datum/component/cumfaced
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/cumface

/datum/component/cumfaced/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	cumface = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == SPECIES_LIZARD)
			cumface.icon_state = "cumface_lizard"
		else if(H.dna.species.limbs_id == SPECIES_MONKEY)
			cumface.icon_state = "cumface_monkey"
		else if(H.dna.species.id == SPECIES_VOX)
			cumface.icon_state = "cumface_vox"
		else if(H.dna.species.mutant_bodyparts["snout"])
			cumface.icon_state = "cumface_lizard"
		else
			cumface.icon_state = "cumface_human"
	else if(isAI(parent))
		cumface.icon_state = "cumface_ai"

	var/atom/A = parent
	A.add_overlay(cumface)

/datum/component/cumfaced/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(cumface)
	qdel(cumface)
	return ..()

/datum/component/cumfaced/RegisterWithParent()
	RegisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT),
		.proc/clean_up)

/datum/component/cumfaced/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT))

///Callback to remove pieface
/datum/component/cumfaced/proc/clean_up(datum/source, clean_types)
	SIGNAL_HANDLER

	. = NONE
	if(!(clean_types & CLEAN_TYPE_BLOOD))
		qdel(src)
		return COMPONENT_CLEANED

/datum/component/cumfaced/big
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/bigcumface

/datum/component/cumfaced/big/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	bigcumface = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == "lizard")
			bigcumface.icon_state = "bigcumface_lizard"
		else if(H.dna.species.limbs_id == "monkey")
			bigcumface.icon_state = "bigcumface_monkey"
		else if(H.dna.species.id == "vox")
			bigcumface.icon_state = "bigcumface_vox"
		else if(H.dna.species.mutant_bodyparts["snout"])
			bigcumface.icon_state = "bigcumface_lizard"
		else
			bigcumface.icon_state = "bigcumface_human"
	else if(isAI(parent))
		bigcumface.icon_state = "cumface_ai"

	var/atom/A = parent
	A.add_overlay(bigcumface)

/datum/component/cumfaced/big/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(bigcumface)
	qdel(bigcumface)
	return ..()

/datum/emote/living/cum
	key = "cum"
	key_third_person = "cums"
	cooldown = 30 SECONDS

/datum/emote/living/cum/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return


	var/obj/item/coomer = new /obj/item/coom(user)
	var/mob/living/carbon/human/H = user
	var/obj/item/held = user.get_active_held_item()
	var/obj/item/unheld = user.get_inactive_held_item()
	if(user.put_in_hands(coomer) && H.dna.species.mutant_bodyparts["testicles"] && H.dna.species.mutant_bodyparts["penis"])
		if(held || unheld)
			if(!((held.name=="cum" && held.item_flags == DROPDEL | ABSTRACT | HAND_ITEM) || (unheld.name=="cum" && unheld.item_flags == DROPDEL | ABSTRACT | HAND_ITEM)))
				to_chat(user, span_notice("You mentally prepare yourself to masturbate."))
			else
				qdel(coomer)
		else
			to_chat(user, span_notice("You mentally prepare yourself to masturbate."))
	else
		qdel(coomer)
		to_chat(user, span_warning("You're incapable of masturbating."))

/obj/item/coom
	name = "cum"
	desc = "C-can I watch...?"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "eggplant"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/coom/attack(mob/living/M, mob/user, proximity)
	if(!proximity)
		return
	if(!ishuman(M))
		return
	if(user.stat == DEAD)
		return
	var/mob/living/carbon/human/human_cumvictim = M
	if(!human_cumvictim.client)
		to_chat(user, span_warning("You can't cum onto [M]."))
		return
	if(!(human_cumvictim.client.prefs.skyrat_toggles & CUMFACE_PREF)) //im just paranoid about runtime errors
		to_chat(user, span_warning("You can't cum onto [M]."))
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories["penis"][H.dna.species.mutant_bodyparts["penis"][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(H))
		to_chat(user, span_notice("You need to expose yourself in order to masturbate."))
		return
	else if(P.aroused != AROUSAL_FULL)
		to_chat(user, span_notice("You need to be aroused in order to masturbate."))
		return
	var/cum_volume = G.genital_size*5+5
	var/datum/reagents/R = new/datum/reagents(50)
	R.add_reagent(/datum/reagent/consumable/cum, cum_volume)
	if(M==user)
		user.visible_message(span_warning("[user] starts masturbating onto [M.p_them()]self!"), span_danger("You start masturbating onto yourself!"))
	else
		user.visible_message(span_warning("[user] starts masturbating onto [M]!"), span_danger("You start masturbating onto [M]!"))
	if(do_after(user,60,M))
		if(M==user)
			user.visible_message(span_warning("[user] cums on [M.p_them()]self!"), span_danger("You cum on yourself!"))
		else
			user.visible_message(span_warning("[user] cums on [M]!"), span_danger("You cum on [M]!"))
		R.expose(M, TOUCH)
		log_combat(user, M, "came on")
		if(prob(40))
			user.emote("moan")
		qdel(src)

//jerk off into bottles
/obj/item/coom/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(ishuman(target))
		return
	if(user.stat == DEAD)
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories["penis"][H.dna.species.mutant_bodyparts["penis"][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(H))
		to_chat(user, span_notice("You need to expose yourself in order to masturbate."))
		return
	else if(P.aroused != AROUSAL_FULL)
		to_chat(user, span_notice("You need to be aroused in order to masturbate."))
		return
	if(target.is_refillable() && target.is_drainable())
		var/cum_volume = G.genital_size*5+5
		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return
		var/datum/reagents/R = new/datum/reagents(50)
		R.add_reagent(/datum/reagent/consumable/cum, cum_volume)
		user.visible_message(span_warning("[user] starts masturbating into [target]!"), span_danger("You start masturbating into [target]!"))
		if(do_after(user,60))
			user.visible_message(span_warning("[user] cums into [target]!"), span_danger("You cum into [target]!"))
			playsound(target, "desecration", 50, TRUE)
			R.trans_to(target, cum_volume)
			if(prob(40))
				user.emote("moan")
			qdel(src)
	else
		user.visible_message(span_warning("[user] starts masturbating onto [target]!"), span_danger("You start masturbating onto [target]!"))
		if(do_after(user,60))
			var/turf/T = get_turf(target)
			user.visible_message(span_warning("[user] cums on [target]!"), span_danger("You cum on [target]!"))
			playsound(target, "desecration", 50, TRUE)
			new/obj/effect/decal/cleanable/cum(T)
			if(prob(40))
				user.emote("moan")

			if(target.icon_state=="stickyweb1"|target.icon_state=="stickyweb2")
				target.icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
			qdel(src)
