//AND NOW ITS TIME TO BEAT THE MIND GAME
/obj/item/neuromod
	name = "neuromod"
	desc = "A device that reformats the brain to possess a particular skill or set of skills, using the neural map or connectome of someone who already had said skills as a template."
	icon = 'icons/obj/device.dmi'
	icon_state = "autoimplanter"
	inhand_icon_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL

	var/uses = 1
	var/neuro_type = /obj/item/skillchip/connectome
	var/starting_connectome
	var/obj/item/skillchip/connectome/storedorgan


/obj/item/neuromod/illegal
	name = "experimental neuromod"
	icon_state = "syndicate_autoimplanter"
	desc = "A neuromod, unpainted and larger than normal with an orange sticker bearing a serial code on its back; it's frigid to the touch, heavier than you'd expect, and the needles..."

/obj/item/neuromod/attack_self_tk(mob/user)
	return //stops TK fuckery

/obj/item/neuromod/proc/insert_organ(obj/item/item)
	storedorgan = item
	item.forceMove(src)
	name = "[initial(name)] ([storedorgan.name])"

/obj/item/neuromod/Initialize(mapload)
	. = ..()
	if(starting_connectome)
		insert_connectome(new starting_connectome(src))

/obj/item/neuromod/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, span_alert("[src] has already been used; the needles aren't sterile, and its payload is spent."))
		return
	else if(!storedorgan)
		to_chat(user, span_alert("[src] does not appear to have a payload; it must be a display piece."))
		return
	storedorgan.Insert(user)//insert stored organ into the user
	user.visible_message(span_notice("[user] holds the [src] to their eye for a moment."), span_notice("You feel a sharp sting as [src]'s needles plunge into your eye."))
	playsound(get_turf(user), 'sound/weapons/circsawhit.ogg', 50, TRUE)
	storedorgan = null
	name += initial(name)
	if(uses != INFINITE)
		uses--
	if(!uses)
		desc = "[initial(desc)] Looks like it's been used up."
