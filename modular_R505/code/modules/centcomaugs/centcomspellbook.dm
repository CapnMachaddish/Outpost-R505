/obj/item/spellbook/centcom
	name = "Magical Grimoire"
	uses = 900

/obj/item/book/granter/spell/ccteleport
	spell = /obj/effect/proc_holder/spell/targeted/area_teleport/teleport/centcom
	spellname = "teleport"
	icon_state ="book7"
	desc = "This book seems to jaunt around in your hand."
	remarks = list("I can't look away from the book!", "The words seem to pop around the page...", "I just need to focus on one location...", "Make sure to have a good grip on it when casting...", "Slow down, book. I still haven't finished this page...", "Sounds pretty great with some other magical artifacts...", "Magicians must love this one.")
	pages_to_mastery = 1

/obj/item/book/granter/spell/ccteleport/recoil(mob/user)
	..()
	to_chat(user,"<span class='warning'>[src] suddenly vanishes!</span>")
	qdel(src)

/obj/item/book/granter/spell/ccphaseshift
	spell = /obj/effect/proc_holder/spell/targeted/ethereal_jaunt/shift/adminbus
	spellname = "phase shift"
	icon_state ="book1"
	desc = "This book is old and frayed, it seems barely in this reality."
	remarks = list("I can't see the book!", "The words seem to fade in and out...", "I just need to focus on myself...", "Make sure to have a good stomach when casting...", "Slow down, book. I still haven't finished this page...", "Sounds pretty great with some other magical artifacts...", "Magicians must love this one.")
	pages_to_mastery = 1

/obj/item/book/granter/spell/ccphaseshift/recoil(mob/user)
	..()
	to_chat(user,"<span class='warning'>[src] suddenly vanishes!</span>")
	qdel(src)