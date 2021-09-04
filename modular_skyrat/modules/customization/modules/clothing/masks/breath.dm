/obj/item/clothing/mask/breath/vox
	desc = "A close-fitting mask that can be connected to an air supply. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	name = "vox breath mask"
	actions_types = list()
	flags_cover = NONE

/obj/item/clothing/mask/gas/glass
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	name = "glass gas mask"
	desc = "A face-covering mask that can be connected to an air supply. This one doesn't obscure your face however."
	icon_state = "gas_clear"
	flags_inv = HIDEEYES

/obj/item/clothing/mask/gas/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	icon_state = "gas_alt2"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'

/obj/item/clothing/mask/balaclavaadjust
	name = "adjustable balaclava"
	desc = "Wider eyed and made of an elastic based material, this one seems like it can contort more."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	w_class = WEIGHT_CLASS_SMALL
	var/open = 0 //0 = full, 1 = head only, 2 = face only

/obj/item/clothing/mask/balaclavaadjust/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated())
		switch(open)
			if (0)
				flags_inv = HIDEHAIR
				icon_state = initial(icon_state) + "_open"
				to_chat(user, "You put the balaclava away, revealing your face.")
				open = 1
			if (1)
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
				icon_state = initial(icon_state) + "_mouth"
				to_chat(user, "You adjust the balaclava up to cover your mouth.")
				open = 2
			else
				flags_inv = HIDEFACE|HIDEHAIR
				icon_state = initial(icon_state)
				to_chat(user, "You pull the balaclava up to cover your whole head.")
				open = 0
		user.update_hair(0)
		user.update_inv_ears(0)
		user.update_inv_wear_mask() //Updates mob icons

/obj/item/clothing/mask/balaclavaadjust/attack_self(mob/user)
	adjust_mask(user)

/obj/item/clothing/mask/balaclavaadjust/verb/toggle()
		set category = "Object"
		set name = "Adjust Balaclava"
		set src in usr
		adjust_mask(usr)



/obj/item/clothing/mask/bandana/red/ft
	name = "skin tight red bandana"
	desc = "A fine red bandana with nanotech lining."
	flags_cover = NONE
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = PEPPERPROOF

/obj/item/clothing/mask/bandana/blue/ft
	name = "skin tight blue bandana"
	desc = "A fine blue bandana with nanotech lining."
	flags_cover = NONE
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = PEPPERPROOF

/obj/item/clothing/mask/bandana/green/ft
	name = "skin tight green bandana"
	desc = "A fine green bandana with nanotech lining."
	flags_cover = NONE
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = PEPPERPROOF

/obj/item/clothing/mask/bandana/gold/ft
	name = "skin tight gold bandana"
	desc = "A fine gold bandana with nanotech lining."
	flags_cover = NONE
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = PEPPERPROOF

/obj/item/clothing/mask/bandana/black/ft
	name = "skin tight black bandana"
	desc = "A fine black bandana with nanotech lining."
	flags_cover = NONE
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = PEPPERPROOF

/obj/item/clothing/mask/bandana/skull/ft
	name = "skin tight skull bandana"
	desc = "A fine black bandana with nanotech lining and a skull emblem."
	flags_cover = NONE
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = PEPPERPROOF

/obj/item/clothing/mask/balaclava/threehole
	name = "three hole balaclava"
	desc = "Tiocfaidh ar la."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclavam"
	inhand_icon_state = "balaclava"

/obj/item/clothing/mask/balaclava/threehole/green
	name = "three hole green balaclava"
	desc = "Tiocfaidh ar la."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "swatclavam"
	inhand_icon_state = "balaclava"



/obj/item/clothing/mask/gas/german
	name = "black gas mask"
	desc = "A black gas mask. Are you my Mummy?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "m38_mask"

/obj/item/clothing/mask/gas/hecu1
	name = "modern gas mask"
	desc = "MY. ASS. IS. HEAVY."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu"

/obj/item/clothing/mask/gas/hecu2
	name = "modern gas mask"
	desc = "MY. ASS. IS. HEAVY."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu2"

/obj/item/clothing/mask/gas/soviet
	name = "soviet gas mask"
	desc = "A white gas mask with a green filter, there's a small sticker attached saying it's not got Asbestos anymore."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "gp5_mask"

/obj/item/clothing/mask/muzzle/ball
	name = "ballgag"
	desc = "I'm pretty fuckin far from okay."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ballgag"

/obj/item/clothing/mask/muzzle/ring
	name = "ring gag"
	desc = "A mouth wrap seemingly designed to hold the mouth open."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ringgag"


/obj/item/clothing/mask/gas/polyclown
	name = "polychromaic clown mask"
	desc = "The face of pure evil, now multicoloured."
	clothing_flags = MASKINTERNALS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "polyclown"
	inhand_icon_state = "clown_hat"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	species_exception = list(/datum/species/golem/bananium)
	var/is_polychromic = TRUE
	var/poly_colors = list("0BB", "FC0", "FFF")

/obj/item/clothing/mask/gas/polyclown/ComponentInitialize()
	. = ..()
	if(is_polychromic)
		AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/mask/gas/clownbald
	name = "bald clown mask"
	desc = "HE'S BALD, HE'S FUCKIN' BALDIN!"
	clothing_flags = MASKINTERNALS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "baldclown"
	inhand_icon_state = "clown_hat"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	species_exception = list(/datum/species/golem/bananium)

