/turf/open
	plane = FLOOR_PLANE
	var/slowdown = 0 //negative for faster, positive for slower

	var/footstep = null
	var/barefootstep = null
	var/clawfootstep = null
	var/heavyfootstep = null

	var/datum/pollution/pollution //SKYRAT EDIT ADDITION /// Pollution of this turf

//SKYRAT EDIT ADDITION
//Consider making all of these behaviours a smart component/element? Something that's only applied wherever it needs to be
//Could probably have the variables on the turf level, and the behaviours being activated/deactived on the component level as the vars are updated
/turf/open/CanPass(atom/movable/A, turf/T)
	if(isliving(A))
		var/turf/AT = get_turf(A)
		if(AT && AT.turf_height - turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
			return FALSE
	return ..()

/turf/open/Exit(atom/movable/mover, atom/newloc)
	. = ..()
	if(. && isliving(mover) && mover.has_gravity() && isturf(newloc))
		var/mob/living/L = mover
		var/turf/T = get_turf(newloc)
		if(T && T.turf_height - turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
			L.on_fall()
			L.onZImpact(T, 1)


/turf/open/MouseDrop_T(mob/living/M, mob/living/user)
	if(!isliving(M) || !isliving(user) || !M.has_gravity() || !Adjacent(user) || !M.Adjacent(user) || !(user.stat == CONSCIOUS) || user.body_position == LYING_DOWN)
		return
	if(!M.has_gravity())
		return
	var/turf/T = get_turf(M)
	if(!T)
		return
	if(T.turf_height - turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
		//Climb up
		if(user == M)
			M.visible_message("<span class='notice'>[user] is climbing onto [src]", \
								"<span class='notice'>You start climbing onto [src].</span>")
		else
			M.visible_message("<span class='notice'>[user] is pulling [M] onto [src]", \
								"<span class='notice'>You start pulling [M] onto [src].</span>")
		if(do_mob(user, M, 2 SECONDS))
			M.forceMove(src)
		return
	if(turf_height - T.turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
		//Climb down
		if(user == M)
			M.visible_message("<span class='notice'>[user] is descending down to [src]", \
								"<span class='notice'>You start lowering yourself to [src].</span>")
		else
			M.visible_message("<span class='notice'>[user] is lowering [M] down to [src]", \
								"<span class='notice'>You start lowering [M] down to [src].</span>")
		if(do_mob(user, M, 2 SECONDS))
			M.forceMove(src)
		return
//SKYRAT EDIT END

//direction is direction of travel of A
/turf/open/zPassIn(atom/movable/A, direction, turf/source)
	if(direction == DOWN)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_IN_DOWN)
				return FALSE
		return TRUE
	return FALSE

//direction is direction of travel of A
/turf/open/zPassOut(atom/movable/A, direction, turf/destination)
	if(direction == UP)
		for(var/obj/O in contents)
			if(O.obj_flags & BLOCK_Z_OUT_UP)
				return FALSE
		return TRUE
	return FALSE

//direction is direction of travel of air
/turf/open/zAirIn(direction, turf/source)
	return (direction == DOWN)

//direction is direction of travel of air
/turf/open/zAirOut(direction, turf/source)
	return (direction == UP)

/turf/open/indestructible
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "floor"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = TRUE

/turf/open/indestructible/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/indestructible/singularity_act()
	return

/turf/open/indestructible/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/open/indestructible/white
	icon_state = "white"

/turf/open/indestructible/light
	icon_state = "light_on-1"

/turf/open/indestructible/permalube
	icon_state = "darkfull"

/turf/open/indestructible/permalube/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wet_floor, TURF_WET_LUBE, INFINITY, 0, INFINITY, TRUE)

/turf/open/indestructible/honk
	name = "bananium floor"
	icon_state = "bananium"
	footstep = null
	barefootstep = null
	clawfootstep = null
	heavyfootstep = null
	var/sound = 'sound/effects/clownstep1.ogg'

/turf/open/indestructible/honk/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wet_floor, TURF_WET_SUPERLUBE, INFINITY, 0, INFINITY, TRUE)

/turf/open/indestructible/honk/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(ismob(arrived))
		playsound(src, sound, 50, TRUE)

/turf/open/indestructible/necropolis
	name = "necropolis floor"
	desc = "It's regarding you suspiciously."
	icon = 'icons/turf/floors.dmi'
	icon_state = "necro1"
	baseturfs = /turf/open/indestructible/necropolis
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	footstep = FOOTSTEP_LAVA
	barefootstep = FOOTSTEP_LAVA
	clawfootstep = FOOTSTEP_LAVA
	heavyfootstep = FOOTSTEP_LAVA
	tiled_dirt = FALSE

/turf/open/indestructible/necropolis/Initialize()
	. = ..()
	if(prob(12))
		icon_state = "necro[rand(2,3)]"

/turf/open/indestructible/necropolis/air
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/indestructible/boss //you put stone tiles on this and use it as a base
	name = "necropolis floor"
	icon = 'icons/turf/boss_floors.dmi'
	icon_state = "boss"
	baseturfs = /turf/open/indestructible/boss
	planetary_atmos = TRUE
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/indestructible/boss/air
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/indestructible/hierophant
	icon = 'icons/turf/floors/hierophant_floor.dmi'
	planetary_atmos = TRUE
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	baseturfs = /turf/open/indestructible/hierophant
	smoothing_flags = SMOOTH_CORNERS
	tiled_dirt = FALSE

/turf/open/indestructible/hierophant/two

/turf/open/indestructible/hierophant/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

/turf/open/indestructible/paper
	name = "notebook floor"
	desc = "A floor made of invulnerable notebook paper."
	icon_state = "paperfloor"
	footstep = null
	barefootstep = null
	clawfootstep = null
	heavyfootstep = null
	tiled_dirt = FALSE

/turf/open/indestructible/binary
	name = "tear in the fabric of reality"
	CanAtmosPass = ATMOS_PASS_NO
	baseturfs = /turf/open/indestructible/binary
	icon_state = "binary"
	footstep = null
	barefootstep = null
	clawfootstep = null
	heavyfootstep = null

/turf/open/indestructible/airblock
	icon_state = "bluespace"
	blocks_air = TRUE
	baseturfs = /turf/open/indestructible/airblock

/turf/open/Initalize_Atmos(times_fired)
	excited = FALSE
	update_visuals()

	current_cycle = times_fired
	ImmediateCalculateAdjacentTurfs()
	for(var/i in atmos_adjacent_turfs)
		var/turf/open/enemy_tile = i
		var/datum/gas_mixture/enemy_air = enemy_tile.return_air()
		if(!excited && air.compare(enemy_air))
			//testing("Active turf found. Return value of compare(): [is_active]")
			excited = TRUE
			SSair.active_turfs += src

/turf/open/GetHeatCapacity()
	. = air.heat_capacity()

/turf/open/GetTemperature()
	. = air.temperature

/turf/open/TakeTemperature(temp)
	air.temperature += temp
	air_update_turf(FALSE, FALSE)

/turf/open/proc/freon_gas_act()
	for(var/obj/I in contents)
		if(I.resistance_flags & FREEZE_PROOF)
			continue
		if(!(I.obj_flags & FROZEN))
			I.make_frozen_visual()
	for(var/mob/living/L in contents)
		if(L.bodytemperature <= 50)
			L.apply_status_effect(/datum/status_effect/freon)
	MakeSlippery(TURF_WET_PERMAFROST, 50)
	return TRUE

/turf/open/proc/water_vapor_gas_act()
	MakeSlippery(TURF_WET_WATER, min_wet_time = 100, wet_time_to_add = 50)

	for(var/mob/living/simple_animal/slime/M in src)
		M.apply_water()

	wash(CLEAN_WASH)
	for(var/am in src)
		var/atom/movable/movable_content = am
		if(ismopable(movable_content)) // Will have already been washed by the wash call above at this point.
			continue
		movable_content.wash(CLEAN_WASH)
	return TRUE

/turf/open/handle_slip(mob/living/carbon/C, knockdown_amount, obj/O, lube, paralyze_amount, force_drop)
	if(C.movement_type & FLYING)
		return FALSE
	if(has_gravity(src))
		var/obj/buckled_obj
		if(C.buckled)
			buckled_obj = C.buckled
			if(!(lube&GALOSHES_DONT_HELP)) //can't slip while buckled unless it's lube.
				return FALSE
		else
			if(!(lube & SLIP_WHEN_CRAWLING) && (C.body_position == LYING_DOWN || !(C.status_flags & CANKNOCKDOWN))) // can't slip unbuckled mob if they're lying or can't fall.
				return FALSE
			if(C.m_intent == MOVE_INTENT_WALK && (lube&NO_SLIP_WHEN_WALKING))
				return FALSE
		if(!(lube&SLIDE_ICE))
			to_chat(C, span_notice("You slipped[ O ? " on the [O.name]" : ""]!"))
			playsound(C.loc, 'sound/misc/slip.ogg', 50, TRUE, -3)

		SEND_SIGNAL(C, COMSIG_ON_CARBON_SLIP)
		if(force_drop)
			for(var/obj/item/I in C.held_items)
				C.accident(I)

		var/olddir = C.dir
		C.moving_diagonally = 0 //If this was part of diagonal move slipping will stop it.
		if(!(lube & SLIDE_ICE))
			C.StaminaKnockdown(10, TRUE) //SKYRAT EDIT CHANGE
			//C.Paralyze(paralyze_amount) - SKYRAT EDIT REMOVAL
			C.stop_pulling()
		else
			C.Knockdown(20)

		if(buckled_obj)
			buckled_obj.unbuckle_mob(C)
			lube |= SLIDE_ICE

		if(lube&SLIDE)
			new /datum/forced_movement(C, get_ranged_target_turf(C, olddir, 4), 1, FALSE, CALLBACK(C, /mob/living/carbon/.proc/spin, 1, 1))
		else if(lube&SLIDE_ICE)
			if(C.force_moving) //If we're already slipping extend it
				qdel(C.force_moving)
			new /datum/forced_movement(C, get_ranged_target_turf(C, olddir, 1), 1, FALSE) //spinning would be bad for ice, fucks up the next dir
		return TRUE

/turf/open/proc/MakeSlippery(wet_setting = TURF_WET_WATER, min_wet_time = 0, wet_time_to_add = 0, max_wet_time = MAXIMUM_WET_TIME, permanent)
	AddComponent(/datum/component/wet_floor, wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)

/turf/open/proc/MakeDry(wet_setting = TURF_WET_WATER, immediate = FALSE, amount = INFINITY)
	SEND_SIGNAL(src, COMSIG_TURF_MAKE_DRY, wet_setting, immediate, amount)

/turf/open/get_dumping_location()
	return src

/turf/open/proc/ClearWet()//Nuclear option of immediately removing slipperyness from the tile instead of the natural drying over time
	qdel(GetComponent(/datum/component/wet_floor))

/turf/open/rad_act(strength)
	. = ..()
	var/gas_change = FALSE
	var/list/cached_gases = air.gases
	if(cached_gases[/datum/gas/oxygen] && cached_gases[/datum/gas/carbon_dioxide] && air.temperature <= PLUOXIUM_TEMP_CAP)
		gas_change = TRUE
		var/pulse_strength = min(strength, cached_gases[/datum/gas/oxygen][MOLES] * 1000, cached_gases[/datum/gas/carbon_dioxide][MOLES] * 2000)
		cached_gases[/datum/gas/carbon_dioxide][MOLES] -= pulse_strength / 2000
		cached_gases[/datum/gas/oxygen][MOLES] -= pulse_strength / 1000
		ASSERT_GAS(/datum/gas/pluoxium, air)
		cached_gases[/datum/gas/pluoxium][MOLES] += pulse_strength / 4000
		strength -= pulse_strength

	if(cached_gases[/datum/gas/hydrogen])
		gas_change = TRUE
		var/pulse_strength = min(strength, cached_gases[/datum/gas/hydrogen][MOLES] * 1000)
		cached_gases[/datum/gas/hydrogen][MOLES] -= pulse_strength / 1000
		ASSERT_GAS(/datum/gas/tritium, air)
		cached_gases[/datum/gas/tritium][MOLES] += pulse_strength / 1000
		strength -= pulse_strength

	if(gas_change)
		air.garbage_collect()
		air_update_turf(FALSE, FALSE)
