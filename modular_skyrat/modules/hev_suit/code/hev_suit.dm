#define HEV_COLOR_GREEN "#00ff00"
#define HEV_COLOR_RED "#ff0000"
#define HEV_COLOR_BLUE "#00aeff"
#define HEV_COLOR_ORANGE "#f88f04"

#define HEV_ARMOR_POWERON_BONUS 60

#define HEV_DAMAGE_POWER_USE_THRESHOLD 10

#define HEV_ARMOR_POWEROFF list(20, 20, 20, 20, 30, 40, 40, 40, 40, 10)

#define HEV_ARMOR_POWERON list(60, 60, 60, 60, 90, 100, 100, 100, 100, 30)

#define HEV_POWERUSE_AIRTANK 2
#define HEV_POWERUSE_HIT 100
#define HEV_POWERUSE_HEAL 150

#define HEV_COOLDOWN_HEAL 10 SECONDS
#define HEV_COOLDOWN_RADS 20 SECONDS
#define HEV_COOLDOWN_ACID 20 SECONDS

#define HEV_HEAL_AMOUNT 10
#define HEV_BLOOD_REPLENISHMENT 20

#define HEV_NOTIFICATION_TEXT_AND_VOICE "VOICE_AND_TEXT"
#define HEV_NOTIFICATION_TEXT "TEXT_ONLY"
#define HEV_NOTIFICATION_VOICE "VOICE_ONLY"
#define HEV_NOTIFICATION_OFF "OFF"
#define HEV_NOTIFICATIONS list(HEV_NOTIFICATION_TEXT_AND_VOICE, HEV_NOTIFICATION_TEXT, HEV_NOTIFICATION_VOICE, HEV_NOTIFICATION_OFF)


/obj/item/clothing/head/helmet/space/hardsuit/hev_suit
	name = "hazardous environment suit helmet"
	desc = "The Mark IV HEV suit helmet."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-hev"
	inhand_icon_state = "sec_helm"
	hardsuit_type = "hev"
	armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 40, RAD = 40, FIRE = 40, ACID = 40, WOUND = 10)
	obj_flags = NO_MAT_REDEMPTION
	resistance_flags = LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF|INDESTRUCTIBLE|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|THICKMATERIAL|SNUG_FIT|LAVAPROTECT|BLOCK_GAS_SMOKE_EFFECT|SCAN_REAGENTS
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags = STOPSPRESSUREDAMAGE
	slowdown = 0

/obj/item/clothing/suit/space/hardsuit/hev_suit
	name = "hazardous environment suit"
	desc = "The Mark IV HEV suit protects the user from a number of hazardous environments and has in build ballistic protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-hev"
	inhand_icon_state = "eng_hardsuit"
	armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 40, RAD = 40, FIRE = 40, ACID = 40, WOUND = 10) //This is gordons suit, of course it's strong.
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/hev_suit
	jetpack = /obj/item/tank/jetpack/suit
	cell = /obj/item/stock_parts/cell/hyper
	slowdown = 0 //I am not gimping doctor freeman
	hardsuit_tail_colors = list("D52", "444", "F62")
	actions_types = list(/datum/action/item_action/hev_toggle, /datum/action/item_action/hev_toggle_notifs, /datum/action/item_action/toggle_helmet, /datum/action/item_action/toggle_spacesuit)
	resistance_flags = LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF|INDESTRUCTIBLE|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|THICKMATERIAL|SNUG_FIT|LAVAPROTECT

	var/activated = FALSE
	var/activating = FALSE

	var/mob/living/carbon/current_user
	var/obj/item/clothing/head/helmet/space/hardsuit/hev_suit/current_helmet
	var/obj/item/tank/internals/current_internals_tank
	var/obj/item/radio/internal_radio

	var/user_old_bruteloss
	var/user_old_fireloss
	var/user_old_toxloss
	var/user_old_cloneloss
	var/user_old_oxyloss

	var/radio_channel = RADIO_CHANNEL_COMMON

	var/timer_id = null

	var/voice_current_cooldown
	var/healing_current_cooldown
	var/health_statement_cooldown
	var/battery_statement_cooldown
	var/acid_statement_cooldown
	var/rad_statement_cooldown

	var/blood_loss_alarm = FALSE
	var/toxins_alarm = FALSE
	var/batt_50_alarm = FALSE
	var/batt_40_alarm = FALSE
	var/batt_30_alarm = FALSE
	var/batt_20_alarm = FALSE
	var/batt_10_alarm = FALSE
	var/health_near_death_alarm = FALSE
	var/health_critical_alarm = FALSE
	var/health_dropping_alarm = FALSE
	var/seek_medical_attention_alarm = FALSE

	var/send_notifications = HEV_NOTIFICATION_TEXT_AND_VOICE
	var/playing_voice_line

	var/list/queued_voice_lines = list()

	/// On first activation, we play the user a nice song!
	var/first_use = TRUE

