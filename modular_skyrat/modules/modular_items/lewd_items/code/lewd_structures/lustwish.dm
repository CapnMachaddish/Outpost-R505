/obj/machinery/vending/dorms
	name = "LustWish"
	desc = "A vending machine with various toys. Not for the faint of heart."
	icon_state = "lustwish"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/lustwish.dmi'
	light_mask = "lustwish-light-mask"
	age_restrictions = TRUE
	var/card_used = FALSE
	var/current_color = "pink"
	var/static/list/vend_designs
	product_ads = "Try me!;Kinky!;Lewd and fun!;Hey you, yeah you... wanna take a look at my collection?;Come on, take a look!;Remember, always adhere to Nanotrasen corporate policy!;Don't forget to use protection!"
	vend_reply = "Enjoy!;We're glad to satisfy your desires!"

	//STUFF SOLD HERE//
	products = list(//Sex toys
					/obj/item/clothing/sextoy/signalvib = 8,
					/obj/item/clothing/sextoy/eggvib = 8,
					/obj/item/clothing/sextoy/buttplug = 6,
					/obj/item/clothing/sextoy/nipple_clamps = 4,
					/obj/item/clothing/sextoy/double_dildo = 3,
					/obj/item/clothing/sextoy/vibroring = 6,
					/obj/item/condom_pack = 20,
					/obj/item/clothing/sextoy/dildo = 8,
					/obj/item/clothing/sextoy/custom_dildo = 8,
					/obj/item/tickle_feather = 8,
					/obj/item/clothing/sextoy/fleshlight = 8,
					/obj/item/kinky_shocker = 4,
					/obj/item/clothing/mask/leatherwhip = 4,
					/obj/item/clothing/sextoy/magic_wand = 4,
					/obj/item/bdsm_candle = 4,
					/obj/item/spanking_pad = 4,
					/obj/item/clothing/sextoy/vibrator = 4,
					/obj/item/serviette_pack = 10,
					/obj/item/restraints/handcuffs/lewd = 8,
					/obj/item/pillow = 24,
					/obj/item/assembly/signaler = 8,

					//clothing facial/head
					/obj/item/clothing/mask/ballgag = 8,
					/obj/item/clothing/mask/ballgag/phallic = 8,
					/obj/item/clothing/mask/ballgag/phallic/kazoo = 8,
					/obj/item/clothing/head/domina_cap = 5,
					/obj/item/clothing/head/helmet/space/deprivation_helmet = 5,
					/obj/item/clothing/head/maid = 5,
					/obj/item/clothing/glasses/blindfold/kinky = 5,
					/obj/item/clothing/ears/kinky_headphones = 5,
					/obj/item/clothing/mask/gas/bdsm_mask = 5,
					/obj/item/reagent_containers/glass/lewd_filter = 5,
					/obj/item/clothing/glasses/hypno = 4,
					/obj/item/clothing/head/kitty = 4,
					/obj/item/clothing/head/rabbitears = 4,


					//neck
					/obj/item/clothing/neck/kink_collar = 8,

					//torso clothing
					/obj/item/clothing/suit/corset = 8,
					/obj/item/clothing/under/misc/latex_catsuit = 8,
					/obj/item/clothing/suit/straight_jacket/latex_straight_jacket = 5,
					/obj/item/clothing/under/rank/civilian/janitor/maid = 5,
					/obj/item/clothing/under/costume/lewdmaid = 5,
					/obj/item/clothing/under/costume/maid = 5,
					/obj/item/clothing/suit/straight_jacket/shackles = 3,
					/obj/item/clothing/under/stripper_outfit = 5,
					/obj/item/clothing/under/misc/gear_harness = 4,
					/obj/item/clothing/under/shorts/polychromic/pantsu = 4,

					//hands
					/obj/item/clothing/gloves/ball_mittens = 8,
					/obj/item/clothing/gloves/latex_gloves = 8,
					/obj/item/clothing/gloves/evening = 5,

					//legs
					/obj/item/clothing/shoes/latex_socks = 8,
					/obj/item/clothing/shoes/latexheels = 4,
					/obj/item/clothing/shoes/dominaheels = 4,
					/obj/item/clothing/shoes/jackboots/thigh = 3,
					/obj/item/clothing/shoes/jackboots/knee = 3,

					//belt
					/obj/item/clothing/strapon = 6,
					/obj/item/storage/belt/erpbelt = 5,

					//chems
					/obj/item/reagent_containers/pill/crocin = 20,
					/obj/item/reagent_containers/glass/bottle/crocin = 6,
					/obj/item/reagent_containers/pill/camphor = 10,
					/obj/item/reagent_containers/glass/bottle/camphor = 3,
					/obj/item/reagent_containers/glass/bottle/breast_enlarger = 6, //Those are legal 'cause you can just turn off prefs in round in "CLOWN SMOKE MACHINE+PENIS ENLARGEMENT CHEMICAL CASE". Yes, i have special code-phrase for this. I've seen some shit.
					/obj/item/reagent_containers/glass/bottle/penis_enlarger = 6,

					//special
					/obj/item/clothing/glasses/nice_goggles = 1, //easter egg, don't touch plz)

					//fur niture //haha you got it
					/obj/item/storage/box/strippole_kit = 3)

	contraband = list(
					/obj/item/electropack/shockcollar = 4,
					/obj/item/clothing/neck/kink_collar/locked = 4,
					/obj/item/clothing/neck/mind_collar = 2,
					/obj/item/clothing/suit/straight_jacket/kinky_sleepbag = 2, //my favorite thing, spent 1 month on it. Don't remove please.
					/obj/item/reagent_containers/pill/hexacrocin = 10,
					/obj/item/reagent_containers/pill/pentacamphor = 5,
					/obj/item/reagent_containers/glass/bottle/hexacrocin = 4,
					/obj/item/reagent_containers/glass/bottle/pentacamphor = 2)

	refill_canister = /obj/item/vending_refill/lustwish
	payment_department = ACCOUNT_SRV
	default_price = 30
	extra_price = 250

//Secret vending machine skin. Don't touch plz
/obj/machinery/vending/dorms/proc/populate_vend_designs()
    vend_designs = list(
        "pink" = image (icon = src.icon, icon_state = "lustwish_pink"),
        "teal" = image(icon = src.icon, icon_state = "lustwish_teal"))

//Changing special secret var
/obj/machinery/vending/dorms/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/lustwish_discount))
		user.visible_message(span_boldnotice("Something changes in [src] with a loud clunk."))
		card_used = !card_used
		switch(card_used)
			if(TRUE)
				default_price = 0
				extra_price = 0
			if(FALSE)
				default_price = 30
				extra_price = 250
	else
		return ..()

//using multitool on pole
/obj/machinery/vending/dorms/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return
	if(card_used == TRUE)
		var/choice = show_radial_menu(user,src, vend_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 50, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
	else
		return

/obj/machinery/vending/dorms/proc/check_menu(mob/living/user, obj/item/multitool)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(!multitool || !user.is_holding(multitool))
		return FALSE
	return TRUE

/obj/machinery/vending/dorms/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(vend_designs))
		populate_vend_designs()

/obj/machinery/vending/dorms/update_icon_state()
	..()
	if(machine_stat & BROKEN)
		icon_state = "[initial(icon_state)]_[current_color]-broken"
	else
		icon_state = "[initial(icon_state)]_[current_color][powered() ? null : "-off"]"


//Refill item
/obj/item/vending_refill/lustwish
	machine_name = "LustWish"
	icon_state = "lustwish_refill"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
