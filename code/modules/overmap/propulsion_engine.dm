/obj/machinery/atmospherics/components/unary/engine
	name = "propulsion engine"
	icon_state = "propulsion"
	icon = 'icons/turf/shuttle.dmi'
	circuit = /obj/item/circuitboard/machine/propulsion_engine
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	smoothing_groups = list(SMOOTH_GROUP_SHUTTLE_PARTS)
	max_integrity = 500
	armor = list(MELEE = 100, BULLET = 10, LASER = 10, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 70) //default + ignores melee
	CanAtmosPass = ATMOS_PASS_DENSITY
	density = TRUE
	anchored = TRUE

	pipe_color = COLOR_TAN_ORANGE
	vent_movement = NONE
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY
	processing_flags = NONE

	can_be_unanchored = TRUE
	move_resist = MOVE_RESIST_DEFAULT

	var/is_welded = FALSE
	var/starts_welded = TRUE

	var/extension_type = /datum/shuttle_extension/engine/propulsion
	var/datum/shuttle_extension/engine/propulsion/extension

/obj/machinery/atmospherics/components/unary/engine/SetInitDirections()
	initialize_directions = REVERSE_DIR(dir)

/obj/machinery/atmospherics/components/unary/engine/Initialize(mapload)
	extension = new extension_type(src)
	if(starts_welded)
		weld_down(mapload)
		//This needs to be connected a moment after a lot of other initialization stuff happens
		//Late initialize does not seem to work for this (doesnt get caled at all), so a timer
		addtimer(CALLBACK(src, .proc/ApplyExtension))
	. = ..()

/obj/machinery/atmospherics/components/unary/engine/proc/ApplyExtension()
	if(extension.IsApplied()) //This can and will be a case due to nessecary timer help
		return
	extension.ApplyToPosition(get_turf(src))

/obj/machinery/atmospherics/components/unary/engine/Destroy()
	extension.RemoveExtension()
	qdel(extension)
	return ..()

/obj/machinery/atmospherics/components/unary/engine/isConnectable(obj/machinery/atmospherics/target, given_layer)
	if(is_welded)
		return ..()
	return FALSE

/obj/machinery/atmospherics/components/unary/engine/proc/weld_down(mapload)
	if(is_welded)
		return
	is_welded = TRUE
	can_be_unanchored = FALSE
	move_resist = INFINITY
	ApplyExtension()
	if(mapload) //Atmos isn't initialized at mapload
		return
	SetInitDirections()
	atmosinit()
	if(length(nodes))
		var/obj/machinery/atmospherics/node = nodes[1]
		if(node)
			node.atmosinit()
			node.addMember(src)
	SSair.add_to_rebuild_queue(src)

/obj/machinery/atmospherics/components/unary/engine/proc/unweld()
	if(!is_welded)
		return
	move_resist = MOVE_RESIST_DEFAULT
	is_welded = FALSE
	can_be_unanchored = TRUE
	extension.RemoveExtension()
	if(length(nodes))
		var/obj/machinery/atmospherics/node = nodes[1]
		if(node)
			node.disconnect(src)
			node = null
			nullifyPipenet(parents[1])
			nodes[1] = null

/obj/machinery/atmospherics/components/unary/engine/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, .proc/can_be_rotated))

/obj/machinery/atmospherics/components/unary/engine/proc/can_be_rotated(mob/user, rotation_type)
	if(is_welded)
		to_chat(user, "<span class='warning'>It is welded to the floor!</span>")
		return FALSE
	if(anchored)
		to_chat(user, "<span class='warning'>It is fastened to the floor!</span>")
		return FALSE
	return TRUE

/obj/machinery/atmospherics/components/unary/engine/can_be_unfasten_wrench(mob/user, silent)
	if(is_welded)
		if(!silent)
			to_chat(user, "<span class='warning'>[src] is welded to the floor!</span>")
		return FAILED_UNFASTEN

	return ..()

/obj/machinery/atmospherics/components/unary/engine/wrench_act(mob/living/user, obj/item/item)
	default_unfasten_wrench(user, item)
	return TRUE

/obj/machinery/atmospherics/components/unary/engine/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(!anchored)
		to_chat(user, "<span class='warning'>The [src.name] needs to be wrenched to the floor!</span>")
		return TRUE
	if(!is_welded)	
		if(!I.tool_start_check(user, amount=0))
			return TRUE
		user.visible_message("<span class='notice'>[user.name] starts to weld the [name] to the floor.</span>", \
			"<span class='notice'>You start to weld \the [src] to the floor...</span>", \
			"<span class='hear'>You hear welding.</span>")
		if(I.use_tool(src, user, 3 SECONDS, volume=50))
			weld_down()
			to_chat(user, "<span class='notice'>You weld \the [src] to the floor.</span>")
		return TRUE
	else
		if(!I.tool_start_check(user, amount=0))
			return TRUE
		user.visible_message("<span class='notice'>[user.name] starts to cut the [name] free from the floor.</span>", \
			"<span class='notice'>You start to cut \the [src] free from the floor...</span>", \
			"<span class='hear'>You hear welding.</span>")
		if(I.use_tool(src, user, 3 SECONDS, volume=50))
			unweld()
			to_chat(user, "<span class='notice'>You cut \the [src] free from the floor.</span>")
		return TRUE

#define ENGINE_MINIMUM_OPERATABLE_MOLES 0.1
#define ENGINE_BASELINE_MOLE_INTAKE 1

/obj/machinery/atmospherics/components/unary/engine/proc/DrawThrust(impulse_power)
	var/datum/gas_mixture/gas = airs[1]
	var/total_moles = gas.total_moles()
	if(total_moles < ENGINE_MINIMUM_OPERATABLE_MOLES)
		return 0
	var/demand_mutliplier = T20C / gas.temperature
	var/transfer_moles = ENGINE_BASELINE_MOLE_INTAKE * demand_mutliplier * impulse_power
	var/returned_efficiency = 1
	if(transfer_moles > total_moles)
		returned_efficiency = (total_moles / transfer_moles)
		transfer_moles = total_moles

	var/datum/gas_mixture/removed = gas.remove(transfer_moles)
	//Dumps used air out of the engine - TODO in the future remove this for a cool flame effect that burns people (would need implementing an "in-use" state, which currently isnt present)
	var/turf/dump_place = get_turf(src)
	dump_place = get_step(dump_place,dir) //Step into the direction we're dumping the waste
	dump_place.assume_air(removed)
	return returned_efficiency

#undef ENGINE_BASELINE_MOLE_INTAKE
#undef ENGINE_MINIMUM_OPERATABLE_MOLES

#define ENGINE_PRESSURE_POINT_FULL 4500 //Pressure point at which it'll return 100%

/obj/machinery/atmospherics/components/unary/engine/proc/GetCurrentFuel()
	var/pressure = airs[1].return_pressure()
	var/percentage = FLOOR((pressure/ENGINE_PRESSURE_POINT_FULL)*100,1)
	if(percentage > 100) //Overpressurized engine, still show 100%
		percentage = 100
	return percentage

#undef ENGINE_PRESSURE_POINT_FULL

/obj/machinery/atmospherics/components/unary/engine/not_welded
	starts_welded = FALSE

/obj/item/circuitboard/machine/propulsion_engine
	name = "Propulsion Engine (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/engine/not_welded