/obj/item/clothing/suit/space/hardsuit/hev_suit/Initialize()
	. = ..()
	internal_radio = new(src)
	internal_radio.subspace_transmission = TRUE
	internal_radio.canhear_range = 0 // anything greater will have the bot broadcast the channel as if it were saying it out loud.
	internal_radio.recalculateChannels()

/obj/item/clothing/suit/space/hardsuit/hev_suit/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/cell, cell_override = /obj/item/stock_parts/cell/hyper, _has_cell_overlays = FALSE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/equipped(mob/user, slot)
	. = ..()
	current_user = user

/obj/item/clothing/suit/space/hardsuit/hev_suit/dropped()
	. = ..()
	deactivate()
	if(current_internals_tank)
		current_internals_tank = null
	current_helmet = null
	current_user = null

/obj/item/clothing/suit/space/hardsuit/hev_suit/Destroy()
	if(internal_radio)
		qdel(internal_radio)
	if(current_internals_tank)
		REMOVE_TRAIT(current_internals_tank, TRAIT_NODROP, "hev_trait")
		current_internals_tank = null
	current_helmet = null
	deactivate()
	current_user = null
	return ..()

/datum/action/item_action/hev_toggle
	name = "Toggle HEV Suit"
	button_icon = 'modular_skyrat/modules/hev_suit/icons/toggles.dmi'
	background_icon_state = "bg_hl"
	icon_icon = 'modular_skyrat/modules/hev_suit/icons/toggles.dmi'
	button_icon_state = "system_off"

/datum/action/item_action/hev_toggle_notifs
	name = "Toggle HEV Suit Notifications"
	button_icon = 'modular_skyrat/modules/hev_suit/icons/toggles.dmi'
	background_icon_state = "bg_hl"
	icon_icon = 'modular_skyrat/modules/hev_suit/icons/toggles.dmi'
	button_icon_state = "sound_VOICE_AND_TEXT"

/datum/action/item_action/hev_toggle_notifs/Trigger()
	var/obj/item/clothing/suit/space/hardsuit/hev_suit/my_suit = target

	var/new_setting = tgui_input_list(my_suit.current_user, "Please select your notification settings.", "HEV Notification Settings", HEV_NOTIFICATIONS)

	if(!new_setting)
		new_setting = HEV_NOTIFICATION_TEXT_AND_VOICE

	to_chat(my_suit.current_user, "<span class='notice'>[my_suit] notification mode is now [new_setting].")

	my_suit.send_notifications = new_setting

	button_icon_state = "sound_[new_setting]"

	playsound(my_suit, 'modular_skyrat/master_files/sound/blackmesa/hev/blip.ogg', 50)

	UpdateButtonIcon()

/datum/action/item_action/hev_toggle/Trigger()
	var/obj/item/clothing/suit/space/hardsuit/hev_suit/my_suit = target
	if(my_suit.activated)
		my_suit.deactivate()
	else
		my_suit.activate()

	var/toggle = FALSE

	if(my_suit.activated || my_suit.activating)
		toggle = TRUE

	button_icon_state = toggle ? "system_on" : "system_off"

	playsound(my_suit, 'modular_skyrat/master_files/sound/blackmesa/hev/blip.ogg', 50)

	UpdateButtonIcon()

