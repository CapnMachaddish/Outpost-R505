/*
GLOBAL_LIST_INIT(dust_storms_active, list("1" = 0, "2" = 0, "3" = 0, "4" = 0, "5" = 0, "6" = 0))
/datum/dust_storm
	var/z_level as num
	var/num_to_spawn as num
	var/speed as num
	var/group_num as num
	var/group_speed as num
	var/stop_process = FALSE

/datum/dust_storm/New(zlevel, number_to_spawn=10, distribution_speed=1 SECONDS, number_in_group=1, sleep_before_group=0 SECONDS)
	if(!zlevel)
		zlevel = pick(SSmapping.levels_by_trait(ZTRAIT_STATION))
	if(zlevel < 1 || zlevel > world.maxz || !isnum(zlevel))
		throw EXCEPTION("Unhandled z-level of [zlevel]")
		qdel(src)
		return

	if(GLOB.dust_storms_active["[zlevel]"])
		if(IsAdminAdvancedProcCall())
			if(alert(usr, "There is already a dust storm active on this z-level. Proceed?", "Uh oh!", "Yes", "No") != "Yes")
				qdel(src)
				return
		else
			WARNING("Summoned a dust storm on z-level [zlevel] when there's already a dust storm active")
	..()
	z_level = zlevel
	num_to_spawn = number_to_spawn
	speed = distribution_speed
	group_num = number_in_group
	group_speed = sleep_before_group
	summon()


/datum/dust_storm/proc/summon()
	GLOB.dust_storms_active["[z_level]"]++
	var/iteration = 0
	var/spawned_in_group = 0
	while(!stop_process && iteration != num_to_spawn)
		iteration++

		if(spawned_in_group > group_num && group_num > 0)
			spawned_in_group = 0
			sleep(group_speed)

		spawn_meteor(GLOB.meteorsD, z_level, FALSE)
		spawned_in_group++
		sleep(speed)
	GLOB.dust_storms_active["[z_level]"]-- */
