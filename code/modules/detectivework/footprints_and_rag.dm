//R505 Edit - moved to /reagent_containers/rag.dm
/*
/obj/item/reagent_containers/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_flags = NOBLUDGEON
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 5
	spillable = FALSE
	var/wipe_sound
	var/soak_efficiency = 1
	var/extinguish_efficiency = 0
	var/action_speed = 3 SECONDS
	var/damp_threshold = 0.5

/obj/item/reagent_containers/rag/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is smothering [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (OXYLOSS)

//R505 Edit
/obj/item/reagent_containers/rag/examine(mob/user)
	. = ..()
	if(reagents.total_volume)
		. += "<span class='notice'>Alt-Click to squeeze the liquids out of it.</span>"

/obj/item/reagent_containers/rag/pre_altattackby(mob/living/M, mob/living/user, params)
	if(istype(M) && user.combat_mode == 0)
		user.changeNext_move(CLICK_CD_MELEE)
		if(M.on_fire)
			user.visible_message("<span class='warning'>\The [user] uses \the [src] to pat out [M == user ? "[user.p_their()]" : "\the [M]'s"] flames!</span>")
			if(hitsound)
				playsound(M, hitsound, 25, 1)
			M.adjust_fire_stacks(-min(extinguish_efficiency, M.fire_stacks))
		else
			if(reagents.total_volume > (volume * damp_threshold))
				to_chat(user, "<span class='warning'>\The [src] is too drenched to be used to dry [user == M ? "yourself" : "\the [M]"] off.</span>")
				return TRUE
			user.visible_message("<span class='notice'>\The [user] starts drying [M == user ? "[user.p_them()]self" : "\the [M]"] off with \the [src]...</span>")
			if(do_mob(user, M, action_speed))
				if(reagents.total_volume > (volume * damp_threshold))
					return
				user.visible_message("<span class='notice'>\The [user] dries [M == user ? "[user.p_them()]self" : "\the [M]"] off with \the [src].</span>")
				if(wipe_sound)
					playsound(M, wipe_sound, 25, 1)
				if(M.fire_stacks)
					var/minus_plus = M.fire_stacks < 0 ? 1 : -1
					var/amount = min(abs(M.fire_stacks), soak_efficiency)
					var/r_id = /datum/reagent/fuel
					if(M.fire_stacks < 0)
						r_id = /datum/reagent/water
					reagents.add_reagent(r_id, amount * 0.3)
					M.adjust_fire_stacks(minus_plus * amount)

				// M.wash_cream() I dont think we have this stuff yet
				// M.wash_cum() I dont think we have this stuff yet
		return TRUE
	return ..()

/obj/item/reagent_containers/rag/AltClick(mob/user)
	. = ..()
	if(reagents.total_volume && user.canUseTopic(src, BE_CLOSE))
		to_chat(user, "<span class='notice'>You start squeezing the liquids out of \the [src]...</span>")
		if(do_after(user, action_speed, TRUE, src))
			var/msg = "You squeeze \the [src]"
			var/obj/item/target
			if(Adjacent(user)) //Allows the user to drain the reagents into a beaker if adjacent (no telepathy).
				for(var/obj/item/I in user.held_items)
					if(I == src)
						continue
					if(I.is_open_container() && !I.reagents.holder_full())
						target = I
						break
			if(!target)
				msg += " dry"
				reagents.expose(get_turf(src), TOUCH)
				reagents.clear_reagents()
			else
				msg += "'s liquids into \the [target]"
				reagents.trans_to(target, reagents.total_volume)
			to_chat(user, "<span class='notice'>[msg].</span>")
		return TRUE
//R505 Edit - End

/obj/item/reagent_containers/rag/afterattack(atom/A as obj|turf|area, mob/living/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(iscarbon(A) && reagents?.total_volume)
		var/mob/living/carbon/C = A
		var/reagentlist = pretty_string_from_reagent_list(reagents)
		var/log_object = "containing [reagentlist]"
		if(user.combat_mode && !C.is_mouth_covered())
			reagents.trans_to(C, reagents.total_volume, transfered_by = user, methods = INGEST)
			C.visible_message(span_danger("[user] smothers \the [C] with \the [src]!"), span_userdanger("[user] smothers you with \the [src]!"), span_hear("You hear some struggling and muffled cries of surprise."))
			log_combat(user, C, "smothered", src, log_object)
		else
			reagents.expose(C, TOUCH)
			reagents.clear_reagents()
			C.visible_message(span_notice("[user] touches \the [C] with \the [src]."))
			log_combat(user, C, "touched", src, log_object)

	else if(istype(A) && (src in user))
		user.visible_message(span_notice("[user] starts to wipe down [A] with [src]!"), span_notice("You start to wipe down [A] with [src]..."))
		if(do_after(user,30, target = A))
			user.visible_message(span_notice("[user] finishes wiping off [A]!"), span_notice("You finish wiping off [A]."))
			A.wash(CLEAN_SCRUB)
*/
