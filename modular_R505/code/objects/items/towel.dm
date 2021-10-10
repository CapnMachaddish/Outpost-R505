/obj/item/reagent_containers/rag/towel
	name = "towel"
	desc = "A soft cotton towel."
	icon = 'modular_R505/icons/obj/towel.dmi'
	lefthand_file = 'modular_R505/icons/obj/items_lefthand.dmi'
	righthand_file = 'modular_R505/icons/obj/items_righthand.dmi'
	icon_state = "towel"
	//slot_flags = ITEM_SLOT_OCLOTHING
	//body_parts_covered = CHEST|GROIN|LEGS
	item_flags = NOBLUDGEON
	force = 1
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = "whips"
	attack_verb_simple = "whip"
	hitsound = 'modular_R505/sound/pool/towel/towelwhip.ogg'
	volume = 10
	wipe_sound = 'modular_R505/sound/pool/towel/towelwipe.ogg'
	soak_efficiency = 4
	extinguish_efficiency = 3
	//var/flat_icon = "towel_flat" part of below TODO
	//var/folded_icon = "towel"
	var/list/possible_colors

/obj/item/reagent_containers/rag/towel/Initialize()
	. = ..()
	if(possible_colors)
		add_atom_colour(pick(possible_colors), FIXED_COLOUR_PRIORITY)
/* TODO
/obj/item/reagent_containers/rag/towel/dropped(mob/user)
	. = ..()
	body_parts_covered = NONE
	flags_inv = NONE
*/

/*
/obj/item/reagent_containers/rag/towel/attack_self(mob/user)
	if(!user.CanReach(src) || !user.dropItemToGround(src))
		return
	to_chat(user, "<span class='notice'>You lay out \the [src] flat on the ground.</span>")
	icon_state = flat_icon
	layer = BELOW_OBJ_LAYER

/obj/item/reagent_containers/rag/towel/pickup(mob/living/user)
	. = ..()
	icon_state = folded_icon
	layer = initial(layer)
*/
/obj/item/reagent_containers/rag/towel/random
	possible_colors = list("#FF0000","#FF7F00","#FFFF00","#00FF00","#0000FF","#4B0082","#8F00FF")

/obj/item/reagent_containers/rag/towel/syndicate
	name = "syndicate towel"
	desc = "Truly a weapon of mass destruction."
	possible_colors = list("#DD1A1A", "#DB4325", "#E02700")
	force = 4
	armour_penetration = 10
	volume = 20
	soak_efficiency = 6
	extinguish_efficiency = 5
	action_speed = 15
	damp_threshold = 0.8
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 50, "acid" = 50) //items don't provide armor to wearers unlike clothing yet.
