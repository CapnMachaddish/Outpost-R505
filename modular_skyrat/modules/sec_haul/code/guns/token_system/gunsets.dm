///////////////
//GUNSET BOXES
//////////////

/obj/item/storage/box/gunset
	name = "gun supply box"
	desc = "An Armadyne weapons supply box."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "box"
	var/box_state = "box"
	var/opened = FALSE
	inhand_icon_state = "sec-case"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_BULKY
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'
	foldable = FALSE
	illustration = null

/obj/item/storage/box/gunset/PopulateContents()
	. = ..()
	new /obj/item/storage/bag/ammo(src)
	new /obj/item/gun_maintenance_supplies(src)

/obj/item/storage/box/gunset/update_icon()
	. = ..()
	if(opened)
		icon_state = "[box_state]-open"
	else
		icon_state = box_state

/obj/item/storage/box/gunset/AltClick(mob/user)
	. = ..()
	opened = TRUE
	update_icon()


/obj/item/storage/box/gunset/attack_self(mob/user)
	. = ..()
	opened = TRUE
	update_icon()

///////////////////
//GUN SETS
//////////////////


/////////////////
//SIDEARM TOKEN GUNSETS
////////////////

//G-17
/obj/item/storage/box/gunset/glock17
	name = "glock-17 supply box"

/obj/item/gun/ballistic/automatic/pistol/g17/nomag
	spawnwithmagazine = FALSE


/obj/item/storage/box/gunset/glock17/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g17/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/g17/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)

//LADON
/obj/item/storage/box/gunset/ladon
	name = "p-3 ladon supply box"

/obj/item/gun/ballistic/automatic/pistol/ladon/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/ladon/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/ladon/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon(src)

//DOZER
/obj/item/storage/box/gunset/dozer
	name = "dozer supply box"

/obj/item/gun/ballistic/automatic/dozer/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/dozer/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/dozer/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/dozer/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer(src)

//PDH
/obj/item/storage/box/gunset/pdh_peacekeeper
	name = "9x19mm handgun supply box"
	desc = "Ideally contains a fast-firing 9x19mm Pistol."

/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_peacekeeper/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)

// MK-58
/obj/item/storage/box/gunset/mk58
	name = "mk-58 supply box"

/obj/item/gun/ballistic/automatic/pistol/mk58/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/mk58/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/mk58/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/mk58/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58(src)

//CROON
/obj/item/storage/box/gunset/croon
	name = "weathered supply box"
	desc = "Ideally contains a cheap 6mm SMG."

/obj/item/gun/ballistic/automatic/croon/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/croon/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/croon/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/croon/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon(src)

//MAKAROV
/obj/item/storage/box/gunset/makarov
	name = "makarov supply box"

/obj/item/gun/ballistic/automatic/pistol/makarov/nomag //R505 Edit
	spawnwithmagazine = FALSE

/obj/item/ammo_box/magazine/multi_sprite/makarov/empty
	start_empty = TRUE

/obj/item/storage/box/gunset/makarov/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/makarov/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/makarov/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)

//ZETA
/obj/item/storage/box/gunset/zeta
	name = "10mm Auto revolver supply box"
	desc = "Ideally contains a slow-firing revolver that packs a punch."

/obj/item/storage/box/gunset/zeta/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/zeta(src)
	new /obj/item/ammo_box/revolver/zeta(src) //These start empty.
	new /obj/item/ammo_box/revolver/zeta(src)
	new /obj/item/ammo_box/revolver/zeta(src)
	new /obj/item/ammo_box/advanced/b10mm(src)

//REVOLUTION
/obj/item/storage/box/gunset/revolution
	name = "revolution supply box"

/obj/item/storage/box/gunset/revolution/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/revolution(src)
	new /obj/item/ammo_box/revolver/revolution(src)
	new /obj/item/ammo_box/revolver/revolution(src)
	new /obj/item/ammo_box/revolver/revolution(src)
	new /obj/item/ammo_box/advanced/b9mm(src)

/////////////////
//PRIMARY TOKEN GUNSETS
////////////////

///////PCR-9
/obj/item/storage/box/gunset/pcr
	name = "9mm SMG supply box"
	desc = "Ideally contains a 9x19mm SMG with decent firerate."

