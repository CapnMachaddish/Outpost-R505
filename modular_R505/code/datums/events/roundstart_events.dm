//Unlike regular events, these spawn immediately when the round gets started
/datum/roundstart_event
	var/name as text
	var/weight = 0
	var/summon_default_mapevents = TRUE
	var/datum/spawn_type
	var/list/whitelisted_maps = list()
	var/list/blacklisted_maps = list()
	var/list/whitelisted_modes = list()
	var/list/blacklisted_modes = list()

/datum/roundstart_event/proc/check_applicable(map, mode)
	if(whitelisted_maps.len && !(whitelisted_maps.Find(map)))
		return FALSE
	if(blacklisted_maps.len && (blacklisted_maps.Find(map)))
		return FALSE
	if(whitelisted_modes.len && !(whitelisted_modes.Find(mode)))
		return FALSE
	if(blacklisted_modes.len && (blacklisted_modes.Find(mode)))
		return FALSE
	return TRUE

/datum/roundstart_event/proc/start()
	return

/datum/roundstart_event/proc/generate_report_details()
	return
/*
//Dust Storms
/datum/roundstart_event/dust_storm
	name = "Light Dust Storm"
	weight = 5

/datum/roundstart_event/dust_storm/start()	//Ends after a while
	spawn_type = new /datum/dust_storm(number_to_spawn=1000,number_in_group=2,distribution_speed=rand(5 SECONDS, 11 SECONDS),sleep_before_group=20 SECONDS)

/datum/roundstart_event/dust_storm/generate_report_details()
	return "Your station is located in the middle of a small debris cloud, which will slowly wither \
	away the hull and exposed machinery. It is advised to protect solar panels with meteor defense satellites. <BR>\
	Estimated Escape of Debris Cloud: [rand(1, 2)] hours and [rand(8, 55)] minutes."

/datum/roundstart_event/dust_storm/heavy
	name = "Heavy Dust Storm"
	weight = 2

/datum/roundstart_event/dust_storm/heavy/start()
	spawn_type = new /datum/dust_storm(number_to_spawn=-1,number_in_group=8,distribution_speed=rand(4 SECONDS, 7 SECONDS),sleep_before_group=15 SECONDS)

/datum/roundstart_event/dust_storm/heavy/generate_report_details()
	return "Your station is hidden in the middle of an uncountably-large debris cloud. \
	Take exercised caution when maintaining outside equipment. \
	Meteor defense satellites are required to keep the station's hull fully maintained."
*/
//Space Radiation
//The radiation_pulse will cause a bit of lag, but this is okay because this is happening roundstart and probably wouldn't be noticed
GLOBAL_VAR_INIT(space_radiation, 66)
/datum/roundstart_event/radiated_space
	name = "Irradiated Sector"
	weight = 4

/datum/roundstart_event/radiated_space/start()
	GLOB.space_radiation = rand(25, 125)
	fire_space()

/datum/roundstart_event/radiated_space/proc/fire_space()
	set background = TRUE
	var/radiate = TRUE
	for(var/turf/open/space/S in world)
		if(S.type != /turf/open/space)
			continue
		if(radiate && prob(10))
			radiation_pulse(S, GLOB.space_radiation)
		radiate = !radiate

/datum/roundstart_event/radiated_space/heavy
	name = "Heavily-Irradiated Locale"
	weight = 1

/datum/roundstart_event/radiated_space/heavy/start()
	GLOB.space_radiation = rand(305, 665)
	fire_space()

/datum/roundstart_event/radiated_space/heavy/generate_report_details()
	return "Your station is located in highly irradiated space. Space suits will protect from the astronomical radiation, \
	however the radiation is strong enough to contaminate nearby equipment and backpack items. \
	Take exercised caution when maintaining equipment outside of the station. <BR>\
	Remember, Suit Storage Units and chemical showers are able to decontaminate equipment."
