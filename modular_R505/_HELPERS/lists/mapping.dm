GLOBAL_LIST_EMPTY(turf_transition_points)
GLOBAL_LIST_EMPTY(all_space_turfs)

/proc/add_space_transition(turf/T)
	if(!isturf(T))
		CRASH("Tried to add non-turf to space transition turfs.")
	if(!GLOB.turf_transition_points["[T.z]"])
		GLOB.turf_transition_points["[T.z]"] = list()
	GLOB.turf_transition_points["[T.z]"] += T