/obj/item/gun/ballistic/automatic/pcr/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pcr/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pcr/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/pcr/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)

////M112

/obj/item/storage/box/gunset/norwind
	name = "12.7x30mm DMR supply box."
	desc = "Ideally contains an unwieldy rifle that hits like a truck."

/obj/item/gun/ballistic/automatic/norwind/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/norwind/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/norwind/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/norwind/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)

//////DTR-6

/obj/item/storage/box/gunset/ostwind
	name = "6mm SPR box."
	desc = "Ideally contains an all-around balanced special purpose rifle."

/obj/item/gun/ballistic/automatic/ostwind/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/ostwind/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/ostwind/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind(src)

////////PITBULL

/obj/item/storage/box/gunset/pitbull
	name = "10mm PDW supply box"
	desc = "Ideally contains a slow-firing 10mm Auto PDW that packs a punch."

/obj/item/gun/ballistic/automatic/pitbull/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pitbull/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pitbull/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull(src)

/////////////////
//JOB SPECIFIC GUNSETS
////////////////

//CAPTAIN
/obj/item/storage/box/gunset/pdh_captain
	name = "pdh 'socom' supply box"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_captain/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)

//HOS
/obj/item/storage/box/gunset/glock18_hos
	name = "glock-18 supply box"
	desc = "Ideally contains a fast-firing 9x19mm Pistol made out of cheap plastic."
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/g18/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/glock18_hos/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g18/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/g18/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18(src)

//HOP
/obj/item/storage/box/gunset/pdh_hop
	name = "pdh 'osprey' supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/pdh/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_hop/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)

//CORPO
/obj/item/storage/box/gunset/pdh_corpo
	name = "pdh 'corporate' supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/pdh/corpo/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_corpo/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/corpo/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)

//////KRAUT SPACE MAGIC!
/obj/item/storage/box/gunset/g11
	name = "g11 supply box"

/obj/item/gun/ballistic/automatic/g11/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/g11/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/g11/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g11(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g11(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g11(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g11(src)

//SECURITY MEDIC
/obj/item/storage/box/gunset/security_medic
	name = "9x19mm special pistol supply box"
	desc = "Ideally contains a special 9x19mm Pistol."
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/firefly/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/security_medic/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/firefly/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/firefly/rubber(src) //R505 Edit - rubbers
	new /obj/item/ammo_box/magazine/multi_sprite/firefly/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/firefly/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/firefly(src)

//LASER
/obj/item/storage/box/gunset/laser
	name = "laser gun supply box"

/obj/item/storage/box/gunset/laser/PopulateContents()
	. = ..()
	new /obj/item/gun/energy/laser(src)

/obj/item/storage/box/gunset/e_gun

/obj/item/storage/box/gunset/e_gun/PopulateContents()
	. = ..()
	new /obj/item/gun/energy/e_gun(src)

//PEPPERBALLS
/obj/item/storage/box/gunset/pepperball
	name = "pepperball supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/pepperball/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pepperball/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pepperball/nomag(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/ammo_box/magazine/pepperball(src)
	new /obj/item/ammo_box/magazine/pepperball(src)


//Sergeants!//

/obj/item/storage/box/gunset/sarge
	name = "sergeant supply box"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gunset/sarge/PopulateContents()
	new /obj/item/trim_token/security_sergeant(src)
	new /obj/item/melee/classic_baton/telescopic(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/sergeant(src)
	new /obj/item/clothing/head/sec/peacekeeper/sergeant(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/megaphone/sec(src)
	// . = ..()

/////////////////
//SHOTGUN GUNSETS
////////////////
/obj/item/storage/box/gunset/m23
	name = "m23 supply box"

/obj/item/storage/box/gunset/m23/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/shotgun/m23(src)
	new /obj/item/storage/box/beanbag(src)
	new /obj/item/storage/box/beanbag(src)
	new /obj/item/storage/box/beanbag(src)

/obj/item/storage/box/gunset/as2
	name = "as2 supply box"

/obj/item/storage/box/gunset/as2/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/shotgun/automatic/as2(src)
	new /obj/item/storage/box/beanbag(src)
	new /obj/item/storage/box/beanbag(src)
	new /obj/item/storage/box/beanbag(src)
