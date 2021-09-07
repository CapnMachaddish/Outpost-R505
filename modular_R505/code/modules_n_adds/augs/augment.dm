/obj/item/organ/cyberimp/mouth/breathing_tube/empproof
	name = "breathing tube implant"
	desc = "This simple implant adds an internals connector to your back, allowing you to use internals without a mask and protecting you from being choked."
	icon_state = "implant_mask"
	slot = ORGAN_SLOT_BREATHING_TUBE
	w_class = WEIGHT_CLASS_TINY
	organ_flags = EMP_PROTECT_SELF

/obj/item/organ/cyberimp/arm/toolset/empproof
	name = "integrated toolset implant"
	desc = "A stripped-down version of the engineering cyborg toolset, designed to be installed on subject's arm. Contain advanced versions of every tool."
	contents = newlist(/obj/item/screwdriver/cyborg, /obj/item/wrench/cyborg, /obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/cyborg)
	organ_flags = EMP_PROTECT_SELF

/obj/item/organ/cyberimp/arm/toolset/empproof/l
	zone = BODY_ZONE_L_ARM
