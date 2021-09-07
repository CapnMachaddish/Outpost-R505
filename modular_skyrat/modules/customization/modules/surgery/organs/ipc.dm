/obj/item/organ/brain/ipc_positron
	name = "positronic brain carcass"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"

/obj/item/organ/brain/ipc_positron/Insert(mob/living/carbon/user, special = 0, drop_if_replaced = TRUE)
	..()
	if(user.stat == DEAD && ishuman(user))
		var/mob/living/carbon/human/user_human = user
		if(user_human?.dna?.species && (REVIVES_BY_HEALING in user_human.dna.species.species_traits))
			if(user_human.health > 50)
				user_human.revive(FALSE)

/obj/item/organ/brain/ipc_positron/emp_act(severity)
	switch(severity)
		if(1)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 75, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain heavily damaged.</span>")
		if(2)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain damaged.</span>")

/obj/item/organ/stomach/robot_ipc
	name = "IPC micro cell"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "stomach-ipc"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	desc = "A specialised cell, for IPC use only. Do not swallow."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/stomach/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, "<span class='warning'>Alert: Detected severe battery discharge!</span>")
		if(2)
			owner.nutrition = 250
			to_chat(owner, "<span class='warning'>Alert: Minor battery discharge!</span>")

/obj/item/organ/ears/robot_ipc
	name = "auditory sensors"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "ears-ipc"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/ears/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.Jitter(30)
			owner.Dizzy(30)
			owner.Knockdown(80)
			deaf = 30
			to_chat(owner, "<span class='warning'>Your robotic ears are ringing, uselessly.</span>")
		if(2)
			owner.Jitter(15)
			owner.Dizzy(15)
			owner.Knockdown(40)
			to_chat(owner, "<span class='warning'>Your robotic ears buzz.</span>")

/obj/item/organ/tongue/robot_ipc
	name = "robotic voicebox"
	desc = "A voice synthesizer that can interface with organic lifeforms."
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "tongue-ipc"
	say_mod = "beeps"
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	maxHealth = 100 //RoboTongue!
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/robot_ipc/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/eyes/robot_ipc
	name = "robotic eyes"
	icon_state = "cybernetic_eyeballs"
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/eyes/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	to_chat(owner, "<span class='warning'>Static obfuscates your vision!</span>")
	owner.flash_act(visual = 1)
	if(severity == EMP_HEAVY)
		owner.adjustOrganLoss(ORGAN_SLOT_EYES, 20)

/obj/item/organ/lungs/robot_ipc
	name = "heat sink"
	desc = "A device that transfers generated heat to a fluid medium to cool it down. Required to keep your synthetics cool-headed. It's shape resembles lungs." //Purposefully left the 'fluid medium' ambigious for interpretation of the character, whether it be air or fluid cooling
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "lungs-ipc"
	safe_nitro_min = 0
	safe_nitro_max = 0
	safe_co2_min = 0
	safe_co2_max = 0
	safe_plasma_min = 0
	safe_plasma_max = 0
	safe_oxygen_min = 0	//What are you doing man, dont breathe with those!
	safe_oxygen_max = 0
	cold_level_1_damage = 0
	cold_level_2_damage = 0
	cold_level_3_damage = 0
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/lungs/robot_ipc/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			to_chat(owner, "<span class='warning'>Alert: Critical cooling system failure!</span>")
			owner.adjust_bodytemperature(100*TEMPERATURE_DAMAGE_COEFFICIENT)
		if(2)
			owner.adjust_bodytemperature(30*TEMPERATURE_DAMAGE_COEFFICIENT)

/obj/item/organ/heart/robot_ipc
	name = "hydraulic pump engine"
	desc = "An electronic device that handles the hydraulic pumps, powering one's robotic limbs."
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "heart-ipc"

/obj/item/organ/liver/robot_ipc
	name = "reagent processing unit"
	desc = "An electronic device that processes the beneficial chemicals for the synthetic user."
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "liver-c"
	filterToxins = FALSE //We dont filter them, we're immune ot them

/obj/item/organ/cyberimp/arm/power_cord
	name = "power cord implant"
	desc = "An internal power cord hooked up to a battery. Useful if you run on volts."
	contents = newlist(/obj/item/apc_powercord)
	zone = "l_arm"

/obj/item/apc_powercord
	name = "power cord"
	desc = "An internal power cord hooked up to a battery. Useful if you run on electricity. Not so much otherwise."
	icon = 'icons/obj/power.dmi'
	icon_state = "wire1"

/obj/item/apc_powercord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!istype(target, /obj/machinery/power/apc) || !ishuman(user) || !proximity_flag)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/machinery/power/apc/target_apc = target
	var/mob/living/carbon/human/ipc = user
	var/obj/item/organ/stomach/robot_ipc/cell = locate(/obj/item/organ/stomach/robot_ipc) in ipc.internal_organs
	if(!cell)
		to_chat(ipc, "<span class='warning'>You try to siphon energy from the [target_apc], but your power cell is gone!</span>")
		return

	if(target_apc.cell && target_apc.cell.charge > 0)
		if(ipc.nutrition >= NUTRITION_LEVEL_WELL_FED)
			to_chat(user, "<span class='warning'>You are already fully charged!</span>")
			return
		else
			powerdraw_loop(target_apc, ipc)
			return

	to_chat(user, "<span class='warning'>There is no charge to draw from that APC.</span>")

#define IPC_CHARGE_MAX 150
#define IPC_CHARGE_MIN 50
#define IPC_CHARGE_PER_NUTRITION 10
#define IPC_CHARGE_DELAY_PER_100 10

/obj/item/apc_powercord/proc/powerdraw_loop(obj/machinery/power/apc/target_apc, mob/living/carbon/human/user)
	user.visible_message("<span class='notice'>[user] inserts a power connector into the [target_apc].</span>", "<span class='notice'>You begin to draw power from the [target_apc].</span>")

	while(TRUE)
		var/power_needed = NUTRITION_LEVEL_WELL_FED - user.nutrition // How much charge do we need in total?
		// Do we even need anything?
		if(power_needed <= 0)
			to_chat(user, "<span class='notice'>You are fully charged.</span>")
			break
		// Is the APC almost empty?
		if(target_apc.cell.percent() < 10)
			to_chat(user, "<span class='warning'>[target_apc]'s emergency power is active.</span>")
			break
		// Calculate how much to draw this cycle
		var/power_use = clamp(power_needed, IPC_CHARGE_MIN, IPC_CHARGE_MAX)
		power_use = clamp(power_use, 0, target_apc.cell.charge)
		// Are we able to draw anything?
		if(power_use==0)
			to_chat(user, "<span class='warning'>[target_apc] lacks the power to charge you.</span>")
			break
		// Calculate the delay.
		var/power_delay = (power_use/100) * IPC_CHARGE_DELAY_PER_100
		// Attempt to run a charging cycle.
		if(!do_after(user, power_delay, target = target_apc))
			to_chat(user, "<span class='warning'>You accidentally rip the powercord from [target_apc].</span>")
			break
		// Use the power and increase nutrition.
		target_apc.cell.use(power_use)
		user.nutrition += power_use / IPC_CHARGE_PER_NUTRITION
		do_sparks(1, FALSE, target_apc)

	user.visible_message("<span class='notice'>[user] unplugs from the [target_apc].</span>", "<span class='notice'>You unplug from the [target_apc].</span>")

#undef IPC_CHARGE_MAX
#undef IPC_CHARGE_MIN
#undef IPC_CHARGE_PER_NUTRITION
#undef IPC_CHARGE_DELAY_PER_100
