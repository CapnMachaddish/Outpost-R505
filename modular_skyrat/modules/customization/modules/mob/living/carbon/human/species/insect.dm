/datum/species/insect
	name = "Anthromorphic Insect"
	id = "insect"
	say_mod = "chitters"
	default_color = "4B4B4B"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,HAIR,FACEHAIR)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("tail" = "None", "snout" = "None", "horns" = "None", "ears" = "None", "legs" = "Normal Legs", "taur" = "None", "fluff" = "None", "wings" = "Bee", "moth_antennae" = "None")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = GROSS | MEAT | TOXIC
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/modules/customization/icons/mob/species/insect_parts_greyscale.dmi'
