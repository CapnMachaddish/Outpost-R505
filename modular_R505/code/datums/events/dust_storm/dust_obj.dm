/obj/effect/meteor/dust/weak
	hitpwr = EXPLODE_NONE

/obj/effect/meteor/dust/weak/Move()
	. = ..()
	if(.)
		for(var/obj/structure/lattice/thing in get_turf(src))
			if(thing.type == /obj/structure/lattice)	//Don't remove catwalks
				qdel(thing)

/obj/effect/meteor/dust/weak/ram_turf(turf/T)	//We don't explode, so this is the next best thing
	for(var/thing in T)
		if(isstructure(thing) || ismachinery(thing))
			var/obj/O = thing
			if(!O.density)
				continue
			if(istype(O, /obj/structure/window))
				O.take_damage(1, BRUTE, MELEE)	//Less damage because there's trillions of this dust
			else
				O.take_damage(10, BRUTE, MELEE)
		else if(isliving(thing))
			var/mob/living/L = thing
			L.apply_damage(10, BRUTE, pick(BODY_ZONE_CHEST, BODY_ZONE_HEAD))
			L.visible_message("<span class='warning'>[src] slams into [L].</span>", "<span class='userdanger'>[src] slams into you!.</span>")
