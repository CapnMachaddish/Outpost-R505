/*           *
 * FEATHERS! *
 *           */
//TODO: resprite teshari actual limbs to not have feathers
//TODO: long/large feather accessory
//TODO: flowers/nature accesory
//TODO: skarmory pokemon wings?
//TODO: make this actually work, damn it, it's too much right now
/datum/sprite_accessory/feathers
	key = "feathers"
	generic = "Feathers"
	icon = 'modular_R505/icons/ported/mob/teshari/feathers.dmi'
	recommended_species = list("teshari")
	relevent_layers = list(BODY_FRONT_LAYER)
	color_src = USE_ONE_COLOR
	transmutable_bodyparts = list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_ARM, BODY_ZONE_R_LEG)

/datum/sprite_accessory/feathers/none
	name = "None"
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/feathers/default
	name = "Default"
	icon_state = "default"

/*       *
 * HAIR! *
 *       */

//Like normal hair when the species can't have normal hair
/datum/sprite_accessory/species_hair
	key = "s_hair"	//how confusing is this in dmi files
	generic = "Head Spikes"
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	color_src = HAIR

/datum/sprite_accessory/species_hair/none
	name = "None"
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/species_hair/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE
	return FALSE

/datum/sprite_accessory/species_hair/teshari
	icon = 'modular_R505/icons/ported/mob/teshari/accessories/face_head.dmi'
	recommended_species = list("teshari")
	color_src = USE_ONE_COLOR	//Not hair because teshi doesn't have any in species_traits

/datum/sprite_accessory/species_hair/teshari/default
	name = "Teshari Generic"
	icon_state = "default"

/datum/sprite_accessory/species_hair/teshari/backstrafe
	name = "Backstrafe"
	icon_state = "backstrafe"

/datum/sprite_accessory/species_hair/teshari/chin
	name = "Chin Scriggle"
	icon_state = "chin"

/datum/sprite_accessory/species_hair/teshari/chinbeard
	name = "Chin Scraggle"
	icon_state = "scraggly"

/datum/sprite_accessory/species_hair/teshari/droopy
	name = "Droopy"
	icon_state = "droopy"

/datum/sprite_accessory/species_hair/teshari/gap
	name = "Gap"
	icon_state = "gap"

/datum/sprite_accessory/species_hair/teshari/earlike
	name = "Grass Patch"
	icon_state = "earsy"

/datum/sprite_accessory/species_hair/teshari/helmet
	name = "Helmet"
	icon_state = "tight"

/datum/sprite_accessory/species_hair/teshari/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/species_hair/teshari/mohawk
	name = "Mohawk"
	icon_state = "mohawk"

/datum/sprite_accessory/species_hair/teshari/fluffy_mohawk
	name = "Fluffy Mohawk"
	icon_state = "fluffymohawk"

/datum/sprite_accessory/species_hair/teshari/mushroom_top
	name = "Mushroom Top"
	icon_state = "mushroom"

/datum/sprite_accessory/species_hair/teshari/pointy
	name = "Pointy"
	icon_state = "pointy"
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/species_hair/teshari/spiky
	name = "Spiky"
	icon_state = "spiky"

/datum/sprite_accessory/species_hair/teshari/spikes
	name = "Sharp Spikes"
	icon_state = "spike"

/datum/sprite_accessory/species_hair/teshari/mane
	name = "Mane"
	icon_state = "mane"

/datum/sprite_accessory/species_hair/teshari/bigburst
	name = "Solar Flare"
	icon_state = "burst"
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/species_hair/teshari/shortburst
	name = "Solar Bursa"
	icon_state = "burst_short"
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/species_hair/teshari/upright
	name = "Upright"
	icon_state = "upright"

/datum/sprite_accessory/species_hair/teshari/hemmingway
	name = "Hemmingway"
	icon_state = "longwavy"

/datum/sprite_accessory/species_hair/teshari/tree
	name = "Tree"
	icon_state = "tree"

/datum/sprite_accessory/species_hair/teshari/twies
	name = "Twies"
	icon_state = "twies"

/*        *
 * TAILS! *
 *        */

/datum/sprite_accessory/tails/teshari
	icon = 'modular_R505/icons/ported/mob/teshari/accessories/tail.dmi'
	recommended_species = list("teshari")
	color_src = USE_MATRIXED_COLORS
	relevent_layers = list(BODY_ADJ_LAYER, BODY_BEHIND_LAYER)

/datum/sprite_accessory/tails/teshari/none	//i guess this is needed
	name = "None"
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/tails/teshari/default
	name = "Feathery Tail"
	icon_state = "seromi"

/datum/sprite_accessory/tails/teshari/fluffy
	name = "Fluffy Tail"
	icon_state = "fluffy"

/*        *
 * EARS ! *
 *        */
//TODO: add more ears
//TODO: lightning-shaped ears?
/datum/sprite_accessory/ears/teshari
	icon = 'modular_R505/icons/ported/mob/teshari/accessories/ears.dmi'
	recommended_species = list("teshari")
	color_src = USE_MATRIXED_COLORS
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/ears/teshari/none	//This is needed I guess
	name = "None"
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/ears/teshari/default
	name = "Teshari Ears"
	icon_state = "default"

/datum/sprite_accessory/ears/teshari/high
	name = "Teshari High"
	icon_state = "high"

/datum/sprite_accessory/ears/teshari/low
	name = "Teshari Low"
	icon_state = "low"

/*                *
 * Body Markings! *
 *                */
//TODO: light body marking like lizards
//TODO: "rough" marking to make chest area look like stone
/datum/body_marking/tertiary/teshari
	icon = 'modular_R505/icons/ported/mob/teshari/accessories/bodymarking.dmi'
	recommended_species = list("teshari")

/datum/body_marking/tertiary/teshari/fluff
	name = "Teshari Fluff"
	icon_state = "teshi_fluff"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT	//chest doesn't show, why?
	//TODO for this: Add arm sprites, make brighter

/datum/body_marking/tertiary/teshari/heterochromia_right	//this doesn't show, probably because of eyes?
	name = "Teshari Heterochromia (Right)"
	icon_state = "teshi_chromia"
	affected_bodyparts = HEAD
