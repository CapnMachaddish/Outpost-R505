/obj/item/storage/belt/erpbelt
	name = "leather belt"
	desc = "Used to hold sex toys. Looks pretty good."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "erpbelt"
	inhand_icon_state = "erpbelt"
	worn_icon_state = "erpbelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'

/obj/item/storage/belt/erpbelt/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 21
	STR.set_holdable(list(
						//toys
						/obj/item/clothing/sextoy/signalvib,
						/obj/item/clothing/sextoy/buttplug,
						/obj/item/clothing/sextoy/nipple_clamps,
						/obj/item/clothing/sextoy/eggvib,
						/obj/item/clothing/sextoy/double_dildo,
						/obj/item/clothing/sextoy/vibroring,
						/obj/item/clothing/sextoy/condom,
						/obj/item/condom_pack,
						/obj/item/clothing/sextoy/dildo,
						/obj/item/clothing/sextoy/custom_dildo,
						/obj/item/tickle_feather,
						/obj/item/clothing/sextoy/fleshlight,
						/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/clothing/sextoy/magic_wand,
						/obj/item/bdsm_candle,
						/obj/item/spanking_pad,
						/obj/item/clothing/sextoy/vibrator,
						/obj/item/restraints/handcuffs/lewd,
						/obj/item/reagent_containers/glass/lewd_filter,
						/obj/item/assembly/signaler, //because it's used for several toys

						//clothing
						/obj/item/clothing/mask/ballgag,
						/obj/item/clothing/mask/ballgag/phallic,
						/obj/item/clothing/mask/ballgag/phallic/kazoo,
						/obj/item/clothing/head/domina_cap,
						/obj/item/clothing/head/maid,
						/obj/item/clothing/glasses/blindfold/kinky,
						/obj/item/clothing/ears/kinky_headphones,
						/obj/item/clothing/suit/straight_jacket/latex_straight_jacket,
						/obj/item/clothing/mask/gas/bdsm_mask,
						/obj/item/clothing/head/helmet/space/deprivation_helmet,
						/obj/item/clothing/glasses/hypno,

						//neck
						/obj/item/clothing/neck/kink_collar,
						/obj/item/clothing/neck/kink_collar/locked,
						/obj/item/clothing/neck/mind_collar,
						/obj/item/electropack/shockcollar,

						//torso clothing
						/obj/item/clothing/suit/corset,
						/obj/item/clothing/under/misc/latex_catsuit,
						/obj/item/clothing/under/rank/civilian/janitor/maid,
						/obj/item/clothing/under/costume/lewdmaid,
						/obj/item/clothing/suit/straight_jacket/shackles,
						/obj/item/clothing/under/stripper_outfit,
						/obj/item/clothing/under/misc/gear_harness,

						//hands
						/obj/item/clothing/gloves/ball_mittens,
						/obj/item/clothing/gloves/latex_gloves,
						/obj/item/clothing/gloves/evening,

						//legs
						/obj/item/clothing/shoes/latex_socks,
						/obj/item/clothing/shoes/latexheels,
						/obj/item/clothing/shoes/dominaheels,

						//belt
						/obj/item/clothing/strapon,

						//chems
						/obj/item/reagent_containers/pill/crocin,
						/obj/item/reagent_containers/pill/camphor,
						/obj/item/reagent_containers/glass/bottle/breast_enlarger,
						/obj/item/reagent_containers/glass/bottle/penis_enlarger,
						/obj/item/reagent_containers/pill/hexacrocin,
						/obj/item/reagent_containers/pill/pentacamphor,
						/obj/item/reagent_containers/glass/bottle/hexacrocin,
						/obj/item/reagent_containers/glass/bottle/pentacamphor))
