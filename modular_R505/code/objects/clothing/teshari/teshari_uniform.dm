/obj/item/clothing/under/species
	icon = null
	icon_state = null
	worn_icon = null
	sprite_sheets = list()	//Apply when needed
	var/relaytext_cooldown = 0	//This is used because mob_can_equip gets called twice
	var/list/allowed_species = list()
	var/list/reject_text = list()

/obj/item/clothing/under/species/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	. = FALSE

	//Can we equip this under normal standards?
	if(!..())
		return	//Don't relay_rejected_text() here
	
	//Are we a carbon mob?
	if(!iscarbon(M))
		relay_rejected_text(M)
		return
	
	//Do we have DNA, and a set species?
	var/mob/living/carbon/H = M
	if(!H.dna?.species)
		relay_rejected_text(H)
		return
	
	//Does this item allow your species to equip this?
	if(!(H.dna.species.id in allowed_species))
		relay_rejected_text(H)
		return
	
	//If all of the above is true, then we can equip this
	return TRUE

/obj/item/clothing/under/species/proc/relay_rejected_text(mob/M)
	if(world.time > relaytext_cooldown + 0.5 SECONDS && reject_text.len)
		to_chat(M, pick(reject_text))
		relaytext_cooldown = world.time

/obj/item/clothing/under/species/teshari
	icon = 'modular_R505/icons/ported/mob/teshari/clothing/uniform.dmi'
	worn_icon = 'modular_R505/icons/ported/mob/teshari/clothing/uniform.dmi'
	icon_state = "seromi_grey"
	allowed_species = list("teshari")
	reject_text = list(
		"<span class='info'>You can't seem to get a grasp on how to put this on...</span>",
		"<span class='info'>Are you sure this isn't a towel?</span>",
		"<span class='info'>Alright, this is clothing, but where do you put your arms?</span>",
		"<span class='info'>This seems too small to be clothing.</span>"
	)
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/under/species/teshari/smock
	name = "small grey smock"
	desc = "It looks fitted to nonhuman proportions."
	icon_state = "seromi_grey"

/obj/item/clothing/under/species/teshari/smock/white
	name = "small white smock"
	icon_state = "seromi_white"

/obj/item/clothing/under/species/teshari/smock/red
	name = "small Security smock"
	icon_state = "seromi_red"

/obj/item/clothing/under/species/teshari/smock/yellow
	name = "small Engineering smock"
	icon_state = "seromi_yellow"

/obj/item/clothing/under/species/teshari/smock/medical
	name = "small Medical uniform"
	icon_state = "seromi_medical"

/obj/item/clothing/under/species/teshari/smock/science
	name = "small Research uniform"
	icon_state = "teshari_science"

/obj/item/clothing/under/species/teshari/smock/rainbow
	name = "small rainbow smock"
	icon_state = "seromi_rainbow"

/obj/item/clothing/under/species/teshari/smock/dress
	name = "small command dress"
	icon_state = "seromi_dress_cap"

/obj/item/clothing/under/species/teshari/smock/dress/science
	name = "small research dress"
	icon_state = "tesh_dress_science"

/obj/item/clothing/under/species/teshari/smock/dress/security
	name = "small security dress"
	icon_state = "tesh_dress_security"

/obj/item/clothing/under/species/teshari/smock/dress/engine
	name = "small engineering dress"
	icon_state = "tesh_dress_engine"

/obj/item/clothing/under/species/teshari/smock/dress/medical
	name = "small medical dress"
	icon_state = "tesh_dress_medical"

/obj/item/clothing/under/species/teshari/smock/uniform
	name = "small command uniform"
	icon_state = "seromi_captain"

/obj/item/clothing/under/species/teshari/smock/formal
	name = "small formal uniform"
	icon_state = "seromi_captain_formal"

/obj/item/clothing/under/species/teshari/blackutilitysmock
	name = "black utility smock"
	icon_state = "teshari_blackutility_com"

/obj/item/clothing/under/species/teshari/greydress
	name = "small grey dress"
	icon_state = "teshari_greydress"

/obj/item/clothing/under/species/teshari/blackutility
	name = "Teshari utility uniform"
	icon_state = "teshari_blackutility"

/obj/item/clothing/under/species/teshari/bluegreydress
	name = "small blue and grey dress"
	icon_state = "teshari_bluegreydress"

