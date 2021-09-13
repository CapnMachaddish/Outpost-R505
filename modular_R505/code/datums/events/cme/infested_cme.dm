/datum/round_event_control/cme/infested
	name = "Infested Coronal Mass Ejection"
	typepath = /datum/round_event/cme/infested
	weight = 5
	max_occurrences = 1
	earliest_start = 25 MINUTES

/datum/round_event/cme/infested
	cme_intensity = "minimal" //very minor hack because we compile before Ratcode.

/datum/round_event/cme/infested/announce()
	. = ..()
	spawn(rand(2,4)*100)
		priority_announce("WARNING: Long-range monitoring satellites have detected unknown lifesigns in the approaching solar storm. \
		Caution is advised when approaching magnetic field event sites.", "Solar Event Update", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))



/datum/round_event/cme/infested/spawn_cme(turf/spawnpoint, intensity)
	. = ..()
	//spawn heliophages
	for(var/i = 0 to rand(1,6))
		new /mob/living/simple_animal/hostile/heliophage/spore(spawnpoint)