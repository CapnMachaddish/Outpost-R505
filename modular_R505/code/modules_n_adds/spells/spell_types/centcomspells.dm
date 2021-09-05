/obj/effect/proc_holder/spell/targeted/area_teleport/teleport/centcom
	invocation = "none"
	invocation_type = "none"
	clothes_req = FALSE
	say_destination = FALSE

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/shift/adminbus
	name = "Phase Shift"
	desc = "This spell allows you to pass through walls."

	school = "transmutation"
	charge_max = 15 SECONDS
	clothes_req = FALSE
	invocation = "none"
	invocation_type = "none"
	jaunt_duration = 5 SECONDS
	action_icon = 'icons/mob/actions/actions_cult.dmi'
	action_icon_state = "phaseshift"
	action_background_icon_state = "bg_demon"
	jaunt_in_time = 0.6 SECONDS
	jaunt_out_time = 0.6 SECONDS
	jaunt_in_type = /obj/effect/temp_visual/dir_setting/cult/phase
	jaunt_out_type = /obj/effect/temp_visual/dir_setting/cult/phase/out
