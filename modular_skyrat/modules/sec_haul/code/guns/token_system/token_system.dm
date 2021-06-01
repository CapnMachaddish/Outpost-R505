
//////////////////
//TOKEN SYSTEM
/////////////////

/obj/machinery/gun_vendor
	name = "Armadyne Weapons Dispensary"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "gunvend"
	use_power = NO_POWER_USE
	max_integrity = 2000
	density = TRUE

/obj/machinery/gun_vendor/attacked_by(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/armament_token))
		RedeemToken(I, user)
		return

/obj/machinery/gun_vendor/proc/RedeemToken(obj/item/armament_token/token, mob/redeemer)
	if(seclevel2num(get_security_level()) < token.minimum_sec_level)
		to_chat(redeemer, "<span class='redtext'>Warning, this holochip is locked to [num2seclevel(token.minimum_sec_level)]!</span>")
		message_admins("ARMAMENT LOG: [redeemer] attempted to redeem a [token.name] on the incorrect security level!")
		return
	var/list/radial_build = token.get_available_gunsets()
	seclevel2num()
	var/obj/item/storage/box/gunset/chosen_gunset = show_radial_menu(redeemer, src, radial_build, radius = 40)
	if(!chosen_gunset)
		return
	if(!redeemer.Adjacent(src))
		return
	if(QDELETED(token))
		return
	var/obj/item/storage/box/gunset/dispensed = new chosen_gunset(src.loc)

	if(redeemer.CanReach(src) && redeemer.put_in_hands(dispensed))
		to_chat(redeemer, "<span class='notice'>You take [dispensed] out of the slot.</span>")
	else
		to_chat(redeemer, "<span class='warning'>[dispensed] falls onto the floor!</span>")
	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	to_chat(redeemer, "Thank you for redeeming your token. Remember. Do NOT take lethal ammo without permission or good reasoning.")
	SSblackbox.record_feedback("tally", "armament_token_redeemed", 1, dispensed)
	qdel(token)

////////////////////
//TOKENS
////////////////////

/obj/item/armament_token
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "token_sidearm"
	w_class = WEIGHT_CLASS_TINY
	var/minimum_sec_level = SEC_LEVEL_GREEN

/obj/item/armament_token/proc/get_available_gunsets()
	return FALSE

//Sidearm
/obj/item/armament_token/sidearm
	name = "sidearm armament holochip"
	desc = "A holochip used in any armament vendor, this is for sidearms. Do not bend."
	icon_state = "token_sidearm"

/obj/item/armament_token/sidearm/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/pdh_peacekeeper= image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "pdh_peacekeeper"
		),
	/obj/item/storage/box/gunset/glock17 = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "g17"
		),
	/obj/item/storage/box/gunset/ladon = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "ladon"
		),
	/obj/item/storage/box/gunset/dozer = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "dozer"
		),
	/obj/item/storage/box/gunset/zeta = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "zeta"
		),
	/obj/item/storage/box/gunset/revolution = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "revolution"
	)
	)

//BAD BOY!
/obj/item/armament_token/sidearm_blackmarket
	name = "blackmarket armament holochip"
	desc = "A holochip used in any armament vendor, this is for |bad people|. Do not bend."
	icon_state = "token_blackmarket"
	custom_premium_price = PAYCHECK_HARD * 3

/obj/item/armament_token/sidearm_blackmarket/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/mk58 = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "mk58"
		),
	/obj/item/storage/box/gunset/croon = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "croon"
		),
	/obj/item/storage/box/gunset/makarov = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "makarov"
		)
	)


//Primary
/obj/item/armament_token/primary
	name = "primary armament holochip"
	desc = "A holochip used in any armament vendor, this is for main arms. Do not bend."
	icon_state = "token_primary"
	minimum_sec_level = SEC_LEVEL_RED

/obj/item/armament_token/primary/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/pcr = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "pcr"
		),
	/obj/item/storage/box/gunset/ostwind = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "ostwind"
		),
	/obj/item/storage/box/gunset/vintorez = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "vintorez"
		),
		/obj/item/storage/box/gunset/pitbull = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "pitbull"
		)
	)

//BAD BOY!
/obj/item/armament_token/energy
	name = "energy armament holochip"
	desc = "A holochip used in any armament vendor, this is for energy weapons. Do not bend."
	icon_state = "token_energy"
	custom_premium_price = PAYCHECK_HARD * 3
	minimum_sec_level = SEC_LEVEL_RED

/obj/item/armament_token/energy/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/laser = image(
		icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi',
		icon_state = "laser"
		)
	)

/obj/item/storage/box/armament_tokens_sidearm
	name = "security sidearm tokens"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	desc = "A box full of sidearm armament tokens!"
	icon_state = "armadyne_sidearm"
	illustration = null

/obj/item/storage/box/armament_tokens_sidearm/PopulateContents()
	. = ..()
	new /obj/item/armament_token/sidearm(src)
	new /obj/item/armament_token/sidearm(src)
	new /obj/item/armament_token/sidearm(src)

/obj/item/storage/box/armament_tokens_primary
	name = "security primary tokens"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "armadyne_primary"
	desc = "A box full of primary armament tokens!"
	illustration = null

/obj/item/storage/box/armament_tokens_primary/PopulateContents()
	. = ..()
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)

/obj/item/storage/box/armament_tokens_energy
	name = "security energy tokens"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "armadyne_energy"
	desc = "A box full of energy armament tokens!"
	illustration = null

/obj/item/storage/box/armament_tokens_energy/PopulateContents()
	. = ..()
	new /obj/item/armament_token/energy(src)
	new /obj/item/armament_token/energy(src)
	new /obj/item/armament_token/energy(src)
