/obj/item/clothing/under/misc/durathreadskirt
	name = "durathread jumpskirt"
	desc = "A jumpskirt made from durathread, its resilient fibres provide some protection to the wearer."
	icon = 'modular_R505/icons/obj/clothing/duraskirt.dmi'
	icon_state = "durathreadskirt"
	can_adjust = FALSE
	armor = list(MELEE = 10, LASER = 10, FIRE = 40, ACID = 10, BOMB = 5)
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/suit/cygvest
	name = "marauder vest"
	desc = "A worn, open leather vest with attached metal pauldrons. Smells of gunpowder and phoron."
	icon = 'modular_R505/icons/obj/clothing/guncaster.dmi'
	icon_state = "gcvest"
	resistance_flags = NONE
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/gun/ballistic/revolver/detective, /obj/item/radio)

/obj/item/clothing/suit/cygvest/tj
	name = "TJ's vest"
	desc = "The trademark vest and pauldrons of a certain gunslinging Krell."
	icon_state = "gcvest_alt"