// Worksuits
/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit
	name = "small black and red worksuit"
	icon_state = "teshari_black_red_worksuit"
	desc = "A small worksuit designed for a Teshari"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/blackpurple
	name = "small black and purple worksuit"
	icon_state = "teshari_black_purple_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/blackorange
	name = "small black and orange worksuit"
	icon_state = "teshari_black_orange_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/blackblue
	name = "small black and blue worksuit"
	icon_state = "teshari_black_blue_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/blackgreen
	name = "small black and greeen worksuit"
	icon_state = "teshari_black_green_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/whitered
	name = "small white and red worksuit"
	icon_state = "teshari_white_red_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/whitepurple
	name = "small white and purple worksuit"
	icon_state = "teshari_white_purple_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/whiteorange
	name = "small white and orange worksuit"
	icon_state = "teshari_white_orange_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/whiteblue
	name = "small white and blue worksuit"
	icon_state = "teshari_white_blue_worksuit"

/obj/item/clothing/under/species/teshari/undercoat/standard/worksuit/whitegreen
	name = "small white and green worksuit"
	icon_state = "teshari_white_green_worksuit"

//Standard Undercoats

//TODO: Sprite directions for these, this whole file is confusing. None of these are used right now anyways
/obj/item/clothing/under/species/teshari/undercoat
	name = "Undercoat"
	desc =  "A Teshari traditional garb, with a modern twist! Made of micro and nanofibres to make it light and billowy, perfect for going fast and stylishly!"
	icon = 'modular_R505/icons/ported/mob/teshari/clothing/teshari_uniform.dmi'
	worn_icon = 'modular_R505/icons/ported/mob/teshari/clothing/teshari_uniform.dmi'
	icon_state = "tesh_uniform_bo"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_orange
	name = "black and orange undercoat"
	icon_state = "tesh_uniform_bo"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_grey
	name = "black and grey undercoat"
	icon_state = "tesh_uniform_bg"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_white
	name = "black and white undercoat"
	icon_state = "tesh_uniform_bw"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_red
	name = "black and red undercoat"
	icon_state = "tesh_uniform_br"

/obj/item/clothing/under/species/teshari/undercoat/standard/black
	name = "black undercoat"
	icon_state = "tesh_uniform_bn"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_yellow
	name = "black and yellow undercoat"
	icon_state = "tesh_uniform_by"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_green
	name = "black and green undercoat"
	icon_state = "tesh_uniform_bgr"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_blue
	name = "black and blue undercoat"
	icon_state = "tesh_uniform_bbl"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_purple
	name = "black and purple undercoat"
	icon_state = "tesh_uniform_bp"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_pink
	name = "black and pink undercoat"
	icon_state = "tesh_uniform_bpi"

/obj/item/clothing/under/species/teshari/undercoat/standard/black_brown
	name = "black and brown undercoat"
	icon_state = "tesh_uniform_bbr"

/obj/item/clothing/under/species/teshari/undercoat/standard/orange_grey
	name = "orange and grey undercoat"
	icon_state = "tesh_uniform_og"

/obj/item/clothing/under/species/teshari/undercoat/standard/rainbow
	name = "rainbow undercoat"
	icon_state = "tesh_uniform_rainbow"

/obj/item/clothing/under/species/teshari/undercoat/standard/lightgrey_grey
	name = "light grey and grey undercoat"
	icon_state = "tesh_uniform_lgg"

/obj/item/clothing/under/species/teshari/undercoat/standard/white_grey
	name = "white and grey undercoat"
	icon_state = "tesh_uniform_wg"

/obj/item/clothing/under/species/teshari/undercoat/standard/red_grey
	name = "red and grey undercoat"
	icon_state = "tesh_uniform_rg"

/obj/item/clothing/under/species/teshari/undercoat/standard/orange
	name = "orange undercoat"
	icon_state = "tesh_uniform_on"

/obj/item/clothing/under/species/teshari/undercoat/standard/yellow_grey
	name = "yellow and grey undercoat"
	icon_state = "tesh_uniform_yg"

/obj/item/clothing/under/species/teshari/undercoat/standard/green_grey
	name = "green and grey undercoat"
	icon_state = "tesh_uniform_gg"

