//////////////////////////////////////////////////////////////////////////
//THIS IS NOT HERESY, DO NOT TOUCH IT IN THE NAME OF GOD//////////////////
//I made this file to prevent myself from touching normal files///////////
//////////////////////////////////////////////////////////////////////////

//moved from my old interactions file 'cause skyrats already did interactions

#define REQUIRE_NONE 0
#define REQUIRE_EXPOSED 1
#define REQUIRE_UNEXPOSED 2
#define REQUIRE_ANY 3

/mob/living
	var/has_penis = FALSE
	var/has_vagina = FALSE
	var/has_breasts = FALSE
	var/anus_exposed = FALSE

/////////////////////////////////////
//Looping sound for vibrating stuff//
/////////////////////////////////////

/datum/looping_sound/vibrator
	start_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	start_length = 1
	mid_sounds = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	mid_length = 1
	end_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	falloff_distance = 1
	falloff_exponent = 5
	extra_range = SILENCED_SOUND_EXTRARANGE

/datum/looping_sound/vibrator/low
	volume = 80

/datum/looping_sound/vibrator/medium
	volume = 90

/datum/looping_sound/vibrator/high
	volume = 100

////////////////////////////////////////////////////////////////////////////////
//Boxes for vending machine, to spawn stuff with important cheap tools in pack//
////////////////////////////////////////////////////////////////////////////////

//milking machine
/obj/item/storage/box/milking_kit
	name = "DIY Milking machine kit"
	desc = "Contains everything you need to build your own milking machine!"

/obj/item/storage/box/milking_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/milking_machine/constructionkit = 1,
		/obj/item/reagent_containers/glass/beaker = 1,
		/obj/item/stock_parts/cell/upgraded = 1, //please, let it be. 1 lvl Cell makes machine almost useless, charge lasts only for 2 minutes.
		/obj/item/screwdriver = 1,
		/obj/item/wrench = 1)
	generate_items_inside(items_inside,src)

//X-Stand
/obj/item/storage/box/xstand_kit
	name = "DIY X-Stand kit"
	desc = "Contains everything you need to build your own X-stand!"

/obj/item/storage/box/xstand_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/x_stand_kit = 1,
		/obj/item/wrench = 1)
	generate_items_inside(items_inside,src)

//BDSM bed
/obj/item/storage/box/bdsmbed_kit
	name = "DIY BDSM bed kit"
	desc = "Contains everything you need to build your own BDSM bed!"

/obj/item/storage/box/bdsmbed_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/bdsm_bed_kit = 1,
		/obj/item/wrench = 1)
	generate_items_inside(items_inside,src)

//Striptease pole
/obj/item/storage/box/strippole_kit
	name = "DIY stripper pole kit"
	desc = "Contains everything you need to build your own stripper pole!"

/obj/item/storage/box/strippole_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/polepack = 1,
		/obj/item/wrench = 1)
	generate_items_inside(items_inside,src)

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////This code is supposed to be placed in "code/modules/mob/living/carbon/human/inventory.dm"/////////////
//If you are nice person you can transfer this part of code to it, but i didn't for modularisation reasons//
//////////////////////////////////////////for ball mittens//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/resist_restraints()
	if(gloves?.breakouttime)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		cuff_resist(gloves)
	else
		..()

////////////////////////////////////////////////////////////////////////////////////////
///////i needed this code for ballgag, because it doesn't muzzle, it kinda voxbox///////
//wearer for moaning. So i really need it, don't touch or whole ballgag will be broken//
/////////////////////////for ballgag mute audible emotes////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

//adding is_ballgagged() proc here. Hope won't break anything important.
//This is kinda shitcode, but they said don't touch main code or they will break my knees.
//i love my knees, please merge.

//more shitcode can be found in code/datums/emotes.dm
//in /datum/emote/proc/select_message_type(mob/user, intentional) proc. Sorry for that, i had no other choise.

