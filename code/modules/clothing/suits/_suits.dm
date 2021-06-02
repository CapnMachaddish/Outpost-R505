/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	slot_flags = ITEM_SLOT_OCLOTHING
	var/blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	limb_integrity = 0 // disabled for most exo-suits


///obj/item/clothing/suit/worn_overlays(isinhands = FALSE) //ORIGINAL
/obj/item/clothing/suit/worn_overlays(isinhands = FALSE, file2use, mutant_styles = NONE)
	. = list()
	if(!isinhands)
		if(damaged_clothes)
			//SKYRAT EDIT CHANGE BEGIN
			//. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]") //ORIGINAL
			var/damagefile2use = (mutant_styles & STYLE_TAUR_ALL) ? 'modular_skyrat/master_files/icons/mob/64x32_item_damage.dmi' : 'icons/effects/item_damage.dmi'
			. += mutable_appearance(damagefile2use, "damaged[blood_overlay_type]")
			//SKYRAT EDIT CHANGE END
		if(HAS_BLOOD_DNA(src))
			//SKYRAT EDIT CHANGE BEGIN
			//. += mutable_appearance('icons/effects/blood.dmi', "[blood_overlay_type]blood") //ORIGINAL
			var/bloodfile2use = (mutant_styles & STYLE_TAUR_ALL) ? 'modular_skyrat/master_files/icons/mob/64x32_blood.dmi' : 'icons/effects/blood.dmi'
			. += mutable_appearance(bloodfile2use, "[blood_overlay_type]blood")
			//SKYRAT EDIT CHANGE END
		var/mob/living/carbon/human/M = loc
		if(ishuman(M) && M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			if(istype(U) && U.attached_accessory)
				var/obj/item/clothing/accessory/A = U.attached_accessory
				if(A.above_suit)
					. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()
