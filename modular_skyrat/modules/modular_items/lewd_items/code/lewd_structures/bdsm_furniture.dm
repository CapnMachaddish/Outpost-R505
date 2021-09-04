/obj/structure/bed/bdsm_bed
	name = "bdsm bed"
	desc = "A latex bed with D-rings on the sides. Looks comfortable."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	icon_state = "bdsm_bed"
	max_integrity = 50

/obj/item/bdsm_bed_kit
	name = "bdsm bed construction kit"
	desc = "Construction requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "bdsm_bed_kit"
	var/unwrapped = 0
	w_class = WEIGHT_CLASS_HUGE

/obj/item/bdsm_bed_kit/attackby(obj/item/P, mob/user, params) //constructing a bed here.
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		if (!(item_flags & IN_INVENTORY))
			to_chat(user, span_notice("You fasten the frame to the floor and begin to inflate the latex pillows..."))
			if(P.use_tool(src, user, 8 SECONDS, volume=50))
				to_chat(user, span_notice("You assemble the bdsm bed."))
				var/obj/structure/bed/bdsm_bed/C = new
				C.loc = loc
				qdel(src)
			return
	else
		return ..()

/obj/structure/bed/bdsm_bed/post_buckle_mob(mob/living/M)
	density = TRUE
	//Push them up from the normal lying position
	M.pixel_y = M.base_pixel_y

/obj/structure/bed/bdsm_bed/post_unbuckle_mob(mob/living/M)
	density = FALSE
	//Set them back down to the normal lying position
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset

/obj/structure/bed/bdsm_bed/attackby(obj/item/P, mob/user, params) //deconstructing a bed. Aww(
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		to_chat(user, span_notice("You begin unfastening the frame of bdsm bed and deflating the latex pillows..."))
		if(P.use_tool(src, user, 8 SECONDS, volume=50))
			to_chat(user, span_notice("You disassemble the BDSM bed."))
			var/obj/item/bdsm_bed_kit/C = new
			C.loc = loc
			unbuckle_all_mobs()
			qdel(src)
		return
	else
		return ..()

/obj/structure/bed/bdsm_bed/Destroy()
	. = ..()
	unbuckle_all_mobs(TRUE)

/////////////////////
//X-Stand code here//
/////////////////////

/obj/structure/chair/x_stand
	name = "x stand"
	desc = "A stand for buckling people in an X shape."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	icon_state = "xstand"
	max_buckled_mobs = 1
	max_integrity = 75
	var/stand_state = "open"
	var/stand_open = FALSE
	var/list/stand_states = list("open" = "close", "close" = "open")
	var/state_thing = "open"
	var/static/mutable_appearance/xstand_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi', "xstand_overlay", LYING_MOB_LAYER)
	var/mob/living/carbon/human/current_mob = null

//to make it have model when we constructing the thingy
/obj/structure/chair/x_stand/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

/obj/structure/chair/x_stand/Destroy()
	. = ..()
	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
	unbuckle_all_mobs(TRUE)

/obj/structure/chair/x_stand/update_icon_state()
    . = ..()
    icon_state = "[initial(icon_state)]_[stand_state? "open" : "close"]"

//X-Stand LBM interaction handler
/obj/structure/chair/x_stand/attack_hand(mob/living/user)
	var/mob/living/M = locate() in src.loc
	// X-Stand is empty?
	if(!has_buckled_mobs())
		// Is there someone on the X-Stand tile?
		if(M)
			// Can a mob in a X-Stand tile be buckled?
			if(M.can_buckle_to)
				user_buckle_mob(M, user, check_loc = TRUE)
			else
				// The X-Stand is empty, but there is a mob in the X-Stand tile that cannot be buckled
				// A place to report the impossibility to buckle the current mob in X-Stand
		else
			// The stand is empty, there is no one in the tile. We just change the state of the stand.
			toggle_mode(user)
	else
		// The X-Stand is not empty. Get the mob in the X-Stand and try to unbuckle it.
		var/mob/living/buckled_mob = buckled_mobs[1]
		user_unbuckle_mob(buckled_mob, user)


// Object cannot rotate
/obj/structure/chair/x_stand/can_be_rotated(mob/user)
	return FALSE
// User cannot rotate the object
/obj/structure/chair/x_stand/can_user_rotate(mob/user)
	return FALSE
// Another plug to disable rotation
/obj/structure/chair/x_stand/attack_tk(mob/user)
	return FALSE

// Handler for attempting to unbukle a mob from a X-Stand
/obj/structure/chair/x_stand/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	// Let's make sure that the X-Stand is in the correct state
	if(stand_state == "open")
		toggle_mode(user)
	var/mob/living/M = unbuckle_mob(buckled_mob)
	if(M)
		if(M != user)
			if(!do_after(user, 5 SECONDS, M)) // Timer for unbuckling one mob with another mob
				// Place to describe failed attempt
				return FALSE
			// Description of a successful attempt
			M.visible_message(span_notice("[user] unbuckles [M] from [src]."),\
				span_notice("[user] unbuckles you from [src]."),\
				span_hear("You hear metal clanking."))
			// Description of a successful mob attempt to unbuckle one mob with another mob
		else
			// Description of a successful mob attempt to unbuckle itself
			user.visible_message(span_notice("You unbuckle yourself from [src]."),\
				span_hear("You hear metal clanking."))
		add_fingerprint(user)
		if(isliving(M.pulledby))
			var/mob/living/L = M.pulledby
			L.set_pull_offsets(M, L.grab_state)
		toggle_mode(user)
	return M