//false for default
/mob/proc/is_ballgagged()
	return FALSE

/mob/living/carbon/is_ballgagged()
	return(istype(src.wear_mask, /obj/item/clothing/mask/ballgag) || istype(src.wear_mask, /obj/item/clothing/head/helmet/space/deprivation_helmet))

//proc for condoms. Need to prevent cum appearing on the floor.
/mob/proc/wear_condom()
	return FALSE

/mob/living/carbon/human/wear_condom()
	. = ..()
	if(.)
		return TRUE
	if(penis != null && istype(penis, /obj/item/clothing/sextoy/condom))
		return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////
/////////this shouldn't be put anywhere, get your dirty hands off!////////////////
/////////////////////////////for dancing pole/////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

/atom
	var/pseudo_z_axis

/atom/proc/get_fake_z()
	return pseudo_z_axis

/obj/structure/table
	pseudo_z_axis = 8

/turf/open/get_fake_z()
	var/objschecked
	for(var/obj/structure/structurestocheck in contents)
		objschecked++
		if(structurestocheck.pseudo_z_axis)
			return structurestocheck.pseudo_z_axis
		if(objschecked >= 25)
			break
	return pseudo_z_axis

/mob/living/Move(atom/newloc, direct)
	. = ..()
	if(.)
		pseudo_z_axis = newloc.get_fake_z()
		pixel_z = pseudo_z_axis

//////////////////////////////////////////////////////////////////////////////////
//this code needed to determine if human/m is naked in that part of body or not///
//////////////You can you for your own stuff if you want, haha.///////////////////
//////////////////////////////////////////////////////////////////////////////////


///Are we wearing something that covers our chest?
/mob/living/proc/is_topless()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		if((!(H.wear_suit) || !(H.wear_suit.body_parts_covered & CHEST)) && (!(H.w_uniform) || !(H.w_uniform.body_parts_covered & CHEST)))
			return TRUE
	else
		return TRUE

///Are we wearing something that covers our groin?
/mob/living/proc/is_bottomless()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		if((!(H.wear_suit) || !(H.wear_suit.body_parts_covered & GROIN)) && (!(H.w_uniform) || !(H.w_uniform.body_parts_covered & GROIN)))
			return TRUE
	else
		return TRUE

///Are we wearing something that covers our shoes?
/mob/living/proc/is_barefoot()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		if((!(H.wear_suit) || !(H.wear_suit.body_parts_covered & GROIN)) && (!(H.shoes) || !(H.shoes.body_parts_covered & FEET)))
			return TRUE
	else
		return TRUE

/mob/living/proc/is_hands_uncovered()
    if(istype(src, /mob/living/carbon/human))
        var/mob/living/carbon/human/H = src
        if(H.gloves?.body_parts_covered & ARMS)
            return FALSE
    return TRUE

/mob/living/proc/is_head_uncovered()
    if(istype(src, /mob/living/carbon/human))
        var/mob/living/carbon/human/H = src
        if(H.head?.body_parts_covered & HEAD)
            return FALSE
    return TRUE

