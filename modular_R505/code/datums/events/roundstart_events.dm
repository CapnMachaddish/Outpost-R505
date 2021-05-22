//Unlike regular events, these spawn immediately when the round gets started
/datum/roundstart_event
	var/spawn_type
	var/new_type = TRUE
	var/list/whitelisted_maps = list()
	var/list/blacklisted_maps = list()
	var/list/whitelisted_modes = list()
	var/list/blacklisted_modes = list()

/datum/roundstart_event/New(map, mode)
	if(spawn_type && new_type)
		spawn_type = new
	if(whitelisted_maps.len && !(whitelisted_maps.Find(map)))
		return
	if(blacklisted_maps.len && (blacklisted_maps.Find(map)))
		return
	if(whitelisted_modes.len && !(whitelisted_modes.Find(mode)))
		return
	if(blacklisted_modes.len && (blacklisted_modes.Find(mode)))
		return
	return spawn_type || src

/datum/roundstart_event/dust_storm
	name = "Dust Storm"
	spawn_type = /datum/dust_storm
	new_type = FALSE

/datum/roundstart_event/dust_storm/New(map, mode)
	. = ..()
	if(!.)
		return
	spawn_type = new(number_to_spawn=-1,number_in_group=25,sleep_before_group=10 SECONDS)
	return spawn_type
