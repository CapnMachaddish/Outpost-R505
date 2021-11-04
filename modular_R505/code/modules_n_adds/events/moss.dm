/datum/round_event_control/moss
	name = "Moss Contamination"
	typepath = /datum/round_event/moss
	max_occurrences = 1
	weight = 10
	earliest_start = 10 MINUTES

/datum/round_event_control/moss/canSpawnEvent(players_amt)
	if(!..())
		return FALSE
	if(!GLOB.blobstart)
		return FALSE

/datum/round_event/moss
	announceWhen = 2 MINUTES

/datum/round_event/moss/announce(fake)	//TODO: Find where to make/generate announcements?
	priority_announce("Confirmed outbreak of level 4 biohazard aboard [station_name()]. Keep advised caution.", "Biohazard Alert")

/datum/round_event/moss/start()
	if(!GLOB.blobstart)
		stack_trace("No blob spawnpoints have been put on this map. Contact a mapper.")
		kill()
		return
	var/turf/T = get_turf(pick(GLOB.blobstart))
	if(!T)
		stack_trace("No blob spawnpoints have been put on this map. Contact a mapper.")
		kill()
		return
	new/obj/structure/mold/structure/core(T)