/mob/living/proc/has_penis(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/human/C = src
	if(issilicon(src) && C.has_penis)
		return TRUE
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_PENIS)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_bottomless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_balls(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_TESTICLES)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_bottomless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_vagina(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/human/C = src
	if(issilicon(src) && C.has_vagina)
		return TRUE
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_VAGINA)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_bottomless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_breasts(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_BREASTS)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_topless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_topless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_anus(var/nintendo = REQUIRE_ANY)
	if(issilicon(src))
		return TRUE
	switch(nintendo)
		if(REQUIRE_ANY)
			return TRUE
		if(REQUIRE_EXPOSED)
			switch(anus_exposed)
				if(-1)
					return FALSE
				if(1)
					return TRUE
				else
					if(is_bottomless())
						return TRUE
					else
						return FALSE
		if(REQUIRE_UNEXPOSED)
			if(anus_exposed == -1)
				if(!anus_exposed)
					if(!is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return FALSE
			else
				return TRUE
		else
			return TRUE

/mob/living/proc/has_arms(var/nintendo = REQUIRE_ANY)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		var/handcount = 0
		var/covered = 0
		var/iscovered = FALSE
		for(var/obj/item/bodypart/l_arm/L in C.bodyparts)
			handcount++
		for(var/obj/item/bodypart/r_arm/R in C.bodyparts)
			handcount++
		if(C.get_item_by_slot(ITEM_SLOT_HANDS))
			var/obj/item/clothing/gloves/G = C.get_item_by_slot(ITEM_SLOT_HANDS)
			covered = G.body_parts_covered
		if(covered & HANDS)
			iscovered = TRUE
		switch(nintendo)
			if(REQUIRE_ANY)
				return handcount
			if(REQUIRE_EXPOSED)
				if(iscovered)
					return FALSE
				else
					return handcount
			if(REQUIRE_UNEXPOSED)
				if(!iscovered)
					return FALSE
				else
					return handcount
			else
				return handcount
	return FALSE

/mob/living/proc/has_feet(var/nintendo = REQUIRE_ANY)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		var/feetcount = 0
		var/covered = 0
		var/iscovered = FALSE
		for(var/obj/item/bodypart/l_leg/L in C.bodyparts)
			feetcount++
		for(var/obj/item/bodypart/r_leg/R in C.bodyparts)
			feetcount++
		if(!C.is_barefoot())
			covered = TRUE
		if(covered)
			iscovered = TRUE
		switch(nintendo)
			if(REQUIRE_ANY)
				return feetcount
			if(REQUIRE_EXPOSED)
				if(iscovered)
					return FALSE
				else
					return feetcount
			if(REQUIRE_UNEXPOSED)
				if(!iscovered)
					return FALSE
				else
					return feetcount
			else
				return feetcount
	return FALSE

/mob/living/proc/get_num_feet()
	return has_feet(REQUIRE_ANY)

//weird procs go here
/mob/living/proc/has_ears(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EARS)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_earsockets(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EARS)
		if(!peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_eyes(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EYES)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(C.get_item_by_slot(ITEM_SLOT_EYES))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!C.get_item_by_slot(ITEM_SLOT_EYES))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_eyesockets(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EYES)
		if(!peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(get_item_by_slot(ITEM_SLOT_EYES))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!get_item_by_slot(ITEM_SLOT_EYES))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////This code needed for neckleash//////////////////////////
//////////////////////////////////////////////////////////////////////////////////

/datum/component/redirect
	dupe_mode = COMPONENT_DUPE_ALLOWED
	var/list/signals
	var/datum/callback/turfchangeCB

/datum/component/redirect/Initialize(list/_signals, flags=NONE)
	//It's not our job to verify the right signals are registered here, just do it.
	if(!LAZYLEN(_signals))
		return COMPONENT_INCOMPATIBLE
	if(flags & REDIRECT_TRANSFER_WITH_TURF && isturf(parent))
		// If they also want to listen to the turf change then we need to set it up so both callbacks run
		if(_signals[COMSIG_TURF_CHANGE])
			turfchangeCB = _signals[COMSIG_TURF_CHANGE]
			if(!istype(turfchangeCB))
				. = COMPONENT_INCOMPATIBLE
				CRASH("Redirect components must be given instanced callbacks, not proc paths.")
		_signals[COMSIG_TURF_CHANGE] = CALLBACK(src, .proc/turf_change)

	signals = _signals

/datum/component/redirect/RegisterWithParent()
	for(var/signal in signals)
		RegisterSignal(parent, signal, signals[signal])

/datum/component/redirect/UnregisterFromParent()
	UnregisterSignal(parent, signals)

/datum/component/redirect/proc/turf_change(datum/source, path, new_baseturfs, flags, list/transfers)
	transfers += src
	return turfchangeCB?.InvokeAsync(arglist(args))

///////////////////////////////////////////////////////////////
///This code needed for changing character's gender by chems///
///////////////////////////////////////////////////////////////

/mob/living/proc/set_gender(ngender = NEUTER, silent = FALSE, update_icon = TRUE, forced = FALSE)
	if(forced || (!ckey || client?.prefs.skyrat_toggles & (ngender == FEMALE ? FORCED_FEM : FORCED_MALE)))
		gender = ngender
		return TRUE
	return FALSE

/mob/living/carbon/set_gender(ngender = NEUTER, silent = FALSE, update_icon = TRUE, forced = FALSE)
	var/bender = !(gender == ngender)
	. = ..()
	if(!.)
		return
	if(dna && bender)
		if(ngender == MALE || ngender == FEMALE)
			dna.features["body_model"] = ngender
			if(!silent)
				var/adj = ngender == MALE ? "masculine" : "feminine"
				visible_message(span_boldnotice("[src] suddenly looks more [adj]!"), span_boldwarning("You suddenly feel more [adj]!"))
		else if(ngender == NEUTER)
			dna.features["body_model"] = MALE
	if(update_icon)
		update_body()

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////// INVENTORY SYSTEM EXTENTION //////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////
// ERP INVENTORY ITEM SLOTS //
//////////////////////////////

// /// Vagina slot
// #define ITEM_SLOT_VAGINA (1<<21)
// /// Anus slot
// #define ITEM_SLOT_ANUS (1<<22)
// /// Nipples slot
// #define ITEM_SLOT_NIPPLES (1<<23)
// /// Penis slot
// #define ITEM_SLOT_PENIS (1<<20)

//SLOT GROUP HELPERS
#define ITEM_SLOT_ERP_INSERTABLE (ITEM_SLOT_VAGINA|ITEM_SLOT_ANUS)
#define ITEM_SLOT_ERP_ATTACHABLE (ITEM_SLOT_NIPPLES|ITEM_SLOT_PENIS)

// Strippable Defines
#define ERP_SLOT_EQUIP_DELAY (5 SECONDS) // Lamella TODO: delay need to be balanced

#define STRIPPABLE_ITEM_VAGINA "vagina"
#define STRIPPABLE_ITEM_ANUS "anus"
#define STRIPPABLE_ITEM_NIPPLES "nipples"
#define STRIPPABLE_ITEM_PEINS "penis"

////////////////////////////////////
// OUTFIT SYSTEM ERP SLOT SUPPORT //
////////////////////////////////////

// Variables for ERP slots
/datum/outfit
	/// Type path of item for vagina slot
	var/vagina = null
	/// Type path of item for anus slot
	var/anus = null
	/// Type path of item for nipples slot
	var/nipples = null
	/// Type path of item for penis slot
	var/penis = null

// Complementing the equipment procedure
/datum/outfit/equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(.)
		pre_equip(H, visualsOnly)
		if(vagina)
			H.equip_to_slot_or_del(new vagina(H),ITEM_SLOT_VAGINA, TRUE)
		if(anus)
			H.equip_to_slot_or_del(new anus(H),ITEM_SLOT_ANUS, TRUE)
		if(nipples)
			H.equip_to_slot_or_del(new nipples(H),ITEM_SLOT_NIPPLES, TRUE)
		if(penis)
			H.equip_to_slot_or_del(new penis(H),ITEM_SLOT_PENIS, TRUE)
		post_equip(H, visualsOnly)
		H.update_body()
		H?.hud_used?.hidden_inventory_update(H)
	return TRUE


// Support fingerprints when working with ERP slots
/datum/outfit/apply_fingerprints(mob/living/carbon/human/H)
	. = ..()
	if(.)
		if(!istype(H))
			return
		if(H.vagina)
			H.vagina.add_fingerprint(H,1)
		if(H.anus)
			H.anus.add_fingerprint(H,1)
		if(H.nipples)
			H.nipples.add_fingerprint(H,1)
		if(H.penis)
			H.penis.add_fingerprint(H,1)
	return 1

// Supplementing the data structure with ERP slot data
/datum/outfit/get_json_data()
	var/list/L = ..()

	L["vagina"] = vagina
	L["anus"] = anus
	L["nipples"] = nipples
	L["penis"] = penis

// Supplementing the data structure with ERP slot data
/datum/outfit/load_from(list/outfit_data)
	vagina = text2path(outfit_data["vagina"])
	anus = text2path(outfit_data["anus"])
	nipples = text2path(outfit_data["nipples"])
	penis = text2path(outfit_data["penis"])
	..()

// Just by analogy with the TG code. No ideas for what this is.
/mob/proc/update_inv_vagina()
	return
/mob/proc/update_inv_anus()
	return
/mob/proc/update_inv_nipples()
	return
/mob/proc/update_inv_penis()
	return

// Add variables for slots to the Carbon class
/mob/living/carbon/human
	var/obj/item/vagina = null
	var/obj/item/anus = null
	var/obj/item/nipples = null
	var/obj/item/penis = null

/////////////////////////////
//    SEXTOY CLOTH TYPE    //
/////////////////////////////

/obj/item/clothing/sextoy
	name = "sextoy"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg'
	drop_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	slot_flags = ITEM_SLOT_VAGINA | ITEM_SLOT_ANUS | ITEM_SLOT_PENIS | ITEM_SLOT_NIPPLES
	var/mutantrace_variation = NO_MUTANTRACE_VARIATION //Are there special sprites for specific situations? Don't use this unless you need to.

/obj/item/clothing/sextoy/dropped(mob/user)
	..()

	update_appearance()
	if(!ishuman(loc))
		return

	var/mob/living/carbon/human/holder = loc
	holder.update_inv_vagina()
	holder.update_inv_anus()
	holder.update_inv_nipples()
	holder.update_inv_penis()
	holder.fan_hud_set_fandom()

/////////////////////////////
// ICON UPDATING EXTENTION //
/////////////////////////////

// Regenerate ERP icons to
/mob/living/carbon/human/regenerate_icons()
	.=..()
	update_inv_vagina()
	update_inv_anus()
	update_inv_nipples()
	update_inv_penis()

// Updating vagina slot
/mob/living/carbon/human/update_inv_vagina()
	if(client?.prefs?.sextoys_pref == "Yes")
		if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_VAGINA) + 1])
			var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_VAGINA) + 1]
			inv.update_icon()

		if(vagina)
			if(hud_used.inventory_shown && hud_used)
				vagina?.screen_loc = ui_vagina
			else
				vagina?.screen_loc = ui_vagina_down
			if(hud_used.hud_shown)
				client.screen += vagina
			update_observer_view(vagina)
			hud_used.hidden_inventory_update(src)

	//on_mob stuff
	remove_overlay(VAGINA_LAYER)

	var/obj/item/clothing/sextoy/U = vagina

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) //you can add proper flags here if required
		return

	var/icon_file = vagina?.worn_icon
	var/mutable_appearance/vagina_overlay

	if(!vagina_overlay)
		vagina_overlay = U?.build_worn_icon(default_layer = VAGINA_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_icon = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		vagina_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		vagina_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[VAGINA_LAYER] = vagina_overlay

	apply_overlay(VAGINA_LAYER)
	update_mutant_bodyparts()

// Updating anus slot
/mob/living/carbon/human/update_inv_anus()
	if(client?.prefs?.sextoys_pref == "Yes")
		if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ANUS) + 1])
			var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ANUS) + 1]
			inv.update_icon()

		if(anus)
			if(hud_used.inventory_shown && hud_used)
				anus?.screen_loc = ui_anus
			else
				anus?.screen_loc = ui_anus_down
			if(hud_used.hud_shown)
				client.screen += anus
			update_observer_view(anus)
			hud_used.hidden_inventory_update(src)

	//on_mob stuff
	remove_overlay(ANUS_LAYER)

	var/obj/item/clothing/sextoy/U = anus

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) //you can add proper flags here if required
		return

	var/icon_file = anus?.worn_icon
	var/mutable_appearance/anus_overlay

	if(!anus_overlay)
		anus_overlay = U?.build_worn_icon(default_layer = ANUS_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_icon = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		anus_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		anus_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[ANUS_LAYER] = anus_overlay

	apply_overlay(ANUS_LAYER)
	update_mutant_bodyparts()

// Updating nipples slot
/mob/living/carbon/human/update_inv_nipples()
	if(client?.prefs?.sextoys_pref == "Yes")
		if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NIPPLES) + 1])
			var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NIPPLES) + 1]
			inv.update_icon()

		if(nipples)
			if(hud_used.inventory_shown && hud_used)
				nipples?.screen_loc = ui_nipples
			else
				nipples?.screen_loc = ui_nipples_down
			if(hud_used.hud_shown)
				client.screen += nipples
			update_observer_view(nipples)
			hud_used.hidden_inventory_update(src)

	//on_mob stuff
	remove_overlay(NIPPLES_LAYER)

	var/obj/item/clothing/sextoy/U = nipples

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) //you can add proper flags here if required
		return

	var/icon_file = nipples?.worn_icon
	var/mutable_appearance/nipples_overlay

	if(!nipples_overlay)
		nipples_overlay = U?.build_worn_icon(default_layer = NIPPLES_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_icon = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		nipples_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		nipples_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[NIPPLES_LAYER] = nipples_overlay

	apply_overlay(NIPPLES_LAYER)
	update_mutant_bodyparts()

// Updating penis slot
/mob/living/carbon/human/update_inv_penis()
	if(client?.prefs?.sextoys_pref == "Yes")
		if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_PENIS) + 1])
			var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_PENIS) + 1]
			inv.update_icon()

		if(penis)
			if(hud_used.inventory_shown && hud_used)
				penis?.screen_loc = ui_penis
			else
				penis?.screen_loc = ui_penis_down
			if(hud_used.hud_shown)
				client.screen += penis
			update_observer_view(penis)
			hud_used.hidden_inventory_update(src)

	//on_mob stuff
	remove_overlay(PENIS_LAYER)

	var/obj/item/clothing/sextoy/U = penis

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) //you can add proper flags here if required
		return

	var/icon_file = penis?.worn_icon
	var/mutable_appearance/penis_overlay

	if(!penis_overlay)
		penis_overlay = U?.build_worn_icon(default_layer = PENIS_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_icon = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		penis_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		penis_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[PENIS_LAYER] = penis_overlay

	apply_overlay(PENIS_LAYER)
	update_mutant_bodyparts()

// Shoes update extention for supporting correctt removing shoe in sleepbag
/mob/living/carbon/human/update_inv_shoes()

	if(istype(src.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		remove_overlay(SHOES_LAYER)

		if(dna.species.mutant_bodyparts["taur"])
			var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
			if(S.hide_legs)
				return

		if(num_legs<2)
			return

		if(client && hud_used)
			var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_FEET) + 1]
			inv.update_icon()

		if(shoes)
			shoes.screen_loc = ui_shoes					//move the item to the appropriate screen loc
			if(client && hud_used && hud_used.hud_shown)
				if(hud_used.inventory_shown)			//if the inventory is open
					client.screen += shoes					//add it to client's screen
			update_observer_view(shoes,1)
			var/icon_file = shoes.worn_icon
			var/applied_styles = NONE
			if((DIGITIGRADE in dna.species.species_traits) && (shoes.mutant_variants & STYLE_DIGITIGRADE))
				applied_styles |= STYLE_DIGITIGRADE
				icon_file = shoes.worn_icon_digi || 'modular_skyrat/master_files/icons/mob/clothing/feet_digi.dmi'

			overlays_standing[SHOES_LAYER] = shoes.build_worn_icon(default_layer = SHOES_LAYER, default_icon_file = 'icons/mob/clothing/feet.dmi', override_icon = icon_file, mutant_styles = applied_styles)
			var/mutable_appearance/shoes_overlay = overlays_standing[SHOES_LAYER]
			if(OFFSET_SHOES in dna.species.offset_features)
				shoes_overlay.pixel_x += dna.species.offset_features[OFFSET_SHOES][1]
				shoes_overlay.pixel_y += dna.species.offset_features[OFFSET_SHOES][2]
			overlays_standing[SHOES_LAYER] = shoes_overlay

		// apply_overlay(SHOES_LAYER)

		return
	else
		..()

// Updating vagina hud slot
/mob/living/carbon/human/update_hud_vagina(obj/item/I)
	I.screen_loc = ui_vagina
	if(client && src.hud_used?.hud_shown)
		if(src.hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

// Updating anus hud slot
/mob/living/carbon/human/update_hud_anus(obj/item/I)
	I.screen_loc = ui_anus
	if(client && src.hud_used?.hud_shown)
		if(src.hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

// Updating nipples hud slot
/mob/living/carbon/human/update_hud_nipples(obj/item/I)
	I.screen_loc = ui_nipples
	if(client && src.hud_used?.hud_shown)
		if(src.hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

// Updating penis hud slot
/mob/living/carbon/human/update_hud_penis(obj/item/I)
	I.screen_loc = ui_penis
	if(client && src.hud_used?.hud_shown)
		if(src.hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

// Update whether our back item appears on our hud.
/mob/living/carbon/proc/update_hud_vagina(obj/item/I)
	return

// Update whether our back item appears on our hud.
/mob/living/carbon/proc/update_hud_anus(obj/item/I)
	return

// Update whether our back item appears on our hud.
/mob/living/carbon/proc/update_hud_nipples(obj/item/I)
	return

// Update whether our back item appears on our hud.
/mob/living/carbon/proc/update_hud_penis(obj/item/I)
	return

//////////////////////////////////
// UI CONSTRUCTION AND HANDLING //
//////////////////////////////////

// Add to hud class additional ERP variable boolean for check inventiry status (equipped or not)
/datum/hud
	var/list/ERP_toggleable_inventory = list() //the screen ERP objects which can be hidden
	var/ERP_inventory_shown = FALSE //Equipped item ERP inventory

// Define additional button for ERP hud slots for expand/collapse like default inventory
/atom/movable/screen/human/ERP_toggle
	name = "ERP_toggle"
	icon_state = "toggle"

// ERP inventory button logic. Just expand/collapse
/atom/movable/screen/human/ERP_toggle/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.ERP_inventory_shown && targetmob.hud_used)
		usr.hud_used.ERP_inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.ERP_toggleable_inventory
	else
		usr.hud_used.ERP_inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.ERP_toggleable_inventory

	targetmob.hud_used.hidden_inventory_update(usr)

////////////////////////////////////
// STRIPPING ERP SYSTEM EXTENTION //
////////////////////////////////////

// Extend stripping menus with ERP slots
/datum/strippable_item/mob_item_slot/vagina
	key = STRIPPABLE_ITEM_VAGINA
	item_slot = ITEM_SLOT_VAGINA

/datum/strippable_item/mob_item_slot/anus
	key = STRIPPABLE_ITEM_ANUS
	item_slot = ITEM_SLOT_ANUS

/datum/strippable_item/mob_item_slot/nipples
	key = STRIPPABLE_ITEM_NIPPLES
	item_slot = ITEM_SLOT_NIPPLES

/datum/strippable_item/mob_item_slot/penis
	key = STRIPPABLE_ITEM_PEINS
	item_slot = ITEM_SLOT_PENIS

// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/vagina/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs.sextoys_pref == "Yes")
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY
// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/anus/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs.sextoys_pref == "Yes")
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY
// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/nipples/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs.sextoys_pref == "Yes")
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY
// Obscuring for ERP slots
/datum/strippable_item/mob_item_slot/penis/get_obscuring(atom/source)
	var/mob/M = source
	if(M.client?.prefs.sextoys_pref == "Yes")
		return isnull(get_item(source)) \
			? STRIPPABLE_OBSCURING_NONE \
			: STRIPPABLE_OBSCURING_HIDDEN
	else
		return STRIPPABLE_OBSCURING_COMPLETELY

// Strippable ERP items slot list
GLOBAL_LIST_INIT(strippable_human_erp_items, create_erp_strippable_list(list(
	/datum/strippable_item/mob_item_slot/vagina,
	/datum/strippable_item/mob_item_slot/anus,
	/datum/strippable_item/mob_item_slot/nipples,
	/datum/strippable_item/mob_item_slot/penis,
)))

// This list is only needed in order to immediately add the necessary elements to a typical global list
/proc/create_erp_strippable_list(types)
	var/list/strippable_items = list()

	for (var/strippable_type in types)
		var/datum/strippable_item/strippable_item = new strippable_type
		strippable_items[strippable_item.key] = strippable_item
	GLOB.strippable_human_items += strippable_items
	return strippable_items

////////////////////////////////////////////////////////////////////
// EXTENTIONS FOR SPRITE_ACCESSORY IS_HIDDEN CHECKS FOR ERP STUFF //
////////////////////////////////////////////////////////////////////

// Extends default proc check for hidden ears for supporting our sleepbag and catsuit to
/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
	// 	return TRUE
	// return FALSE

	// First lets proc default code
	. = ..()
	if(!.) // If true, ears already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden frills for supporting our sleepbag and catsuit to
/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.try_hide_mutant_parts || (H.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC))
	// 	return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, frills already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden head accessory for supporting our sleepbag and catsuit to
/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
	// 	return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, head accessory already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden horns for supporting our sleepbag and catsuit to
/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
	// 	return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, horns already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden antenna for supporting our sleepbag and catsuit to
/datum/sprite_accessory/antenna/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
	// 	return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, antenna already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden moth antenna for supporting our sleepbag and catsuit to
/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
	// 	return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, moth antenna already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit to
/datum/sprite_accessory/skrell_hair/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
	// 	return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, skrell hair already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			if(S.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit to
/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	// // Default proc code
	// if(H.wear_suit)
	// 	if(H.try_hide_mutant_parts)
	// 		return TRUE
	// 	if(H.wear_suit.flags_inv & HIDEJUMPSUIT)
	// 		if(istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit))
	// 			var/obj/item/clothing/suit/space/hardsuit/HS = H.wear_suit
	// 			if(HS.hardsuit_tail_colors)
	// 				return FALSE
	// 		return TRUE
	// return FALSE

	. = ..()
	if(!.) // If true, tail already hidden
		if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			// var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
			// if(S.state_thing == "inflated")
			// 	return TRUE
			return TRUE /* return FALSE */
		else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return TRUE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden wings for supporting our sleepbag and catsuit to
/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return TRUE
	if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return TRUE
	return FALSE

/mob/living/carbon/set_handcuffed(new_value)
	var/mob/living/carbon/human/H = src
	if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return FALSE
	..()

//asdasda
/datum/sprite_accessory/xenodorsal/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return TRUE
	else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
		return TRUE
	return FALSE

//asdfasdfdasf
/datum/sprite_accessory/xenohead/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/S = H.wear_suit
		if(S.state_thing == "inflated")
			return TRUE
		return FALSE
	else if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
		return FALSE
	return FALSE
