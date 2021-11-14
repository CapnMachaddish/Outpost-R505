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



//I stole this bullshit from Warp Cubes
/obj/effect/temp_visual/cloak_field
	duration = 10
	var/decloak = FALSE

/obj/effect/temp_visual/cloak_field/Initialize(mapload, atom/cloaker, effect_color, new_decloak)
	. = ..()
	if(cloaker)
		decloak = new_decloak
		appearance = cloaker.appearance
		setDir(cloaker.dir)
		if(effect_color)
			color = list(effect_color, effect_color, effect_color, list(0,0,0))
			set_light(1.4, 1, effect_color)
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		var/matrix/new_transform = transform
		if(decloak)
			transform = new_transform * 1.2
			new_transform = cloaker.transform
			alpha = 0
			animate(src, alpha = 255, transform = new_transform, time = duration)
		else
			new_transform *= 1.2
			animate(src, alpha = 0, transform = new_transform, time = duration)
	else
		return INITIALIZE_HINT_QDEL

/datum/action/item_action/engage_cloak
	name = "Engage Stealth Field"
	desc = "Activate your cloaking device and fade from view."
	check_flags = AB_CHECK_CONSCIOUS
	background_icon_state = "bg_tech"
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "ninja_cloak"
	var/cloaked = FALSE
	COOLDOWN_DECLARE(cloak_cooldown)

/datum/action/item_action/engage_cloak/Grant(mob/M)
	. = ..()
	RegisterSignal(target, COMSIG_ATOM_EMP_ACT, .proc/cloak_emp)

/datum/action/item_action/engage_cloak/Trigger()
	. = ..()
	if(!.)
		return FALSE
	if(!COOLDOWN_FINISHED(src, cloak_cooldown))
		return
	COOLDOWN_START(src, cloak_cooldown, 5 SECONDS)
	if(isliving(owner))
		var/mob/living/cloaker = owner
		cloaker.SetImmobilized(10, TRUE)
	if(cloaked)
		background_icon_state = "bg_tech"
		UpdateButtonIcon()
		cloak_off()
		cloaked = FALSE
		return 2
	else
		background_icon_state = "bg_tech_on"
		UpdateButtonIcon()
		cloak_on()
		cloaked = TRUE
		return 1

/datum/action/item_action/engage_cloak/proc/cloak_on()
	playsound(owner, 'modular_R505/sound/effects/cloak_on.ogg', 50, FALSE)
	new /obj/effect/temp_visual/cloak_field(get_turf(owner), owner, "#48ff00", FALSE)
	animate(owner, alpha = 0, time = 10)
	sleep(10)
	owner.alpha = 0
	owner.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/datum/action/item_action/engage_cloak/proc/cloak_off()
	playsound(owner, 'modular_R505/sound/effects/cloak_on.ogg', 50, FALSE)
	new /obj/effect/temp_visual/cloak_field(get_turf(owner), owner, "#48ff00", TRUE)
	animate(owner, alpha = 255, time = 10)
	sleep(10)
	owner.alpha = 255
	owner.mouse_opacity = MOUSE_OPACITY_ICON

/datum/action/item_action/engage_cloak/proc/cloak_emp(source, severity)
	playsound(owner, get_sfx("sparks"), 25, FALSE)
	new /obj/effect/temp_visual/emp
	cloak_off()
	COOLDOWN_START(src, cloak_cooldown, severity * 10)

/obj/item/organ/cyberimp/chest/cloaking
	name = "stealth field implant"
	desc = "A marvel of classified stealth technology, this implant shrouds your body in a sophisticated holographic active camouflage field, rendering you invisible to all but the most sophisticated detection systems."
	icon_state = "heart-c-u2-on"
	color = "#48ff00"
	actions_types = list(/datum/action/item_action/engage_cloak)

/obj/item/organ/cyberimp/chest/cloaking/emp_act(severity)
	. = ..()

	