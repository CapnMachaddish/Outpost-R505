//Unlike regular events, these spawn immediately when the round gets started
/datum/roundstart_event
	var/name as text
	var/weight = 0
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
	if(spawn_type)
		spawn_type = new()

//TODO: Make this event always spawn, but have secondary roundstart events that happen after it, if more ever appears
/datum/roundstart_event/dust_storm
	name = "Dust Storm"
	weight = 1

/datum/roundstart_event/dust_storm/start()
	spawn_type = new spawn_type(number_to_spawn=-1,number_in_group=25,sleep_before_group=10 SECONDS)
	