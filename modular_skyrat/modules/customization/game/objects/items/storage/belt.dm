/*
* Messenger belt bag
*/

/obj/item/storage/belt/mailbelt
	name = "Messenger Belt Bag"
	desc = "A small bag with a belt, worn around the waist. It's just big enough to hold a small stack of letters. This one is postal blue, perfect for standing out!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt"
	inhand_icon_state = "mailbelt"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "mailbelt"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/item/storage/belt/mailbelt/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 14
	STR.display_numerical_stacking = TRUE
	STR.set_holdable(list(
		/obj/item/mail,
		/obj/item/mail/envelope,
		/obj/item/paper
	))

/obj/item/storage/belt/mailbelt/white
	name = "White Belt Bag"
	desc = "A small bag with a belt, worn around the waist. It's just big enough to hold a small stack of letters. This one is a pearly white."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt_white"
	inhand_icon_state = "mailbelt_white"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "mailbelt_white"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/item/storage/belt/mailbelt/leather
	name = "Leather Belt Bag"
	desc = "A small bag with a belt, worn around the waist. It's just big enough to hold a small stack of letters. This one is made out of a synthetic leather blend."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt_leather"
	inhand_icon_state = "mailbelt_leather"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "mailbelt_leather"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
