#define CALIBRE_14MM "14mm"

/////////////////////////////
// Malorian Arms 3516 14MM //
//     If you have this,   //
//     you're a badass.    //
/////////////////////////////

//This pistol can only be fired if you have a robotic arm, it checks the arm you are firing
/obj/item/gun/ballistic/automatic/pistol/j3516
	name = "Malorian Arms 3516"
	desc = "The Malorian Arms 3516 is a 14mm heavy pistol, sporting a titanium frame and unique wooden grip. A custom Dyna-porting and \
	direct integral cyber-interlink means only someone with a cyberarm and smartgun link can take full advantage of the pistol's features."
	icon = 'modular_skyrat/modules/3516/icons/3516.dmi'
	icon_state = "3516"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m14mm
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/3516/sound/fire2.ogg'
	load_sound = 'modular_skyrat/modules/3516/sound/reload.ogg'
	load_empty_sound = 'modular_skyrat/modules/3516/sound/reload.ogg'
	eject_sound = 'modular_skyrat/modules/3516/sound/release.ogg'
	eject_empty_sound = 'modular_skyrat/modules/3516/sound/release.ogg'
	vary_fire_sound = FALSE
	rack_sound = 'modular_skyrat/modules/3516/sound/slide.ogg'
	fire_sound_volume = 100
	bolt_wording = "fuckin' slide"

//Gun actions

//The gun cannot shoot if you do not have a cyborg arm.
/obj/item/gun/ballistic/automatic/pistol/j3516/afterattack(atom/target, mob/living/user, flag, params)
	//This is where we are checking if the user has a cybernetic arm to USE the gun. ROBOHAND HAS A ROBO HAND
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/bodypart/selected_hand = H.get_active_hand()
		if(selected_hand.status != BODYPART_ROBOTIC)
			to_chat(user, "<span class='warning'>You can't seem to figure out how to use [src], perhaps you need to check the manual?")
			return
	. = ..()

/obj/item/gun/ballistic/automatic/pistol/j3516/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	if(!istype(AM, mag_type))
		to_chat(user, "<span class='warning'>\The [AM] doesn't seem to fit into \the [src]...</span>")
		return FALSE
	if(user.transferItemToLoc(AM, src))
		magazine = AM
		if (display_message)
			to_chat(user, "<span class='notice'>You load a new [magazine_wording] into \the [src].</span>")
		playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			chamber_round(TRUE)
		drop_bolt(user)
		update_appearance()
		animate(src, transform = turn(matrix(), 120), time = 2, loop = 1) //Le johnny robohand woosh woosh twirl
		animate(transform = turn(matrix(), 240), time = 2)
		animate(transform = null, time = 2)
		return TRUE
	else
		to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")
		return FALSE



/obj/item/gun/ballistic/automatic/pistol/j3516/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if (magazine.ammo_count())
		playsound(src, eject_sound, eject_sound_volume, eject_sound_volume) //This is why we've copied this proc, it should play the eject sound when ejecting.
	else
		playsound(src, eject_empty_sound, eject_sound_volume, eject_sound_volume)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/old_mag = magazine
	if (tac_load)
		if (insert_magazine(user, tac_load, FALSE))
			to_chat(user, "<span class='notice'>You perform an elite tactical reload on \the [src].</span>")
		else
			to_chat(user, "<span class='warning'>You dropped the old [magazine_wording], but the new one doesn't fit. How embarassing.</span>")
			magazine = null
	else
		magazine = null
	user.put_in_hands(old_mag)
	old_mag.update_appearance()
	if (display_message)
		to_chat(user, "<span class='notice'>You pull the [magazine_wording] out of \the [src].</span>")
	update_appearance()
	animate(src, transform = turn(matrix(), 120), time = 2, loop = 1) //Le johnny robohand again
	animate(transform = turn(matrix(), 240), time = 2)
	animate(transform = null, time = 2)

//Magazine stuff

/obj/item/ammo_box/magazine/m14mm
	name = "pistol magazine (14mm)"
	icon = 'modular_skyrat/modules/3516/icons/3516_mag.dmi'
	icon_state = "14mm"
	base_icon_state = "14mm"
	ammo_type = /obj/item/ammo_casing/c14mm
	caliber = CALIBRE_14MM
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/c14mm
	name = "14mm bullet casing"
	desc = "A 14mm bullet casing. Badass."
	caliber = CALIBRE_14MM
	projectile_type = /obj/projectile/bullet/c14mm

/obj/projectile/bullet/c14mm
	name = "14mm bullet"
	damage = 60
	embedding = list(embed_chance=90, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=9, rip_time=10)
	dismemberment = 50
	pierces = 1
	projectile_piercing = PASSCLOSEDTURF|PASSGRILLE|PASSGLASS
