/datum/job/botanist
	title = "Botanist"
	department_head = list("Head of Personnel")
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the head of personnel"
	selection_color = "#bbe291"

	outfit = /datum/outfit/job/botanist
	species_outfit = list("plasmaman" = /datum/outfit/plasmaman/botany, "teshari" = /datum/outfit/teshari/botanist)

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BOTANIST
	bounty_types = CIV_JOB_GROW
	departments = DEPARTMENT_SERVICE

	family_heirlooms = list(/obj/item/cultivator, /obj/item/reagent_containers/glass/bucket, /obj/item/toy/plush/beeplushie)

	mail_goodies = list(
		/datum/reagent/toxin/mutagen = 20,
		/datum/reagent/saltpetre = 20,
		/datum/reagent/diethylamine = 20,
		/obj/item/gun/energy/floragun = 10,
		/obj/effect/spawner/lootdrop/space/rareseed = 5,// These are strong, rare seeds, so use sparingly.
		/obj/item/food/monkeycube/bee = 2
	)

/datum/outfit/job/botanist
	name = "Botanist"
	jobtype = /datum/job/botanist

	belt = /obj/item/pda/botanist
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/hydroponics
	suit = /obj/item/clothing/suit/apron
	gloves  =/obj/item/clothing/gloves/botanic_leather
	suit_store = /obj/item/plant_analyzer

	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel/hyd
	duffelbag = /obj/item/storage/backpack/duffelbag/hydroponics

	id_trim = /datum/id_trim/job/botanist
