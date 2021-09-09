/obj/machinery/vending/security_peacekeeper
	name = "\improper Armadyne Peacekeeper Equipment Vendor"
	desc = "An Armadyne peacekeeper equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon = 'modular_skyrat/modules/sec_haul/icons/vending/vending.dmi'
	icon_state = "sec"
	icon_deny = "sec-deny"
	light_mask = "sec-light-mask"
	req_access = list(ACCESS_SECURITY)
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 10,
		/obj/item/grenade/flashbang = 4,
		/obj/item/assembly/flash/handheld = 5,
		/obj/item/food/donut = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 4,
    	/obj/item/gun_maintenance_supplies = 40,
		/obj/item/taperoll/police = 4
	)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/fancy/donut_box = 2,
		/obj/item/armament_token/sidearm_blackmarket = 2
	)
	premium = list(
		/obj/item/storage/belt/security/webbing/peacekeeper = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt = 1,
		/obj/item/grenade/stingbang = 1
	)
	refill_canister = /obj/item/vending_refill/security_peacekeeper
	default_price = PAYCHECK_MEDIUM
	extra_price = PAYCHECK_HARD * 1.5
	payment_department = ACCOUNT_SEC

/obj/machinery/vending/security_peacekeeper/pre_throw(obj/item/I)
	if(istype(I, /obj/item/grenade))
		var/obj/item/grenade/G = I
		G.arm_grenade()
	else if(istype(I, /obj/item/flashlight))
		var/obj/item/flashlight/F = I
		F.on = TRUE
		F.update_brightness()

/obj/item/vending_refill/security_peacekeeper
	icon_state = "refill_sec"

/obj/machinery/vending/wardrobe/peacekeeper_wardrobe
	name = "\improper Peacekeeper Outfitting Station"
	desc = "A vending machine for standard peacekeeper outfits."
	icon_state = "secdrobe"
	product_ads = "Beat perps in style!;It's red so you can't see the blood!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	vend_reply = "Thank you for using the SecDrobe!"
	products = list(
		/obj/item/clothing/suit/hooded/wintercoat/security/peacekeeper = 4,
		/obj/item/storage/backpack/security/peacekeeper = 3,
		/obj/item/storage/backpack/satchel/sec/peacekeeper = 3,
		/obj/item/storage/backpack/duffelbag/sec/peacekeeper = 3,
		/obj/item/clothing/under/rank/security/peacekeeper = 3,
		/obj/item/clothing/under/rank/security/peacekeeper/blue = 3,
		/obj/item/clothing/under/rank/security/peacekeeper/tactical = 3,
		/obj/item/clothing/under/rank/security/peacekeeper/junior/sol = 2,
		/obj/item/clothing/under/rank/security/peacekeeper/junior/sol/traffic = 2,
		/obj/item/clothing/under/rank/security/peacekeeper/sol = 7,
		/obj/item/clothing/shoes/combat/peacekeeper = 3,
		/obj/item/clothing/head/beret/sec/peacekeeper = 3,
		/obj/item/clothing/head/soft/sec = 3,
		/obj/item/clothing/head/sec/peacekeeper/sol = 3,
		/obj/item/clothing/head/soltraffic = 3,
		/obj/item/clothing/mask/bandana/black = 3,
		/obj/item/clothing/gloves/combat/peacekeeper = 3,
		/obj/item/clothing/suit/toggle/brit/sec = 7,
		/obj/item/clothing/under/pants/khaki = 3,
		/obj/item/clothing/under/rank/security/officer/blueshirt = 3,
		/obj/item/clothing/under/rank/security/peacekeeper/trousers = 3,
		/obj/item/clothing/under/rank/security/peacekeeper/trousers/red = 3,
		/obj/item/clothing/suit/armor/vest/peacekeeper/spacecoat = 4,
		/obj/item/clothing/head/ushankasec = 5,
		/obj/item/clothing/head/ushankasec/blue = 5
	)
	contraband = list(
		/obj/item/clothing/suit/armor/stormtrooper = 1,
		/obj/item/clothing/head/helmet/stormtrooper = 1,
		/obj/item/clothing/shoes/combat/stormtrooper = 1,
		/obj/item/clothing/gloves/combat/peacekeeper/stormtrooper = 1,
		/obj/item/clothing/head/cowboyhat/widesec = 1,
		/obj/item/clothing/under/rank/security/blackwatch = 1,
		/obj/item/clothing/suit/cossack/sec = 2,
		/obj/item/clothing/mask/gas/german = 3
	)
	premium = list(
		/obj/item/clothing/under/rank/security/officer/formal = 3,
		/obj/item/clothing/suit/security/officer = 3,
		/obj/item/clothing/head/beret/sec/navyofficer = 3
		)
	refill_canister = /obj/item/vending_refill/wardrobe/peacekeeper_wardrobe
	payment_department = ACCOUNT_SEC
	light_color = COLOR_MOSTLY_PURE_RED

/obj/item/vending_refill/wardrobe/peacekeeper_wardrobe
	machine_name = "Peacekeeper Outfitting Station"