// Handler for attempting to buckle a mob into a X-Stand
/obj/structure/chair/x_stand/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	// Let's make sure that the X-Stand is in the correct state
	if(stand_state == "close")
		toggle_mode(user)
		//return  // Uncomment if it is necessary to "open" the X-Stand as a separate action before buckling

	// Is buckling even possible? Do a full suite of checks.
	if(!is_user_buckle_possible(M, user, check_loc))
		return FALSE
	add_fingerprint(user)

	// If the mob we're attempting to buckle is not stood on this atom's turf and it isn't the user buckling themselves,
	// we'll try it with a 2 second do_after delay.
	if(M != user)
		// Place to describe an attempt to buckle a mob
		M.visible_message(span_warning("[user] starts buckling [M] to [src]!"),\
			span_userdanger("[user] starts buckling you to [src]!"),\
			span_hear("You hear metal clanking."))
		if(!do_after(user, 5 SECONDS, M)) // Timer to buckle one mob by another
			// Place to describe a failed buckling attempt
			return FALSE

		// Sanity check before we attempt to buckle. Is everything still in a kosher state for buckling after the 3 seconds have elapsed?
		// Covers situations where, for example, the chair was moved or there's some other issue.
		if(!is_user_buckle_possible(M, user, check_loc))
			// A place to report the inability to buckle a mob
			return FALSE


		// Place to insert a description of a successful attempt for a user mob
		if(buckle_mob(M, check_loc = check_loc))
			// Description of a successful attempt to buckle a mob by another mob
			M.visible_message(span_warning("[user] starts buckling [M] to [src]!"),\
				span_userdanger("[user] starts buckling you to [src]!"),\
				span_hear("You hear metal clanking."))
		toggle_mode(user)

	else
		if(!do_after(user, 10 SECONDS, M)) // Timer to buckle the mob itself
			// Place to describe failed attempt
			return FALSE

		// Sanity check before we attempt to buckle. Is everything still in a kosher state for buckling after the 3 seconds have elapsed?
		// Covers situations where, for example, the chair was moved or there's some other issue.
		if(!is_user_buckle_possible(M, user, check_loc))
			// Place to report the inability to buckle
			return FALSE

		if(buckle_mob(M, check_loc = check_loc))
			user.visible_message(span_warning("You buckles yourself to [src]!"),\
				span_hear("You hear metal clanking."))
		toggle_mode(user)

// X-Stand state switch processing
/obj/structure/chair/x_stand/proc/toggle_mode(mob/user)
	state_thing = stand_states[state_thing]
	switch(state_thing)
		if("open")
			stand_state = "open"
			cut_overlay(xstand_overlay)
		if("close")
			stand_state = "close"
			add_overlay(xstand_overlay)
	add_fingerprint(user)
	update_icon_state()
	update_icon()
	playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)

// Machine deconstruction process handler
/obj/structure/chair/x_stand/deconstruct()
	qdel(src)
	return TRUE

//Place the mob in the desired position after buckling
/obj/structure/chair/x_stand/post_buckle_mob(mob/living/M)
	M.pixel_y = M.base_pixel_y
	M.pixel_x = M.base_pixel_x
	M.layer = BELOW_MOB_LAYER

	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.forceMove(loc)
			current_mob.handcuffed.dropped(current_mob)
			current_mob.set_handcuffed(null)
			current_mob.update_handcuffed()
		current_mob.set_handcuffed(new /obj/item/restraints/handcuffs/milker(current_mob))
		current_mob.handcuffed.parented_struct = src
		current_mob.update_abstract_handcuffed()

//Restore the position of the mob after unbuckling.
/obj/structure/chair/x_stand/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.base_pixel_x + M.body_position_pixel_x_offset
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset
	M.layer = initial(M.layer)

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
	current_mob = null

///////////////////////////
//xstand construction kit//
///////////////////////////

/obj/item/x_stand_kit
	name = "xstand construction kit"
	desc = "Construction requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "xstand_kit"
	var/unwrapped = 0
	w_class = WEIGHT_CLASS_HUGE

/obj/item/x_stand_kit/attackby(obj/item/P, mob/user, params) //constructing a bed here.
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		if (!(item_flags & IN_INVENTORY))
			to_chat(user, span_notice("You begin fastening the frame to the floor."))
			if(P.use_tool(src, user, 8 SECONDS, volume=50))
				to_chat(user, span_notice("You assemble the x-stand."))
				var/obj/structure/chair/x_stand/C = new
				C.loc = loc
				qdel(src)
			return
	else
		return ..()

/obj/structure/chair/x_stand/attackby(obj/item/P, mob/user, params) //deconstructing a bed. Aww(
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		to_chat(user, span_notice("You begin unfastening the frame of x-stand..."))
		if(P.use_tool(src, user, 8 SECONDS, volume=50))
			to_chat(user, span_notice("You disassemble the x-stand."))
			var/obj/item/x_stand_kit/C = new
			C.loc = loc
			unbuckle_all_mobs()
			qdel(src)
		return
	else
		return ..()
