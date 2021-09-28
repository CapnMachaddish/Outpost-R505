//Pool noodles

/obj/item/toy/poolnoodle
	icon = 'modular_R505/icons/obj/toys.dmi'
	icon_state = "noodle"
	name = "pool noodle"
	desc = "A strange, bulky, bendable toy that can annoy people."
	force = 0
	color = "#000000"
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1
	throw_speed = 10 //weeee
	hitsound = 'sound/weapons/tap.ogg'
	attack_verb_continuous = list("flogs", "pokes", "jabs", "annoys")
	attack_verb_simple = list("flog", "poke", "jab", "annoy")
	lefthand_file = 'modular_R505/icons/obj/items_lefthand.dmi'
	righthand_file = 'modular_R505/icons/obj/items_righthand.dmi'

/obj/item/toy/poolnoodle/attack(target as mob, mob/living/user as mob)
	. = ..()
	user.spin(prob(20)? 16 : 8, 1)

/obj/item/toy/poolnoodle/red
	inhand_icon_state = "noodlered"
	color = "#ff4c4c"

/obj/item/toy/poolnoodle/blue
	inhand_icon_state = "noodleblue"
	color = "#3232ff"

/obj/item/toy/poolnoodle/yellow
	inhand_icon_state = "noodleyellow"
	color = "#ffff66"
