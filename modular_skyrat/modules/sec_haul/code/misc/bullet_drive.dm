/obj/machinery/dish_drive/bullet
	name = "bullet drive"
	desc = "A modified verison of the dish drive, for security. Because they're lazy."
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/bulletdrive.dmi'
	icon_state = "synthesizer"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/dish_drive/bullet
	collectable_items = list(/obj/item/ammo_casing)
	succrange = 10
	binrange = 10

/obj/item/circuitboard/machine/dish_drive/bullet
	name = "Bullet Drive (Machine Board)"
	icon_state = "service"
	build_path = /obj/machinery/dish_drive/bullet
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/matter_bin = 2)
	needs_anchored = TRUE

/obj/machinery/dish_drive/bullet/do_the_dishes(manual)
	if(!LAZYLEN(dish_drive_contents))
		if(manual)
			visible_message("<span class='notice'>[src] is empty!</span>")
		return
	var/obj/machinery/disposal/bin/bin = locate() in view(binrange, src) //SKYRAT EDIT CHANGE
	if(!bin)
		if(manual)
			visible_message("<span class='warning'>[src] buzzes. There are no disposal bins in range!</span>")
			playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
		return
	var/disposed = 0
	for(var/obj/item/ammo_casing/A in dish_drive_contents)
		if(!A.loaded_projectile)
			LAZYREMOVE(dish_drive_contents, A)
			qdel(A)
			use_power(active_power_usage)
			disposed++
	if(disposed)
		visible_message("<span class='notice'>[src] [pick("whooshes", "bwooms", "fwooms", "pshooms")] and demoleculizes [disposed] stored item\s into the nearby void.</span>")
		playsound(src, 'sound/items/pshoom.ogg', 50, TRUE)
		playsound(bin, 'sound/items/pshoom.ogg', 50, TRUE)
		flick("synthesizer_beam", src)
	else
		visible_message("<span class='notice'>There are no disposable items in [src]!</span>")
	time_since_dishes = world.time + 600

/obj/machinery/dish_drive/bullet/process()
	if(time_since_dishes <= world.time && transmit_enabled)
		do_the_dishes()
	if(!suction_enabled)
		return
	for(var/obj/item/I in view(succrange, src))
		if(istype(I, /obj/machinery/dish_drive/bullet))
			visible_message("<span class='userdanger'>[src] has detected another bullet drive nearby, and is sad!</span>")
			break
		if(is_type_in_list(I, collectable_items) && I.loc != src && (!I.reagents || !I.reagents.total_volume))
			if(I.Adjacent(src))
				LAZYADD(dish_drive_contents, I)
				visible_message("<span class='notice'>[src] beams up [I]!</span>")
				I.moveToNullspace()
				playsound(src, 'sound/items/pshoom.ogg', 50, TRUE)
				flick("synthesizer_beam", src)
			else
				step_towards(I, src)