/obj/item/clothing/suit/space/hardsuit/hev_suit/ToggleHelmet()
	if(activated || activating)
		send_message("ERROR, SUIT HELMENT CANNOT BE DISENGAGED", HEV_COLOR_RED)
		return
	. = ..()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/send_message(message, color = HEV_COLOR_ORANGE)
	if(send_notifications != HEV_NOTIFICATION_TEXT_AND_VOICE && send_notifications != HEV_NOTIFICATION_TEXT)
		return
	if(!current_user)
		return
	to_chat(current_user, "HEV MARK IV: <span style='color: [color];'>[message]</span>")

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/send_hev_sound(sound_in, priority, volume = 50)
	if(send_notifications != HEV_NOTIFICATION_TEXT_AND_VOICE && send_notifications != HEV_NOTIFICATION_VOICE)
		return

	if(!activated)
		return

	if(playing_voice_line)
		if(priority) //Shit's fucked, we better say this ASAP
			queued_voice_lines.Insert(1, sound_in)
		else
			queued_voice_lines += sound_in
		return

	if(queued_voice_lines.len)
		var/voice_line = queued_voice_lines[1]
		var/sound/voice = sound(voice_line, wait = 1, channel = CHANNEL_HEV)
		voice.status = SOUND_STREAM
		playing_voice_line = TRUE
		playsound(src, voice, volume)
		queued_voice_lines -= voice_line
		addtimer(CALLBACK(src, .proc/reset_sound), 4 SECONDS)
		return

	playing_voice_line = TRUE

	var/sound/voice = sound(sound_in, wait = 1, channel = CHANNEL_HEV)
	voice.status = SOUND_STREAM
	playsound(src, voice, volume)

	addtimer(CALLBACK(src, .proc/reset_sound), 4 SECONDS)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/reset_sound()
	playing_voice_line = FALSE
	send_hev_sound()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/activate()
	if(!current_user)
		return FALSE

	if(activating || activated)
		send_message("ERROR - SYSTEM [activating ? "ALREADY ACTIVATING" : "ALREADY ACTIVATED"]", HEV_COLOR_RED)
		return FALSE

	var/power_test = item_use_power(10, TRUE)
	if(!(power_test & COMPONENT_POWER_SUCCESS))
		var/failure_reason
		switch(power_test)
			if(COMPONENT_NO_CELL)
				failure_reason = "NO CELL INSERTED"
			if(COMPONENT_NO_CHARGE)
				failure_reason = "NO CELL CHARGE"
			else
				failure_reason = "GENERIC FAILURE"
		send_message("ERROR - POWER SYSTEMS FAILURE - [failure_reason]", HEV_COLOR_RED)
		return FALSE

	if(!current_user.head && !istype(current_user.head, /obj/item/clothing/head/helmet/space/hardsuit/hev_suit))
		send_message("ERROR - SUIT HELMET NOT ENGAGED", HEV_COLOR_RED)
		return FALSE

	current_helmet = current_user.head

	ADD_TRAIT(current_helmet, TRAIT_NODROP, "hev_trait")

	send_message("ACTIVATING SYSTEMS")
	activating = TRUE

	if(first_use)
		var/sound/song = sound('modular_skyrat/master_files/sound/blackmesa/hev/anomalous_materials.ogg', volume = 50)
		SEND_SOUND(current_user, song)
		first_use = FALSE

	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/01_hev_logon.ogg', 50)

	send_message("ESTABLISHING HELMET LINK...")
	send_message("...ESTABLISHED", HEV_COLOR_GREEN)

	send_message("CALIBRATING FIT ADJUSTMENTS...")
	send_message("...CALIBRATED", HEV_COLOR_GREEN)

	send_message("CALIBRATING REACTIVE ARMOR SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/powerarmor), 10 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/use_hev_power(amount)
	var/power_test = item_use_power(amount)
	if(!(power_test & COMPONENT_POWER_SUCCESS))
		var/failure_reason
		switch(power_test)
			if(COMPONENT_NO_CELL)
				failure_reason = "NO CELL INSERTED"
			if(COMPONENT_NO_CHARGE)
				failure_reason = "NO CELL CHARGE"
			else
				failure_reason = "GENERIC FAILURE"
		send_message("ERROR - POWER SYSTEMS FAILURE - [failure_reason]", HEV_COLOR_RED)
		deactivate()
		return FALSE
	announce_battery()
	return TRUE

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/announce_battery()
	var/datum/component/cell/my_cell = GetComponent(/datum/component/cell)
	var/current_battery_charge = my_cell.inserted_cell.percent()

	if(current_battery_charge <= 10 && !batt_10_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/power_level_is_ten.ogg')
		batt_10_alarm = TRUE
		return
	else if(current_battery_charge > 10 && batt_10_alarm)
		batt_10_alarm = FALSE

	if(current_battery_charge > 10 && current_battery_charge <= 20 && !batt_20_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/power_level_is_twenty.ogg')
		batt_20_alarm = TRUE
		return
	else if(current_battery_charge > 20 && batt_20_alarm)
		batt_20_alarm = FALSE

	if(current_battery_charge > 20 && current_battery_charge <= 30 && !batt_30_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/power_level_is_thirty.ogg')
		batt_30_alarm = TRUE
		return
	else if(current_battery_charge > 30 && batt_30_alarm)
		batt_30_alarm = FALSE

	if(current_battery_charge > 30 && current_battery_charge <= 40 && !batt_40_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/power_level_is_fourty.ogg')
		batt_40_alarm = TRUE
		return
	else if(current_battery_charge > 40 && batt_40_alarm)
		batt_40_alarm = FALSE

	if(current_battery_charge > 40 && current_battery_charge <= 50 && !batt_50_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/power_level_is_fifty.ogg')
		batt_50_alarm = TRUE
		return
	else if(current_battery_charge > 50 && batt_50_alarm)
		batt_50_alarm = FALSE

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/powerarmor()
	armor = armor.setRating(
		HEV_ARMOR_POWERON[1],
		HEV_ARMOR_POWERON[2],
		HEV_ARMOR_POWERON[3],
		HEV_ARMOR_POWERON[4],
		HEV_ARMOR_POWERON[5],
		HEV_ARMOR_POWERON[6],
		HEV_ARMOR_POWERON[7],
		HEV_ARMOR_POWERON[8],
		HEV_ARMOR_POWERON[9],
		HEV_ARMOR_POWERON[10]
		)
	current_helmet.armor = current_helmet.armor.setRating(
		HEV_ARMOR_POWERON[1],
		HEV_ARMOR_POWERON[2],
		HEV_ARMOR_POWERON[3],
		HEV_ARMOR_POWERON[4],
		HEV_ARMOR_POWERON[5],
		HEV_ARMOR_POWERON[6],
		HEV_ARMOR_POWERON[7],
		HEV_ARMOR_POWERON[8],
		HEV_ARMOR_POWERON[9],
		HEV_ARMOR_POWERON[10]
		)
	user_old_bruteloss = current_user.getBruteLoss()
	user_old_fireloss = current_user.getFireLoss()
	user_old_toxloss = current_user.getToxLoss()
	user_old_cloneloss = current_user.getCloneLoss()
	user_old_oxyloss = current_user.getOxyLoss()
	RegisterSignal(current_user, COMSIG_MOB_RUN_ARMOR, .proc/process_hit)
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/02_powerarmor_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	send_message("CALIBRATING ATMOSPHERIC CONTAMINANT SENSORS...")
	timer_id = addtimer(CALLBACK(src, .proc/atmospherics), 4 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_hit()
	SIGNAL_HANDLER
	var/new_bruteloss = current_user.getBruteLoss()
	var/new_fireloss = current_user.getFireLoss()
	var/new_toxloss = current_user.getToxLoss()
	var/new_cloneloss = current_user.getCloneLoss()
	var/new_oxyloss = current_user.getOxyLoss()
	var/use_power_this_hit = FALSE
	if(current_user.getBruteLoss() > (new_bruteloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(current_user.getFireLoss() > (new_fireloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(current_user.getToxLoss() > (new_toxloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	if(current_user.getCloneLoss() > (new_cloneloss + HEV_DAMAGE_POWER_USE_THRESHOLD))
		use_power_this_hit = TRUE
	user_old_bruteloss = new_bruteloss
	user_old_fireloss = new_fireloss
	user_old_toxloss = new_toxloss
	user_old_cloneloss = new_cloneloss
	user_old_oxyloss = new_oxyloss
	state_health()
	if(use_power_this_hit)
		use_hev_power(HEV_POWERUSE_HIT)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/state_health()
	var/health_percent = round((current_user.health / current_user.maxHealth) * 100, 1)

	if(health_percent <= 20 && !health_near_death_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/near_death.ogg', TRUE)
		health_near_death_alarm = TRUE
		return
	else if(health_percent > 20 && health_near_death_alarm)
		health_near_death_alarm = FALSE

	if(health_percent > 20 && health_percent <= 30 && !health_critical_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/health_critical.ogg', TRUE)
		health_critical_alarm = TRUE
		return
	else if(health_percent > 30 && health_critical_alarm)
		health_critical_alarm = FALSE

	if(health_percent > 30 && health_percent <= 80 && !health_dropping_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/health_dropping2.ogg', TRUE)
		health_dropping_alarm = TRUE
		return
	else if(health_percent > 80 && health_dropping_alarm)
		health_dropping_alarm = FALSE

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/atmospherics()
	if(!current_user.get_item_by_slot(ITEM_SLOT_SUITSTORE) && !istype(current_user.get_item_by_slot(ITEM_SLOT_SUITSTORE), /obj/item/tank/internals))
		send_message("...FAILURE, NO TANK DETECTED", HEV_COLOR_RED)
		send_message("CALIBRATING VITALSIGN MONITORING SYSTEMS...")
		timer_id = addtimer(CALLBACK(src, .proc/vitalsigns), 4 SECONDS, TIMER_STOPPABLE)
		return
	current_internals_tank = current_user.get_item_by_slot(ITEM_SLOT_SUITSTORE)
	ADD_TRAIT(current_internals_tank, TRAIT_NODROP, "hev_trait")
	to_chat(current_user, "<span class='notice'>You hear a click as [current_internals_tank] is secured to your suit.</span>")
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/03_atmospherics_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	send_message("CALIBRATING VITALSIGN MONITORING SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/vitalsigns), 4 SECONDS, TIMER_STOPPABLE)


/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/handle_tank()
	if(!current_internals_tank)
		return
	if(use_hev_power(HEV_POWERUSE_AIRTANK))
		current_internals_tank.populate_gas()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/vitalsigns()
	RegisterSignal(current_user, COMSIG_MOB_STATCHANGE, .proc/stat_changed)
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/04_vitalsigns_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	send_message("CALIBRATING AUTOMATIC MEDICAL SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/medical_systems), 3 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/stat_changed(datum/source, new_stat)
	SIGNAL_HANDLER
	if(new_stat == DEAD)
		playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/flatline.ogg', 40)
		internal_radio.talk_into(src, "WARNING! USER [uppertext(current_user.real_name)] VITALSIGNS HAVE FLATLINED, CURRENT POSITION: [loc.x], [loc.y], [loc.z]!", radio_channel)
		deactivate()

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/medical_systems()
	RegisterSignal(current_user, COMSIG_ATOM_RAD_ACT, .proc/process_radiation)
	RegisterSignal(current_user, COMSIG_CARBON_GAIN_WOUND, .proc/process_wound)
	RegisterSignal(current_user, COMSIG_ATOM_ACID_ACT, .proc/process_acid)
	START_PROCESSING(SSobj, src)
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/05_automedic_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	send_message("CALIBRATING DEFENSIVE WEAPON SELECTION SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/weaponselect), 3 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/process(delta_time)
	if(!activated)
		return
	if(current_user.blood_volume < BLOOD_VOLUME_OKAY)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.blood_volume += HEV_BLOOD_REPLENISHMENT
		if(!blood_loss_alarm)
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/blood_loss.ogg')
			blood_loss_alarm = TRUE
	else if(blood_loss_alarm && current_user.blood_volume >= BLOOD_VOLUME_OKAY)
		blood_loss_alarm = FALSE

	var/diseased = FALSE

	for(var/thing in current_user.diseases)
		var/datum/disease/disease_to_kill = thing
		disease_to_kill.cure()
		diseased = TRUE

	if(diseased)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/biohazard_detected.ogg')
		send_message("DISEASE CURED", HEV_COLOR_BLUE)

	handle_tank()

	if(current_user.getToxLoss() > 30 && !toxins_alarm)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/blood_toxins.ogg')
		toxins_alarm = TRUE
	else if(toxins_alarm && current_user.getToxLoss() <= 30)
		toxins_alarm = FALSE

	if(current_user.all_wounds)
		var/datum/wound/wound2fix = current_user.all_wounds[1]
		wound2fix.remove_wound()
		send_message("WOUND TREATED", HEV_COLOR_BLUE)

	if(world.time <= healing_current_cooldown)
		return

	var/new_bruteloss = current_user.getBruteLoss()
	var/new_fireloss = current_user.getFireLoss()
	var/new_toxloss = current_user.getToxLoss()
	var/new_cloneloss = current_user.getCloneLoss()
	var/new_oxyloss = current_user.getOxyLoss()
	var/new_stamloss = current_user.getStaminaLoss()

	if(new_stamloss)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustStaminaLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_COOLDOWN_HEAL * 2

	if(new_oxyloss)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustOxyLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_COOLDOWN_HEAL
			send_message("ADRENALINE ADMINISTERED", HEV_COLOR_BLUE)
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/morphine_shot.ogg')
		return

	if(new_bruteloss)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustBruteLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_COOLDOWN_HEAL
			send_message("BRUTE MEDICAL ATTENTION ADMINISTERED", HEV_COLOR_BLUE)
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/wound_sterilized.ogg')
		return

	if(new_fireloss)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustFireLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_COOLDOWN_HEAL
			send_message("BURN MEDICAL ATTENTION ADMINISTERED", HEV_COLOR_BLUE)
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/wound_sterilized.ogg')
		return

	if(new_toxloss)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustToxLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_COOLDOWN_HEAL
			send_message("TOXIN MEDICAL ATTENTION ADMINISTERED", HEV_COLOR_BLUE)
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/antitoxin_shot.ogg')
		return

	if(new_cloneloss)
		if(use_hev_power(HEV_POWERUSE_HEAL))
			current_user.adjustCloneLoss(-HEV_HEAL_AMOUNT)
			healing_current_cooldown = world.time + HEV_COOLDOWN_HEAL
			send_message("MEDICAL ATTENTION ADMINISTERED", HEV_COLOR_BLUE)
			send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/antidote_shot.ogg')
		return

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_wound(carbon, wound, bodypart)
	SIGNAL_HANDLER

	var/list/minor_fractures = list(
		/datum/wound/blunt,
		/datum/wound/blunt/moderate,
		/datum/wound/muscle,
		/datum/wound/muscle/moderate
		)
	var/list/major_fractures = list(
		/datum/wound/blunt/severe,
		/datum/wound/blunt/critical,
		/datum/wound/muscle/severe,
		/datum/wound/loss
		)
	var/list/minor_lacerations = list(
		/datum/wound/burn,
		/datum/wound/burn/moderate,
		/datum/wound/pierce,
		/datum/wound/pierce/moderate,
		/datum/wound/slash,
		/datum/wound/slash/moderate
		)
	var/list/major_lacerations = list(
		/datum/wound/burn/severe,
		/datum/wound/burn/critical,
		/datum/wound/pierce/severe,
		/datum/wound/pierce/critical,
		/datum/wound/slash/severe,
		/datum/wound/slash/critical
		)

	if(wound in minor_fractures)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/minor_fracture.ogg')
	else if(wound in major_fractures)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/major_fracture.ogg')
	else if(wound in minor_lacerations)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/minor_lacerations.ogg')
	else if(wound in major_lacerations)
		send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/major_lacerations.ogg')
	else
		var/sound2play = pick(list(
			'modular_skyrat/master_files/sound/blackmesa/hev/minor_fracture.ogg',
			'modular_skyrat/master_files/sound/blackmesa/hev/major_fracture.ogg',
			'modular_skyrat/master_files/sound/blackmesa/hev/minor_lacerations.ogg',
			'modular_skyrat/master_files/sound/blackmesa/hev/major_lacerations.ogg'
		))
		send_hev_sound(sound2play)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_acid()
	SIGNAL_HANDLER
	if(world.time <= acid_statement_cooldown)
		return
	acid_statement_cooldown = world.time + HEV_COOLDOWN_ACID
	send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/chemical_detected.ogg')

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/process_radiation()
	SIGNAL_HANDLER
	if(world.time <= rad_statement_cooldown)
		return
	rad_statement_cooldown = world.time + HEV_COOLDOWN_RADS
	send_hev_sound('modular_skyrat/master_files/sound/blackmesa/hev/radiation_detected.ogg')

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/weaponselect()
	ADD_TRAIT(current_user, list(TRAIT_GUNFLIP,TRAIT_GUN_NATURAL), "hev_trait")
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/06_weaponselect_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	send_message("CALIBRATING MUNITION LEVEL MONITORING SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/munitions_monitoring), 4 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/munitions_monitoring()
	//Crickets, not sure what to make this do!
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/07_munitionview_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	send_message("CALIBRATING COMMUNICATIONS SYSTEMS...")
	timer_id = addtimer(CALLBACK(src, .proc/comms_system), 4 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/comms_system()

	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/08_communications_on.ogg', 50)
	send_message("...CALIBRATED", HEV_COLOR_GREEN)
	timer_id = addtimer(CALLBACK(src, .proc/finished), 4 SECONDS, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/finished()
	to_chat(current_user, "<span class='notice'>You feel [src] seal around your body, locking it in place!</span>")
	ADD_TRAIT(src, TRAIT_NODROP, "hev_trait")
	send_message("ALL SYSTEMS ONLINE, WELCOME [uppertext(current_user.real_name)]", HEV_COLOR_GREEN)
	playsound(src, 'modular_skyrat/master_files/sound/blackmesa/hev/09_safe_day.ogg', 50)
	activated = TRUE
	activating = FALSE

/obj/item/clothing/suit/space/hardsuit/hev_suit/proc/deactivate()
	if(timer_id)
		deltimer(timer_id)
	STOP_PROCESSING(SSobj, src)
	REMOVE_TRAIT(src, TRAIT_NODROP, "hev_trait")
	armor = armor.setRating(
		HEV_ARMOR_POWEROFF[1],
		HEV_ARMOR_POWEROFF[2],
		HEV_ARMOR_POWEROFF[3],
		HEV_ARMOR_POWEROFF[4],
		HEV_ARMOR_POWEROFF[5],
		HEV_ARMOR_POWEROFF[6],
		HEV_ARMOR_POWEROFF[7],
		HEV_ARMOR_POWEROFF[8],
		HEV_ARMOR_POWEROFF[9],
		HEV_ARMOR_POWEROFF[10]
		)
	if(current_helmet)
		current_helmet.armor = current_helmet.armor.setRating(
		HEV_ARMOR_POWEROFF[1],
		HEV_ARMOR_POWEROFF[2],
		HEV_ARMOR_POWEROFF[3],
		HEV_ARMOR_POWEROFF[4],
		HEV_ARMOR_POWEROFF[5],
		HEV_ARMOR_POWEROFF[6],
		HEV_ARMOR_POWEROFF[7],
		HEV_ARMOR_POWEROFF[8],
		HEV_ARMOR_POWEROFF[9],
		HEV_ARMOR_POWEROFF[10]
		)
		REMOVE_TRAIT(current_helmet, TRAIT_NODROP, "hev_trait")
	if(current_internals_tank)
		REMOVE_TRAIT(current_internals_tank, TRAIT_NODROP, "hev_trait")
	if(current_user)
		send_message("SYSTEMS DEACTIVATED", HEV_COLOR_RED)
		REMOVE_TRAIT(current_user, list(TRAIT_GUNFLIP,TRAIT_GUN_NATURAL), "hev_trait")
		UnregisterSignal(current_user, list(
			COMSIG_ATOM_ACID_ACT,
			COMSIG_CARBON_GAIN_WOUND,
			COMSIG_ATOM_RAD_ACT,
			COMSIG_MOB_RUN_ARMOR,
			COMSIG_MOB_STATCHANGE
		))
	activated = FALSE
	activating = FALSE

/obj/machinery/suit_storage_unit/hev
	suit_type = /obj/item/clothing/suit/space/hardsuit/hev_suit
	mask_type = /obj/item/clothing/mask/gas/alt
	storage_type = /obj/item/tank/internals/oxygen

/datum/outfit/gordon_freeman
	name = "Gordon Freeman"
	uniform = /obj/item/clothing/under/misc/hlscience
	ears = /obj/item/radio/headset/headset_cent/commander
	belt = /obj/item/storage/belt/utility/full
	neck = /obj/item/clothing/neck/tie/horrible
	shoes = /obj/item/clothing/shoes/combat

	suit = /obj/item/clothing/suit/space/hardsuit/hev_suit
	suit_store = /obj/item/tank/internals/oxygen

	back = /obj/item/storage/backpack

	backpack_contents = list(/obj/item/gun/ballistic/automatic/cfa_wildcat, /obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat = 4)

	l_hand = /obj/item/crowbar/freeman

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/gordon_freeman

/datum/outfit/gordon_freeman/post_equip(mob/living/carbon/human/our_human, visualsOnly)
	. = ..()
	var/obj/item/card/id/id_card = our_human.wear_id
	if(istype(id_card))
		id_card.registered_name = our_human.real_name
		id_card.update_label()
		id_card.update_icon()

/datum/id_trim/gordon_freeman
	trim_state = "trim_scientist"
	assignment = "Theoretical Physicist"

/datum/id_trim/gordon_freeman/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

#undef HEV_COLOR_GREEN
#undef HEV_COLOR_RED
#undef HEV_COLOR_BLUE
#undef HEV_COLOR_ORANGE
#undef HEV_ARMOR_POWERON_BONUS
#undef HEV_DAMAGE_POWER_USE_THRESHOLD
#undef HEV_ARMOR_POWEROFF
#undef HEV_ARMOR_POWERON
#undef HEV_POWERUSE_AIRTANK
#undef HEV_POWERUSE_HIT
#undef HEV_POWERUSE_HEAL
#undef HEV_COOLDOWN_HEAL
#undef HEV_COOLDOWN_RADS
#undef HEV_COOLDOWN_ACID
#undef HEV_HEAL_AMOUNT
#undef HEV_BLOOD_REPLENISHMENT
#undef HEV_NOTIFICATION_TEXT_AND_VOICE
#undef HEV_NOTIFICATION_TEXT
#undef HEV_NOTIFICATION_VOICE
#undef HEV_NOTIFICATION_OFF
#undef HEV_NOTIFICATIONS
