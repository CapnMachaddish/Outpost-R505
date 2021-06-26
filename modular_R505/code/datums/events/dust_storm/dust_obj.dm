/obj/effect/meteor/dust/weak
	hitpwr = EXPLODE_NONE

/obj/effect/meteor/dust/weak/Move()
	. = ..()
	if(.)
		for(var/thing in get_turf(src))
			var/met = FALSE
			if(isstructure(thing) || ismachinery(thing))
				met = TRUE
				var/obj/O = thing
				if(!O.density)
					continue
				if(istype(O, /obj/structure/window))
					O.take_damage(1, BRUTE, MELEE)	//Less damage because there's trillions of this dust
				else
					O.take_damage(10, BRUTE, MELEE)
			else if(isliving(thing))
				met = TRUE
				var/mob/living/L = thing
				L.apply_damage(10, BRUTE, pick(BODY_ZONE_CHEST, BODY_ZONE_HEAD))
				L.visible_message("<span class='warning'>[src] slams into [L].</span>", "<span class='userdanger'>[src] slams into you!.</span>")
			if(met && prob(10))
				get_hit()

/obj/effect/meteor/dust/weak/make_debris()
	for(var/throws = dropamt, throws > 0, throws--)
		if(prob(10))
			var/spawnthing = pick(meteordrop)
			new spawnthing(get_turf(src))
