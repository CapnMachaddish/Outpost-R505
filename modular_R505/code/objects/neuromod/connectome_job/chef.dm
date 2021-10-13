//Chef
/obj/item/skillchip/connectome/job/chef
	name = "B0RK-X3 connectome"  // bork bork bork
	desc = "You shouldn't see this item."
	skill_name = "Close Quarters Cooking"
	skill_description = "A specialised form of self defence, developed by skilled sous-chef de cuisines. No man fights harder than a chef to defend his kitchen."
	skill_icon = "utensils"
	activate_message = "<span class='notice'>You can visualize how to defend your kitchen with martial arts.</span>"
	deactivate_message = "<span class='notice'>You forget how to control your muscles to execute kicks, slams and restraints while in a kitchen environment.</span>"
	var/datum/martial_art/cqc/under_siege/style
	slot_use = 0
	complexity = 0
	cooldown = -1 MINUTES


/obj/item/skillchip/connectome/job/chef/Initialize()
	. = ..()
	style = new
	style.refresh_valid_areas()

/obj/item/skillchip/connectome/job/chef/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user, make_temporary = TRUE)

/obj/item/skillchip/connectome/job/chef/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.remove(user)
	return ..()
