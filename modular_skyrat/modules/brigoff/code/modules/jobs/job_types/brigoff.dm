/datum/job/brigoff
	title = "Corrections Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Warden and Head of Security")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Warden and Head of Security"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 150
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	outfit = /datum/outfit/job/brigoff
	plasmaman_outfit = /datum/outfit/plasmaman/security
	display_order = JOB_DISPLAY_ORDER_BRIGOFF
	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)
	departments_list = list(
		/datum/job_department/security,
	)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/job/brigoff/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	to_chat(M, "<span class='userdanger'>You are a <b><u>GUARD</b></u> not a Security Officer, do <b><u>NOT</b></u> run off and be Security unless it's red alert!.")
	to_chat(M, "<span class='warning'>You shouldn't leave the brig for long peroids of time. <b>Remember: You aren't a Security Officer.</b>")
	to_chat(M, "<b>You are a Brig Officer of the Frontier Space Station 13, your duties include Prisoner escort and ensuring the Prisoners stay in line.</b>")




/datum/outfit/job/brigoff
	name = "Corrections Officer"
	jobtype = /datum/job/brigoff
	uniform = /obj/item/clothing/under/rank/security/brigguard/sweater
	suit = /obj/item/clothing/suit/toggle/jacket/brigoff
	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/headset_sec
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(/obj/item/melee/classic_baton/peacekeeper, /obj/item/restraints/handcuffs = 2, /obj/item/gun/energy/taser/armadyne)
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/security/peacekeeper
	satchel = /obj/item/storage/backpack/satchel/sec/peacekeeper
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/peacekeeper
	head = /obj/item/clothing/head/brigoff
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/pda/security

	id_trim = /datum/id_trim/job/brigoff



