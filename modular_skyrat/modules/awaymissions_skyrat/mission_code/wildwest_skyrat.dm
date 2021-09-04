// Loot drops
/obj/effect/spawner/lootdrop/wildwest/cash
	name = "wild west cash"
	fan_out_items = TRUE
	loot = list(
		/obj/item/stack/spacecash/c500,
		/obj/item/stack/spacecash/c100
	)

/obj/effect/mob_spawn/human/wildwest_syndicate
	name = "lost syndicate cryopod"
	desc = "They've been here long, far too long..."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	short_desc = "A scientist lost to time within an evil and everchanging labyrinth. Try to wait for the Vanguard to get close before you take this role or else you WILL be bored."
	flavour_text = "You are a scientist, lost and afraid on a mission you didn't want to go on. \
	The Commando in charge of you is just outside, he killed everyone else. \
	You locked yourself in the ship's engine room just in time before he got you. \
	You have... a gun with you; one shot. Just in case nobody comes for you. \
	At this point, you don't care who it is, you need to escape."
	outfit = /datum/outfit/wildwest_syndicate
	can_use_alias = TRUE
	any_station_species = TRUE

/datum/outfit/wildwest_syndicate
	name = "Abandoned Syndicate"
	uniform = /obj/item/clothing/under/utility/sci/syndicate
	shoes = /obj/item/clothing/shoes/combat
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	r_pocket = /obj/item/radio

/turf/closed/mineral/wildwest
	baseturfs = /turf/open/floor/plating/ironsand
