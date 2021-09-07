GLOBAL_LIST_INIT(roundstart_events, build_roundstart_events())
GLOBAL_LIST_EMPTY(working_roundstart_events)
GLOBAL_LIST_INIT(default_roundstart_events, list(
		// /datum/roundstart_event/dust_storm,
		/datum/roundstart_event/radiated_space,
	))

/proc/build_roundstart_events()
	GLOB.roundstart_events = list()
	var/list/subs = subtypesof(/datum/roundstart_event)
	for(var/S in subs)
		GLOB.roundstart_events += new S
	return GLOB.roundstart_events

/proc/get_working_roundstart_events()
	GLOB.working_roundstart_events = list()
	for(var/datum/roundstart_event/_R in GLOB.roundstart_events)
		if(_R.check_applicable(SSticker.mode, SSmapping.config.map_file))
			GLOB.working_roundstart_events[_R] = _R.weight
	return GLOB.working_roundstart_events
