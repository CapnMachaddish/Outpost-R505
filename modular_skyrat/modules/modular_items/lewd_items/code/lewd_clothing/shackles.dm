/obj/item/clothing/suit/straight_jacket/shackles
	name = "shackles"
	desc = "Fancy shackles with a fake lock."
	inhand_icon_state = "shackles"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	icon_state = "shackles"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	body_parts_covered = null//they don't cover anything, but these code parts need to be here, because if they are not here - they make clothing disappear. Magic.
	flags_inv = null
	equip_delay_self = NONE
	strip_delay = 120
	breakouttime = 10
	slowdown = 1
	var/current_color = "metal" //yes, metal color. Don't ask.
	var/color_changed = FALSE
	var/static/list/shackles_designs

//////////////////////////////////////
//here goes code for changing model.//
//////////////////////////////////////

//create radial menu
/obj/item/clothing/suit/straight_jacket/shackles/proc/populate_shackles_designs()
	shackles_designs = list(
		"pink" = image (icon = src.icon, icon_state = "shackles_pink"),
		"teal" = image (icon = src.icon, icon_state = "shackles_teal"),
		"metal" = image (icon = src.icon, icon_state = "shackles_metal"))

//to update model lol
/obj/item/clothing/suit/straight_jacket/shackles/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/suit/straight_jacket/shackles/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, shackles_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change shackles' model
/obj/item/clothing/suit/straight_jacket/shackles/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/suit/straight_jacket/shackles/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(shackles_designs))
		populate_shackles_designs()

/obj/item/clothing/suit/straight_jacket/shackles/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

//message when equipping that thing
/obj/item/clothing/suit/straight_jacket/shackles/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/C = user
	if(src == C.wear_suit)
		to_chat(user, span_purple("The shackles are restraining your body, though the lock appears to be made of... Plastic?"))
	else
		return

//message when unequipping that thing
/obj/item/clothing/suit/straight_jacket/shackles/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/human/C = user
	if(src == C.wear_suit)
		to_chat(user, span_purple("The shackles are no longer restraining your body. It wasn't too hard, huh?"))

//reinforcing normal version by using handcuffs on it.
/obj/item/clothing/suit/straight_jacket/shackles/attackby(obj/item/I, mob/user, params) //That part allows reinforcing this item with normal straightjacket
    if(istype(I, /obj/item/restraints/handcuffs))
        var/obj/item/clothing/suit/straight_jacket/shackles/reinforced/W = new /obj/item/clothing/suit/straight_jacket/shackles/reinforced
        remove_item_from_storage(user)
        user.put_in_hands(W)
        to_chat(user, span_notice("You reinforced the locks on [src] with [I]."))
        qdel(I)
        qdel(src)
        return
    . = ..()

//reinforced version.
/obj/item/clothing/suit/straight_jacket/shackles/reinforced
	name = "reinforced shackles"
	desc = "Fancy shackles, but with a suspiciously sturdy lock..."
	icon_state = "shackles"
	inhand_icon_state = "shackles"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	clothing_flags = DANGEROUS_OBJECT
	equip_delay_self = 100
	strip_delay = 120
	breakouttime = 1800 //better than handcuffs, but not better than straightjacket. Please, do not change this var.
	slowdown = 2

//message when equipping that thing
/obj/item/clothing/suit/straight_jacket/shackles/reinforced/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/C = user
	if(src == C.wear_suit)
		to_chat(user, span_purple("The shackles are restraining your body!"))
	else
		return

//message when unequipping that thing
/obj/item/clothing/suit/straight_jacket/shackles/reinforced/dropped(mob/user)
	var/mob/living/carbon/human/C = user
	. = ..()
	if(src == C.wear_suit)
		to_chat(user, span_purple("The shackles are no longer restraining your body. You are free!"))
