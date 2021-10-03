#define HYPO_SPRAY 0
#define HYPO_INJECT 1

#define WAIT_SPRAY 15
#define WAIT_INJECT 20
#define SELF_SPRAY 15
#define SELF_INJECT 15

#define DELUXE_WAIT_SPRAY 0
#define DELUXE_WAIT_INJECT 5
#define DELUXE_SELF_SPRAY 10
#define DELUXE_SELF_INJECT 10

#define COMBAT_WAIT_SPRAY 0
#define COMBAT_WAIT_INJECT 0
#define COMBAT_SELF_SPRAY 0
#define COMBAT_SELF_INJECT 0

/obj/item/hypospray/mkii
	name = "hypospray mk.II"
	icon_state = "hypo2"
	icon = 'modular_skyrat/modules/hyposprays/icons/hyposprays.dmi'
	desc = "A new development from DeForest Medical, this hypospray takes 60-unit vials as the drug supply for easy swapping."
	w_class = WEIGHT_CLASS_TINY
	var/list/allowed_containers = list(/obj/item/reagent_containers/glass/bottle/vial/small)
	//Inject or spray?
	var/mode = HYPO_INJECT
	var/obj/item/reagent_containers/glass/bottle/vial/vial
	var/start_vial = /obj/item/reagent_containers/glass/bottle/vial/small
	var/spawnwithvial = TRUE

	//Time taken to inject others
	var/inject_wait = WAIT_INJECT
	//Time taken to spray others
	var/spray_wait = WAIT_SPRAY
	//Time taken to inject self
	var/inject_self = SELF_INJECT
	//Time taken to spray self
	var/spray_self = SELF_SPRAY

	//Can you hotswap vials? - now all hyposprays can!
	var/quickload = TRUE
	//Does it go through hardsuits?
	var/penetrates = FALSE

/obj/item/hypospray/mkii/CMO
	name = "hypospray mk.II deluxe"
	allowed_containers = list(/obj/item/reagent_containers/glass/bottle/vial/small, /obj/item/reagent_containers/glass/bottle/vial/large)
	icon_state = "cmo2"
	desc = "The deluxe hypospray can take larger 120-unit vials. It also acts faster and can deliver more reagents per spray."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	start_vial = /obj/item/reagent_containers/glass/bottle/vial/large/deluxe
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_SPRAY
	inject_self = DELUXE_SELF_INJECT

/obj/item/hypospray/mkii/Initialize()
	. = ..()
	if(!spawnwithvial)
		update_appearance()
		return
	if(start_vial)
		vial = new start_vial
		update_appearance()

/obj/item/hypospray/mkii/update_overlays()
	. = ..()
	if(!vial)
		return
	if(!vial.reagents.total_volume)
		return
	var/vial_spritetype = "chem-color"
	if(/obj/item/reagent_containers/glass/bottle/vial/large in allowed_containers)
		vial_spritetype += "-cmo"
	var/mutable_appearance/chem_loaded = mutable_appearance('modular_skyrat/modules/hyposprays/icons/hyposprays.dmi', vial_spritetype)
	chem_loaded.color = vial.chem_color
	. += chem_loaded

/obj/item/hypospray/mkii/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/hypospray/mkii/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][vial ? "" : "-e"]"

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	if(vial)
		. += "[vial] has [vial.reagents.total_volume]u remaining."
	else
		. += "It has no vial loaded in."
	. += "[src] is set to [mode ? "Inject" : "Spray"] contents on application."

