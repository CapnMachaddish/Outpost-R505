//Using skillchips as the base for connectomes, for now.
/obj/item/skillchip/connectome
	name = "connectome"
	desc = "This device holds a neural map that can be used to produce a neuromod if the appropriate equipment is available."

	icon = 'icons/obj/card.dmi'
	icon_state = "data_3"
	w_class = WEIGHT_CLASS_SMALL
	slot_use = 0
	complexity = 0
	cooldown = -1 MINUTES

/obj/item/skillchip/connectome/Initialize(mapload, is_removable = FALSE)
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
	skill_description = "You shouldn't see this item."
	skill_icon = "hand-holding"
	activate_message = "<span class='notice'>You feel like you can easily lift and carry people around.</span>"
	deactivate_message = "<span class='notice'>Your skill at lifting people into a fireman carry fades from your mind.</span>"
	slot_use = 0
	complexity = 0
	cooldown = -1 MINUTES

/obj/item/skillchip/connectome/quickercarry
	name = "RES-Q connectome"
	auto_traits = list(TRAIT_QUICKER_CARRY)
	skill_name = "RES-Q"
	chip_category = SKILLCHIP_CATEGORY_FIREMAN_CARRYING
	skillchip_flags = SKILLCHIP_RESTRICTED_CATEGORIES
	incompatibility_list = list(SKILLCHIP_CATEGORY_FIREMAN_CARRYING)
	skill_description = "You shouldn't see this item."
	skill_icon = "hand-holding"
	activate_message = "<span class='notice'>Carrying people across your back feels like second nature to you.</span>"
	deactivate_message = "<span class='notice'>Your expert knowledge in fireman carrying fades from your mind.</span>"
	slot_use = 0
	complexity = 0
	cooldown = -1 MINUTES
