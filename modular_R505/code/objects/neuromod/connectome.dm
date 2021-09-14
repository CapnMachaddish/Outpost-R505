//Using skillchips as the base for connectomes, for now.
/obj/item/skillchip/connectome
	name = "connectome"
	desc = "This device holds a neural map that can be used to produce a neuromod if the appropriate equipment is available."

	icon = 'icons/obj/card.dmi'
	icon_state = "data_3"
	w_class = WEIGHT_CLASS_SMALL

/*
	/// Traits automatically granted by this connectome, optional. Lazylist.
	var/list/auto_traits
	/// Skill name shown on UI
	var/skill_name
	/// Skill description shown on UI
	var/skill_description
	/// Category string. Used alongside SKILLCHIP_RESTRICTED_CATEGORIES flag to make a chip incompatible with chips from another category.
	var/chip_category = SKILLCHIP_CATEGORY_GENERAL
	/// List of any incompatible categories.
	var/list/incompatibility_list
	/// Fontawesome icon show on UI, list of possible icons https://fontawesome.com/icons?d=gallery&m=free
	var/skill_icon = "brain"
	/// Message shown when activating the chip
	var/activate_message
	/// Message shown when deactivating the chip
	var/deactivate_message
	//If set to FALSE, trying to extract the chip will destroy it instead
	var/removable = false
	/// How complex the skillchip is. Brains can only handle so much complexity at once and skillchips will start to deactivate when the brain's complexity limit is exceeded.
	var/complexity = 0
	/// How many slots taken up in the brain by this chip. Max brain slots are hard set and should not be changed at all.
	var/slot_use = 0
	/// Variable for flags. DANGEROUS - Child types overwrite flags instead of adding to them. If you change this, make sure all child types have the appropriate flags set too.
	var/skillchip_flags = NONE
	/// Cooldown before the skillchip can be extracted after it has been implanted.
	var/cooldown = -1 MINUTES
	/// Cooldown for chip actions.
	COOLDOWN_DECLARE(chip_cooldown)
	/// Used to determine if this is an abstract type or not. If this is meant to be an abstract type, set it to the type's path. Will be overridden by subsequent abstract parents. See /datum/action/item_action/chameleon/change/skillchip/initialize_disguises()
	var/abstract_parent_type = /obj/item/skillchip
	/// Set to TRUE when the skill chip's effects are applied. Set to FALSE when they're not.
	var/active = FALSE
	/// Brain that holds this skillchip.
	var/obj/item/organ/brain/holding_brain
*/

/obj/item/skillchip/connectome/Initialize(mapload, is_removable = FALSE) //No removing neuromods, sorry.
	. = ..()
	removable = is_removable

//Carry
/obj/item/skillchip/connectome/quickcarry
	name = "Ant Hauler connectome"
	auto_traits = list(TRAIT_QUICK_CARRY)
	skill_name = "Ant Hauler"
	chip_category = SKILLCHIP_CATEGORY_FIREMAN_CARRYING
	skillchip_flags = SKILLCHIP_RESTRICTED_CATEGORIES
	incompatibility_list = list(SKILLCHIP_CATEGORY_FIREMAN_CARRYING)
	skill_description = "Discover various lifting techniques to more accurately and quickly lift someone up into a fireman carry."
	skill_icon = "hand-holding"
	activate_message = "<span class='notice'>You feel like you can easily lift and carry people around.</span>"
	deactivate_message = "<span class='notice'>Your skill at lifting people into a fireman carry fades from your mind.</span>"

/obj/item/skillchip/connectome/quickercarry
	name = "RES-Q connectome"
	auto_traits = list(TRAIT_QUICKER_CARRY)
	skill_name = "RES-Q"
	chip_category = SKILLCHIP_CATEGORY_FIREMAN_CARRYING
	skillchip_flags = SKILLCHIP_RESTRICTED_CATEGORIES
	incompatibility_list = list(SKILLCHIP_CATEGORY_FIREMAN_CARRYING)
	skill_description = "Learn how to fireman carry like a professional, and haul the injured, sick or dying with speed!"
	skill_icon = "hand-holding"
	activate_message = "<span class='notice'>Carrying people across your back feels like second nature to you.</span>"
	deactivate_message = "<span class='notice'>Your expert knowledge in fireman carrying fades from your mind.</span>"

//Job