/obj/item/hypospray/mkii/proc/unload_hypo(obj/item/hypo, mob/user)
	if((istype(hypo, /obj/item/reagent_containers/glass/bottle/vial)))
		var/obj/item/reagent_containers/glass/bottle/vial/container = hypo
		container.forceMove(user.loc)
		user.put_in_hands(container)
		to_chat(user, span_notice("You remove [vial] from [src]."))
		vial = null
		update_icon()
		playsound(loc, 'sound/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("This hypo isn't loaded!"))
		return

/obj/item/hypospray/mkii/proc/insert_vial(obj/item/new_vial, mob/living/user, obj/item/current_vial)
	var/obj/item/reagent_containers/glass/bottle/vial/container = new_vial
	if(!is_type_in_list(container, allowed_containers))
		to_chat(user, span_notice("[src] doesn't accept this type of vial."))
		return FALSE
	if(current_vial)
		var/obj/item/reagent_containers/glass/bottle/vial/old_container = current_vial
		old_container.forceMove(drop_location())
	if(!user.transferItemToLoc(container, src))
		return FALSE
	vial = container
	user.visible_message(span_notice("[user] has loaded a vial into [src]."), span_notice("You have loaded [vial] into [src]."))
	playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()
	if(current_vial)
		user.put_in_hands(current_vial)

/obj/item/hypospray/mkii/attackby(obj/item/used_item, mob/living/user)
	if((istype(used_item, /obj/item/reagent_containers/glass/bottle/vial) && vial != null))
		if(!quickload)
			to_chat(user, span_warning("[src] can not hold more than one vial!"))
			return FALSE
		else
			insert_vial(used_item, user, vial)
			return TRUE

	if((istype(used_item, /obj/item/reagent_containers/glass/bottle/vial)))
		insert_vial(used_item, user)
		return TRUE

/obj/item/hypospray/mkii/AltClick(mob/user)
	. = ..()
	if(vial)
		vial.attack_self(user)
		return TRUE

/obj/item/hypospray/mkii/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		to_chat(user, "[src] happens to be already overcharged.")
		return
	//all these are 0
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = TRUE
	to_chat(user, "You overcharge [src]'s control circuit.")
	obj_flags |= EMAGGED
	return TRUE

/obj/item/hypospray/mkii/attack_hand(mob/user)
	. = ..() //Don't bother changing this or removing it from containers will break.

/obj/item/hypospray/mkii/attack(obj/item/hypo, mob/user, params)
	return

/obj/item/hypospray/mkii/afterattack(atom/target, mob/living/user, proximity)
	if((istype(target, /obj/item/reagent_containers/glass/bottle/vial)))
		insert_vial(target, user, vial)
		return TRUE

	if(!vial || !proximity || !isliving(target))
		return
	var/mob/living/injectee = target

	if(!injectee.reagents || !injectee.can_inject(user, TRUE, user.zone_selected, penetrates))
		return

	if(iscarbon(injectee))
		var/obj/item/bodypart/affecting = injectee.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
	//Always log attemped injections for admins
	var/contained = vial.reagents.log_list()
	log_combat(user, injectee, "attemped to inject", src, addition="which had [contained]")

	if(!vial)
		to_chat(user, span_notice("[src] doesn't have any vial installed!"))
		return
	if(!vial.reagents.total_volume)
		to_chat(user, span_notice("[src]'s vial is empty!"))
		return

	var/fp_verb = mode == HYPO_SPRAY ? "spray" : "inject"

	if(injectee != user)
		injectee.visible_message(span_danger("[user] is trying to [fp_verb] [injectee] with [src]!</span>"), \
						span_userdanger("is trying to [fp_verb] you with [src]!"))
	if(!do_mob(user, injectee, inject_wait, extra_checks = CALLBACK(injectee, /mob/living/proc/can_inject, user, FALSE, user.zone_selected, penetrates)))
		return
	if(!vial.reagents.total_volume)
		return
	log_attack("<font color='red'>[user.name] ([user.ckey]) applied [src] to [injectee.name] ([injectee.ckey]), which had [contained] (COMBAT MODE: [uppertext(user.combat_mode)]) (MODE: [mode])</font>")
	if(injectee != user)
		injectee.visible_message(span_danger("[user] uses the [src] on [injectee]!</span>"), \
						span_userdanger("[user] uses the [src] on you!"))
	else
		injectee.log_message("<font color='orange'>applied [src] to themselves ([contained]).</font>", INDIVIDUAL_ATTACK_LOG)

	switch(mode)
		if(HYPO_INJECT)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this)
		if(HYPO_SPRAY)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = PATCH)

	var/long_sound = vial.amount_per_transfer_from_this >= 15
	playsound(loc, long_sound ? 'modular_skyrat/modules/hyposprays/sound/hypospray_long.ogg' : pick('modular_skyrat/modules/hyposprays/sound/hypospray.ogg','modular_skyrat/modules/hyposprays/sound/hypospray2.ogg'), 50, 1, -1)
	to_chat(user, span_notice("You [fp_verb] [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units.</span>"))
	update_appearance()

/obj/item/hypospray/mkii/attack_self(mob/living/user)
	if(user)
		if(user.incapacitated())
			return
		else if(!vial)
			to_chat(user, "This Hypo needs to be loaded first!")
			return
		else
			unload_hypo(vial,user)

/obj/item/hypospray/mkii/CtrlClick(mob/living/user)
	. = ..()
	if(user.canUseTopic(src, FALSE) && user.get_active_held_item(src))
		switch(mode)
			if(HYPO_SPRAY)
				mode = HYPO_INJECT
				to_chat(user, "[src] is now set to inject contents on application.")
			if(HYPO_INJECT)
				mode = HYPO_SPRAY
				to_chat(user, "[src] is now set to spray contents on application.")
		return TRUE

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	. += span_notice("<b>Ctrl-Click</b> it to toggle its mode from spraying to injecting and vice versa.")

#undef HYPO_SPRAY
#undef HYPO_INJECT
#undef WAIT_SPRAY
#undef WAIT_INJECT
#undef SELF_SPRAY
#undef SELF_INJECT
#undef DELUXE_WAIT_SPRAY
#undef DELUXE_WAIT_INJECT
#undef DELUXE_SELF_SPRAY
#undef DELUXE_SELF_INJECT
#undef COMBAT_WAIT_SPRAY
#undef COMBAT_WAIT_INJECT
#undef COMBAT_SELF_SPRAY
#undef COMBAT_SELF_INJECT
