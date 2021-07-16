GLOBAL_LIST_EMPTY(roundstart_races)
GLOBAL_LIST_EMPTY(customizable_races)

/datum/species
	var/name
	var/id
	var/limbs_id
	var/blurb = "No description."
	var/reagent_flags = PROCESS_ORGANIC
	var/say_mod = "says"
	var/unambiguous_gender = TRUE
	var/species_language_holder = /datum/language_holder
	var/list/learnable_languages = list(/datum/language/common)

	var/list/species_traits = list()
	var/list/inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP)
	var/inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	var/list/inherent_factions
	var/changesource_flags = NONE
	var/inert_mutation = DWARFISM
	var/breathid = "o2"

	var/list/cultures = list(CULTURES_EXOTIC, CULTURES_HUMAN)
	var/list/locations = list(LOCATIONS_GENERIC, LOCATIONS_HUMAN)
	var/list/factions = list(FACTIONS_GENERIC, FACTIONS_HUMAN)

	var/liked_food = NONE
	var/disliked_food = GROSS
	var/toxic_food = TOXIC

	var/list/default_mutant_bodyparts = list()
	var/list/list/body_markings = list()
	var/default_color = "#FFF"
	var/fixed_mut_color = ""
	var/use_skintones = FALSE
	var/specific_alpha = 255
	var/markings_alpha = 255
	var/hair_color
	var/hair_alpha = 255
	var/always_customizable = FALSE

	var/list/mutant_organs = list()
	var/list/limb_bodyparts = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest)
	var/limbs_icon
	var/eyes_icon
	var/can_augment = TRUE
	var/can_have_genitals = TRUE

	var/attack_type = BRUTE
	var/punchdamagelow = 1
	var/punchdamagehigh = 10
	var/punchstunthreshold = 10
	var/attack_verb = "punch"
	var/attack_effect = ATTACK_EFFECT_PUNCH
	var/sound/attack_sound = 'sound/weapons/punch1.ogg'
	var/sound/miss_sound = 'sound/weapons/punchmiss.ogg'

	var/list/special_step_sounds
	var/deathsound
	var/grab_sound
	var/list/cough_sounds = list(MALE = list(
		'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_1.ogg',
		'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_2.ogg',
		'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_3.ogg'
	), FEMALE = list(
		'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_1.ogg',
		'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_2.ogg',
		'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_3.ogg'
	))
	var/list/sneeze_sounds = list(MALE = list('modular_skyrat/modules/emotes/sound/emotes/male/male_sneeze.ogg'), FEMALE = list('modular_skyrat/modules/emotes/sound/emotes/female/female_sneeze.ogg'))

	var/damage_overlay_type = "human"
	var/override_fire = ""
	var/dust_anim = "dust-h"
	var/gib_anim = "gibbed-h"
	var/handcuff_icon
	var/legcuff_icon

	var/meat = /obj/item/food/meat/slab/human
	var/list/knife_butcher_results
	var/skinned_type
	var/exotic_blood
	var/exotic_bloodtype = ""
	var/blood_trail
	var/blood_color = COLOR_BLOOD
	var/blood_volume = BLOOD_VOLUME_NORMAL
	var/list/family_heirlooms

	var/list/no_equip = list()
	var/nojumpsuit = FALSE
	var/list/offset_features = list(
		OFFSET_UNIFORM = list(0,0),
		OFFSET_ID = list(0,0),
		OFFSET_GLOVES = list(0,0),
		OFFSET_GLASSES = list(0,0),
		OFFSET_EARS = list(0,0),
		OFFSET_SHOES = list(0,0),
		OFFSET_S_STORE = list(0,0),
		OFFSET_FACEMASK = list(0,0),
		OFFSET_HEAD = list(0,0),
		OFFSET_FACE = list(0,0),
		OFFSET_BELT = list(0,0),
		OFFSET_BACK = list(0,0),
		OFFSET_SUIT = list(0,0),
		OFFSET_NECK = list(0,0),
		OFFSET_GENITALS = list(0,0),
		OFFSET_GENITALS_PENIS = list(0,0),
		OFFSET_GENITALS_TESTICLES = list(0,0),
		OFFSET_GENITALS_BREASTS = list(0,0),
		OFFSET_GENITALS_VAGINA = list(0,0))

	/**
	  * Visible CURRENT bodyparts that are unique to a species.
	  * DO NOT USE THIS AS A LIST OF ALL POSSIBLE BODYPARTS AS IT WILL FUCK
	  * SHIT UP! Changes to this list for non-species specific bodyparts (ie
	  * cat ears and tails) should be assigned at organ level if possible.
	  * Assoc values are defaults for given bodyparts, also modified by aforementioned organs.
	  * They also allow for faster '[]' list access versus 'in'. Other than that, they are useless right now.
	  */
	var/list/list/mutant_bodyparts = list()


	var/datum/outfit/outfit_important_for_life

	var/flying_species = FALSE
	var/datum/action/innate/flight/fly
	var/wings_icon = "Angel"
	var/list/wings_icons = list("Angel")
	var/has_innate_wings = FALSE

	var/payday_modifier = 1
	var/total_health = MAX_LIVING_HEALTH
	var/health_hud_intensity = 1
	var/speedmod = 0
	var/snow_movement = 1
	var/armor = 0
	var/brutemod = 1
	var/burnmod = 1
	var/coldmod = 1
	var/heatmod = 1
	var/stunmod = 1
	var/siemens_coeff = 1
	var/hunger_factor = HUNGER_FACTOR

	var/bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT
	var/cold_level_1 = 270
	var/cold_level_2 = 200
	var/cold_level_3 = 120
	var/bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	var/heat_level_1 = 360
	var/heat_level_2 = 400
	var/heat_level_3 = 1000

	var/heat_discomfort_level = 315
	var/cold_discomfort_level = 285
	var/list/heat_discomfort_flavor = list()
	var/list/cold_discomfort_flavor = list()

	var/bodytemp_normal = BODYTEMP_NORMAL
	var/bodytemp_autorecovery_min = BODYTEMP_AUTORECOVERY_MINIMUM

	//Do NOT remove by setting to null. use or make a respective trait. (removing stomach? add the NOSTOMACH trait to your species)
	//why does it work this way? because traits also disable the downsides of not having an organ, removing organs but not having the trait will make your species die
	var/obj/item/organ/brain/mutantbrain = /obj/item/organ/brain
	var/obj/item/organ/heart/mutantheart = /obj/item/organ/heart
	var/obj/item/organ/lungs/mutantlungs = /obj/item/organ/lungs
	var/obj/item/organ/eyes/mutanteyes = /obj/item/organ/eyes
	var/obj/item/organ/ears/mutantears = /obj/item/organ/ears
	var/obj/item/organ/tongue/mutanttongue = /obj/item/organ/tongue
	var/obj/item/organ/liver/mutantliver = /obj/item/organ/liver
	var/obj/item/organ/stomach/mutantstomach = /obj/item/organ/stomach
	var/obj/item/organ/appendix/mutantappendix = /obj/item/organ/appendix
	///Forces an item into this species' hands. Only an honorary mutantthing because this is not an organ and not loaded in the same way, you've been warned to do your research.
	var/obj/item/mutanthands

	var/icon/ass_image
	var/list/body_vis_overlays = list()	//Do not modify
	var/temperature_text_cooldown as num

/datum/species/New()
	if(!limbs_id) //if we havent set a limbs id to use, just use our own id
		limbs_id = id
	wings_icons = string_list(wings_icons)
	if(can_have_genitals)
		default_mutant_bodyparts["vagina"] = "None"
		default_mutant_bodyparts["womb"] = "None"
		default_mutant_bodyparts["testicles"] = "None"
		default_mutant_bodyparts["breasts"] = "None"
		default_mutant_bodyparts["penis"] = "None"
	..()

/proc/generate_selectable_species()
	for(var/I in subtypesof(/datum/species))
		var/datum/species/S = new I	//Using initial() is slow
		if(S.check_roundstart_eligible())
			GLOB.roundstart_races[S.id] = TRUE
			GLOB.customizable_races[S.id] = TRUE
		else if (S.always_customizable)
			GLOB.customizable_races[S.id] = TRUE
		qdel(S)
	if(!GLOB.roundstart_races.len)
		GLOB.roundstart_races["human"] = TRUE