/obj/item/clothing/under/species/teshari/undercoat/standard/blue_grey
	name = "blue and grey undercoat"
	icon_state = "tesh_uniform_blug"

/obj/item/clothing/under/species/teshari/undercoat/standard/purple_grey
	name = "purple and grey undercoat"
	icon_state = "tesh_uniform_pg"

/obj/item/clothing/under/species/teshari/undercoat/standard/pink_grey
	name = "pink and grey undercoat"
	icon_state = "tesh_uniform_pig"

/obj/item/clothing/under/species/teshari/undercoat/standard/brown_grey
	name = "brown and grey undercoat"
	icon_state = "tesh_uniform_brg"

//Job Undercoats

/obj/item/clothing/under/species/teshari/undercoat/jobs
	icon = 'modular_R505/icons/ported/mob/teshari/clothing/deptjacket.dmi'
	worn_icon = 'modular_R505/icons/ported/mob/teshari/clothing/deptjacket.dmi'

/obj/item/clothing/under/species/teshari/undercoat/jobs/cap
	name = "captain undercoat"
	desc = "A traditional Teshari garb made for the Captain"
	icon_state = "tesh_uniform_cap_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/hop
	name = "head of personnel undercoat"
	desc = "A traditional Teshari garb made for the Head of Personnel"
	icon_state = "tesh_uniform_hop_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/ce
	name = "cheif engineer undercoat"
	desc = "A traditional Teshari garb made for the Chief Engineer"
	icon_state = "tesh_uniform_ce_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/hos
	name = "head of security undercoat"
	desc = "A traditional Teshari garb made for the Head of Security"
	icon_state = "tesh_uniform_hos_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/rd
	name = "research director undercoat"
	desc = "A traditional Teshari garb made for the Research Director"
	icon_state = "tesh_uniform_rd_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/engineer
	name = "engineering undercoat"
	desc = "A traditional Teshari garb made for the Engineering department"
	icon_state = "tesh_uniform_engie_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/atmos
	name = "atmospherics undercoat"
	desc = "A traditional Teshari garb made for the Atmospheric Technician"
	icon_state = "tesh_uniform_atmos_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/cmo
	name = "chief medical officer undercoat"
	desc = "A traditional Teshari garb made for the Cheif Medical Officer"
	icon_state = "tesh_uniform_cmo_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/qm
	name = "quartermaster undercoat"
	desc = "A traditional Teshari garb made for the Quartermaster"
	icon_state = "tesh_uniform_qm_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/cargo
	name = "cargo undercoat"
	desc = "A traditional Teshari garb made for the Cargo department"
	icon_state = "tesh_uniform_car_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/mining
	name = "mining undercoat"
	desc = "A traditional Teshari garb made for Mining"
	icon_state = "tesh_uniform_mine_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/medical
	name = "medical undercoat"
	desc = "A traditional Teshari garb made for the Medical department"
	icon_state = "tesh_uniform_doc_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/chemistry
	name = "chemist undercoat"
	desc = "A traditional Teshari garb made for the Chemist"
	icon_state = "tesh_uniform_chem_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/viro
	name = "virologist undercoat"
	desc = "A traditional Teshari garb made for the Virologist"
	icon_state = "tesh_uniform_viro_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/psych
	name = "psychologist undercoat"
	desc = "A traditional Teshari garb made for the Psychologist"
	icon_state = "tesh_uniform_psych_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/para
	name = "paramedic undercoat"
	desc = "A traditional Teshari garb made for the Paramedic"
	icon_state = "tesh_uniform_para_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/sci
	name = "scientist undercoat"
	desc = "A traditional Teshari garb made for the Science department"
	icon_state = "tesh_uniform_sci_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/robo
	name = "roboticist undercoat"
	desc = "A traditional Teshari garb made for the Roboticist"
	icon_state = "tesh_uniform_robo_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/sec
	name = "security undercoat"
	desc = "A traditional Teshari garb made for the Security department"
	icon_state = "tesh_uniform_sec_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/service
	name = "service undercoat"
	desc = "A traditional Teshari garb made for the Service department"
	icon_state = "tesh_uniform_serv_s"

/obj/item/clothing/under/species/teshari/undercoat/jobs/iaa
	name = "internal affairs undercoat"
	desc = "A traditional Teshari garb made for the Internal Affairs Agent"
	icon_state = "tesh_uniform_iaa_s"
