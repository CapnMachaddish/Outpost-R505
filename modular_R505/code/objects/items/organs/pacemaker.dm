/obj/item/organ/pacemaker
	name = "pacemaker"
	desc = "Keeps a good pace. Allows a patient to survive with a damaged heart."
	var/used_name = "damaged pacemaker"
	var/used_desc = "Doesn't keep a good pace. Allows a patient to survive with a damaged heart."
	icon = 'modular_R505/icons/obj/organ.dmi'
	icon_state = "pacemaker"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_HEART_AID
	organ_flags = ORGAN_SYNTHETIC
	w_class = WEIGHT_CLASS_TINY
	maxHealth = 35

	healing_factor = 0
	decay_factor = 0
	attack_verb_simple = list("pace", "bop")
	attack_verb_continuous = list("paces", "bops")

/obj/item/organ/pacemaker/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(!(organ_flags & ORGAN_FAILING))
		ADD_TRAIT(M, TRAIT_STABLEHEART, type)
		ADD_TRAIT(M, TRAIT_NOCRITDAMAGE, type)

/obj/item/organ/pacemaker/Remove(mob/living/carbon/M, special = FALSE)
	if(!(organ_flags & ORGAN_FAILING))
		totally_damaged(M)
	. = ..()

/obj/item/organ/pacemaker/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	setOrganDamage(maxHealth)
	totally_damaged(owner)

/obj/item/organ/pacemaker/on_life(delta_time, times_fired)
	. = ..()
	var/obj/item/organ/heart/H = owner.getorganslot(ORGAN_SLOT_HEART)
	if(!istype(H, /obj/item/organ/heart))
		return

	var/overall_damage = (H.damage / H.maxHealth)	//0 to 1 (hopefully)

	if(owner.stat >= SOFT_CRIT)
		overall_damage += 1

	if(overall_damage > 0.1)
		applyOrganDamage(overall_damage)	//Doesn't stop even if host is dead
	
	if(organ_flags & ORGAN_FAILING)	//applyOrganDamage applies this
		totally_damaged(owner)

/obj/item/organ/pacemaker/proc/totally_damaged(mob/living/carbon/M)
	name = used_name
	desc = used_desc
	REMOVE_TRAIT(M, TRAIT_STABLEHEART, type)
	REMOVE_TRAIT(M, TRAIT_NOCRITDAMAGE, type)

/obj/item/organ/pacemaker/horrible
	name = "coin with wires attached"
	desc = "What could this be used for?"
	used_name = "rusted coin"
	used_desc = "It smells like chicken."
	icon_state = "coin"
	maxHealth = 10

/obj/item/organ/pacemaker/weak
	maxHealth = 15

/obj/item/organ/pacemaker/t2
	name = "upgraded pacemaker"
	desc = "Lasts longer than its predecessor."
	used_name = "burnt-out pacemaker"
	used_name = "Lasted longer than its predecessor."
	icon_state = "pacemaker_2"
	maxHealth = 50
