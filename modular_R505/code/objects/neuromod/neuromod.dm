//Baguette: my first "original" item, all duct tape and stitches. Anyway, without any further ado:
//AND NOW ITS TIME TO BEAT THE MIND GAME
/obj/item/neuromod
	name = "neuromod"
	desc = "A device that reformats the brain to possess a particular skill or set of skills, using the neural map or connectome of someone who already had said skills as a template."
	icon = 'modular_R505/icons/obj/neuromod.dmi'
	icon_state = "neuromod"
	inhand_icon_state = "neuromod"
	w_class = WEIGHT_CLASS_SMALL
	var/uses = 1
	var/neuro_type = /obj/item/skillchip/connectome
	var/starting_connectome
	var/obj/item/skillchip/connectome/storedconnectome

/obj/item/neuromod/attack_self_tk(mob/user)
	return //stops TK fuckery

/obj/item/neuromod/illegal //For future use. Typhon mods and such.
	name = "experimental neuromod"
	icon_state = "syndicate_autoimplanter"
	desc = "A neuromod, unpainted and larger than normal with an orange sticker bearing a serial code on its back; it's frigid to the touch, heavier than it looks, and the needles..."

/obj/item/neuromod/proc/insert_connectome(obj/item/item)
	storedconnectome = item
	item.forceMove(src)
	name = "[initial(name)] ([storedconnectome.name])"

/obj/item/neuromod/Initialize(mapload)
	. = ..()
	if(starting_connectome)
		insert_connectome(new starting_connectome(src))
	update_appearance()

/obj/item/neuromod/update_overlays() //Called by update_appearance()
	. = ..()
	if(uses != 0 && storedconnectome) //Usable and has connectome
		. += mutable_appearance('modular_R505/icons/obj/neuromod.dmi', "neuromod-ready") //Applies ready status light overlay
		. += mutable_appearance('modular_R505/icons/obj/neuromod.dmi', "neuromod-full")  //Applies full serum overlay
	else if (uses == 0 && !storedconnectome) //Not usable and no connectome
		. += mutable_appearance('modular_R505/icons/obj/neuromod.dmi', "neuromod-used") //Applies used status light overlay
		. += mutable_appearance('modular_R505/icons/obj/neuromod.dmi', "neuromod-empty") //Applies empty serum overlay
	else //Spawned in a plain neuromod or something fucky has happened.
		. += mutable_appearance('modular_R505/icons/obj/neuromod.dmi', "neuromod-error") //Applies error status light overlay
		. += mutable_appearance('modular_R505/icons/obj/neuromod.dmi', "neuromod-empty") //Applies empty serum overlay

/obj/item/neuromod/attack_self(mob/living/carbon/user)//when the object is used //originally mob/user in autosurgeon code, but that didn't work with the skillchip code
	if(!uses)
		to_chat(user, span_alert("[src] has already been used; the needles aren't sterile, and its payload is spent."))
		return
	else if(!storedconnectome)
		to_chat(user, span_alert("[src] does not appear to have a payload; it must be a display piece."))
		return
	user.implant_skillchip(storedconnectome, FALSE)//implant skillchip into the user. organ procs don't work with skillchips
	user.visible_message(span_notice("[user] holds the [src] to their eye for a moment."), span_notice("You feel a sharp sting as [src]'s needles plunge into your eye."))
	playsound(get_turf(user), 'sound/weapons/circsawhit.ogg', 50, TRUE)
	storedconnectome = null
	name += initial(name)
	if(uses != INFINITE)
		uses--
	if(!uses)
		desc = "[initial(desc)] Looks like it's been used up."
	update_appearance()

/obj/item/neuromod/qcarry
	starting_connectome = /obj/item/skillchip/connectome/quickcarry

/obj/item/neuromod/qcarryplus
	starting_connectome = /obj/item/skillchip/connectome/quickercarry

/obj/item/neuromod/chef
	starting_connectome = /obj/item/skillchip/connectome/job/chef

/obj/item/neuromod/robotics
	starting_connectome = /obj/item/skillchip/connectome/job/roboticist

/obj/item/neuromod/engineering
	starting_connectome = /obj/item/skillchip/connectome/job/engineer
