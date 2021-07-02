GLOBAL_LIST_EMPTY(roundstart_races)
GLOBAL_LIST_EMPTY(customizable_races)

/proc/generate_selectable_species()
	for(var/I in subtypesof(/datum/species))
		var/datum/species/S = new I
		if(S.check_roundstart_eligible())
			GLOB.roundstart_races[S.id] = TRUE
			GLOB.customizable_races[S.id] = TRUE
		else if (S.always_customizable)
			GLOB.customizable_races[S.id] = TRUE
		qdel(S)
	if(!GLOB.roundstart_races.len)
		GLOB.roundstart_races["human"] = TRUE
/**
 * # species datum
 *
 * Datum that handles different species in the game.
 *
 * This datum handles species in the game, such as lizardpeople, mothmen, zombies, skeletons, etc.
 * It is used in [carbon humans][mob/living/carbon/human] to determine various things about them, like their food preferences, if they have biological genders, their damage resistances, and more.
 *
 */
/datum/species
	///This is the fluff name. They are displayed on health analyzers and in the character setup menu. Leave them generic for other servers to customize.
	var/name
	///If the game needs to manually check your race to do something not included in a proc here, it will use this.
	var/id
	//This is used if you want to use a different species' limb sprites.
	var/limbs_id
	///What languages this species can understand and say. Use a [language holder datum][/datum/language_holder] in this var.
	var/species_language_holder = /datum/language_holder

	// Default color. If mutant colors are disabled, this is the color that will be used by that race.
	var/default_color = "#FFF"

	///Whether or not the race has sexual characteristics (biological genders)
	var/unambiguous_gender = TRUE

	///Clothing offsets. If a species has a different body than other species, you can offset clothing so they look less weird.
	var/list/offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,0), OFFSET_EARS = list(0,0), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,0))

	///This allows races to have specific hair colors. If null, it uses the H's hair/facial hair colors. If "mutcolor", it uses the H's mutant_color. If "fixedmutcolor", it uses fixedmutcolor
	var/hair_color
	///The alpha used by the hair. 255 is completely solid, 0 is invisible.
	var/hair_alpha = 255

	///Does the species use skintones or not? As of now only used by humans.
	var/use_skintones = FALSE
	///If your race bleeds something other than bog standard blood, change this to reagent id. For example, ethereals bleed liquid electricity.
	var/exotic_blood = ""
	///If your race uses a non standard bloodtype (A+, O-, AB-, etc). For example, lizards have L type blood.
	var/exotic_bloodtype = ""
	///What the species drops when gibbed by a gibber machine.
	var/meat = /obj/item/food/meat/slab/human
	///What skin the species drops when gibbed by a gibber machine.
	var/skinned_type
	///Bitfield for food types that the species likes, giving them a mood boost. Lizards like meat, for example.
	var/liked_food = NONE
	///Bitfield for food types that the species dislikes, giving them disgust. Humans hate raw food, for example.
	var/disliked_food = GROSS
	///Bitfield for food types that the species absolutely hates, giving them even more disgust than disliked food. Meat is "toxic" to moths, for example.
	var/toxic_food = TOXIC
	///Inventory slots the race can't equip stuff to. Golems cannot wear jumpsuits, for example.
	var/list/no_equip = list()
	/// Allows the species to equip items that normally require a jumpsuit without having one equipped. Used by golems.
	var/nojumpsuit = FALSE
	///Affects the speech message, for example: Motharula flutters, "My speech message is flutters!"
	var/say_mod = "says"
	/**
	  * Visible CURRENT bodyparts that are unique to a species.
	  * DO NOT USE THIS AS A LIST OF ALL POSSIBLE BODYPARTS AS IT WILL FUCK
	  * SHIT UP! Changes to this list for non-species specific bodyparts (ie
	  * cat ears and tails) should be assigned at organ level if possible.
	  * Assoc values are defaults for given bodyparts, also modified by aforementioned organs.
	  * They also allow for faster '[]' list access versus 'in'. Other than that, they are useless right now.
	  * Layer hiding is handled by [/datum/species/proc/handle_mutant_bodyparts] below.
	  */
	var/list/list/mutant_bodyparts = list()
	///Internal organs that are unique to this race, like a tail.
	var/list/mutant_organs = list()
	///The bodyparts this species uses. assoc of bodypart string - bodypart type. Make sure all the fucking entries are in or I'll skin you alive.
	var/list/limb_bodyparts = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest)
	///Multiplier for the race's speed. Positive numbers make it move slower, negative numbers make it move faster.
	var/speedmod = 0
	///Percentage modifier for overall defense of the race, or less defense, if it's negative.
	var/armor = 0
	var/brutemod = 1
	var/burnmod = 1
	var/coldmod = 1
	var/heatmod = 1
	var/stunmod = 1
	///multiplier for money paid at payday
	var/payday_modifier = 1
	///Type of damage attack does. Ethereals attack with burn damage for example.
	var/attack_type = BRUTE
	///Lowest possible punch damage this species can give. If this is set to 0, punches will always miss.
	var/punchdamagelow = 1
	///Highest possible punch damage this species can give.
	var/punchdamagehigh = 10
	///Damage at which punches from this race will stun
	var/punchstunthreshold = 10 //yes it should be to the attacked race but it's not useful that way even if it's logical
	///Base electrocution coefficient.  Basically a multiplier for damage from electrocutions.
	var/siemens_coeff = 1
	///What kind of damage overlays (if any) appear on our species when wounded? If this is "", does not add an overlay.
	var/damage_overlay_type = "human"
	///To use MUTCOLOR with a fixed color that's independent of the mcolor feature in DNA.
	var/fixed_mut_color = ""
	///Special mutation that can be found in the genepool exclusively in this species. Dont leave empty or changing species will be a headache
	var/inert_mutation = DWARFISM
	///Used to set the mob's deathsound upon species change
	var/deathsound
	///Sounds to override barefeet walking
	var/list/special_step_sounds
	///Special sound for grabbing
	var/grab_sound
	/// A path to an outfit that is important for species life e.g. plasmaman outfit
	var/datum/outfit/outfit_important_for_life

	///Is this species a flying species? Used as an easy check for some things
	var/flying_species = FALSE
	///The actual flying ability given to flying species
	var/datum/action/innate/flight/fly
	///Current wings icon
	var/wings_icon = "Angel"
	//Dictates which wing icons are allowed for a given species. If count is >1 a radial menu is used to choose between all icons in list
	var/list/wings_icons = list("Angel")
	///Used to determine what description to give when using a potion of flight, if false it will describe them as growing new wings
	var/has_innate_wings = FALSE

	/// The natural temperature for a body
	var/bodytemp_normal = BODYTEMP_NORMAL
	/// Minimum amount of kelvin moved toward normal body temperature per tick.
	var/bodytemp_autorecovery_min = BODYTEMP_AUTORECOVERY_MINIMUM
	/// The body temperature limit the body can take before it starts taking damage from heat.
	var/bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	/// The body temperature limit the body can take before it starts taking damage from cold.
	var/bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

	///Species-only traits. Can be found in [code/__DEFINES/DNA.dm]
	var/list/species_traits = list()
	///Generic traits tied to having the species.
	var/list/inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP)
	/// List of biotypes the mob belongs to. Used by diseases.
	var/inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	///List of factions the mob gain upon gaining this species.
	var/list/inherent_factions

	///Punch-specific attack verb.
	var/attack_verb = "punch"
	/// The visual effect of the attack.
	var/attack_effect = ATTACK_EFFECT_PUNCH
	var/sound/attack_sound = 'sound/weapons/punch1.ogg'
	var/sound/miss_sound = 'sound/weapons/punchmiss.ogg'

	///What gas does this species breathe? Used by suffocation screen alerts, most of actual gas breathing is handled by mutantlungs. See [life.dm][code/modules/mob/living/carbon/human/life.dm]
	var/breathid = "o2"

	///What anim to use for dusting
	var/dust_anim = "dust-h"
	///What anim to use for gibbing
	var/gib_anim = "gibbed-h"


	//Do NOT remove by setting to null. use OR make a RESPECTIVE TRAIT (removing stomach? add the NOSTOMACH trait to your species)
	//why does it work this way? because traits also disable the downsides of not having an organ, removing organs but not having the trait will make your species die

	///Replaces default brain with a different organ
	var/obj/item/organ/brain/mutantbrain = /obj/item/organ/brain
	///Replaces default heart with a different organ
	var/obj/item/organ/heart/mutantheart = /obj/item/organ/heart
	///Replaces default lungs with a different organ
	var/obj/item/organ/lungs/mutantlungs = /obj/item/organ/lungs
	///Replaces default eyes with a different organ
	var/obj/item/organ/eyes/mutanteyes = /obj/item/organ/eyes
	///Replaces default ears with a different organ
	var/obj/item/organ/ears/mutantears = /obj/item/organ/ears
	///Replaces default tongue with a different organ
	var/obj/item/organ/tongue/mutanttongue = /obj/item/organ/tongue
	///Replaces default liver with a different organ
	var/obj/item/organ/liver/mutantliver = /obj/item/organ/liver
	///Replaces default stomach with a different organ
	var/obj/item/organ/stomach/mutantstomach = /obj/item/organ/stomach
	///Replaces default appendix with a different organ.
	var/obj/item/organ/appendix/mutantappendix = /obj/item/organ/appendix
	///Forces an item into this species' hands. Only an honorary mutantthing because this is not an organ and not loaded in the same way, you've been warned to do your research.
	var/obj/item/mutanthands

	///Bitflag that controls what in game ways something can select this species as a spawnable source, such as magic mirrors. See [mob defines][code/__DEFINES/mobs.dm] for possible sources.
	var/changesource_flags = NONE

	///For custom overrides for species ass images
	var/icon/ass_image

	/// List of family heirlooms this species can get with the family heirloom quirk. List of types.
	var/list/family_heirlooms

	///List of results you get from knife-butchering. null means you cant butcher it. Associated by resulting type - value of amount
	var/list/knife_butcher_results

	///List of visual overlays created by handle_body()
	var/list/body_vis_overlays = list()

	///Self explanatory
	var/can_have_genitals = TRUE
	///Override of icon file of which we're taking the icons from for our limbs
	var/limbs_icon
	///A list of actual body markings on the owner of the species. Associative lists with keys named by limbs defines, pointing to a list with names and colors for the marking to be rendered. This is also stored in the DNA
	var/list/list/body_markings = list()
	///Override of the eyes icon file, used for Vox and maybe more in the future
	var/eyes_icon
	///How are we treated regarding processing reagents, by default we process them as if we're organic
	var/reagent_flags = PROCESS_ORGANIC
	///Whether a species can use augmentations in preferences
	var/can_augment = TRUE
	///Override for the alpha of bodyparts and mutant parts.
	var/specific_alpha = 255
	///Override for alpha value of markings, should be much lower than the above value.
	var/markings_alpha = 255
	///If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE
	///Flavor text of the species displayed on character creation screeen
	var/blurb = "No description."
	///What accessories can a species have aswell as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
	var/list/default_mutant_bodyparts = list()
	/// Available cultural informations
	var/list/cultures = list(CULTURES_EXOTIC, CULTURES_HUMAN)
	var/list/locations = list(LOCATIONS_GENERIC, LOCATIONS_HUMAN)
	var/list/factions = list(FACTIONS_GENERIC, FACTIONS_HUMAN)
	/// List of all the languages our species can learn NO MATTER their background
	var/list/learnable_languages = list(/datum/language/common)

	var/total_health = 100
	var/health_hud_intensity = 1
	var/blood_color = "#A10808"
	var/list/male_cough_sounds = list()
	var/list/female_cough_sounds = list()
	var/list/male_sneeze_sounds = list()
	var/list/female_sneeze_sounds = list()
	var/move_trail
	var/snow_movement = 0
	var/blood_volume = 560
	var/hunger_factor = HUNGER_FACTOR
	var/cold_level_1 = 260
	var/cold_level_2 = 200
	var/cold_level_3 = 120
	var/heat_level_1 = 360
	var/heat_level_2 = 400
	var/heat_level_3 = 1000
	var/heat_discomfort_level = 315
	var/cold_discomfort_level = 285
	var/heat_discomfort_flavor = list()
	var/cold_discomfort_flavor = list()
