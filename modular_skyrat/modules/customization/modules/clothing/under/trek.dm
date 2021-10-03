//More trek clothing
/obj/item/clothing/under/trek/modular_skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'

//VOY
/obj/item/clothing/under/trek/modular_skyrat/command/voy
	desc = "The uniform worn by command officers of the 2370s."
	icon_state = "trek_voy_command"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/trek/modular_skyrat/engsec/voy
	desc = "The uniform worn by operations officers of the 2370s."
	icon_state = "trek_voy_engsec"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/trek/modular_skyrat/medsci/voy
	desc = "The uniform worn by medsci officers of the 2370s."
	icon_state = "trek_voy_medsci"
	inhand_icon_state = "b_suit"

//DS9
/obj/item/clothing/under/trek/modular_skyrat/command/ds9
	desc = "The uniform worn by command officers of the 2380s."
	icon_state = "trek_ds9_command"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/trek/modular_skyrat/engsec/ds9
	desc = "The uniform worn by operations officers of the 2380s."
	icon_state = "trek_ds9_engsec"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/trek/modular_skyrat/medsci/ds9
	desc = "The uniform undershirt worn by medsci officers of the 2380s."
	icon_state = "trek_ds9_medsci"
	inhand_icon_state = "b_suit"

// Orville-inspired clothing with TOS-like color code+SS13 gray and green service color code
/obj/item/clothing/under/trek/modular_skyrat/orv
	name = "ordinary crewmember uniform"
	desc = "An uniform worn by ordinary crewmembers."
	icon_state = "orv_adj"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/trek/modular_skyrat/orv/service
	name = "able crewmember uniform"
	desc = "An uniform worn by able crewmembers."
	icon_state = "orv_srv"
	inhand_icon_state = "g_suit"

/obj/item/clothing/under/trek/modular_skyrat/command/orv
	desc = "An uniform worn by commanding officers of the 2550s."
	icon_state = "orv_com"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/trek/modular_skyrat/engsec/orv
	desc = "An uniform worn by operations officers of the 2550s."
	icon_state = "orv_ops"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/trek/modular_skyrat/medsci/orv
	desc = "An uniform worn by medsci officers of the 2550s."
	icon_state = "orv_medsci"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/trek/modular_skyrat/command/orv/captain
	name = "captain uniform"
	desc = "An uniform worn by captains of the 2550s."
	icon_state = "orv_com_capt"

/obj/item/clothing/under/trek/modular_skyrat/command/orv/engsec
	name = "operations command uniform"
	desc = "An uniform worn by commanding officers of operations."
	icon_state = "orv_com_ops"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0) //copies normal engsec values
	strip_delay = 50

/obj/item/clothing/under/trek/modular_skyrat/command/orv/medsci
	name = "medsci command uniform"
	desc = "An uniform worn by commanding officers of medical/science."
	icon_state = "orv_com_medsci"
