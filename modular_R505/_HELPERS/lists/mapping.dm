GLOBAL_LIST_EMPTY(turf_transition_points)

/proc/add_space_transition(turf/T)
	ASSERT(istype(T))
	if(!GLOB.turf_transition_points["[T.z]"])
		GLOB.turf_transition_points["[T.z]"] = list()
	GLOB.turf_transition_points["[T.z]"] += T
