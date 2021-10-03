/mob/living/simple_animal/hostile/heliophage
	name = "heliophage template"
	real_name = "heliophage template"
	desc = "This shouldn't exist! If you see this, file a bug report."
	gender = NEUTER
	mob_biotypes = NONE //Might change this later if there's a "living plasma bullshit" biotype
	speak_emote = list("hisses", "crackles", "thrums")
	response_help_continuous = "thinks better of touching"
	response_help_simple = "think better of touching"
	//Change these once I work out how to make people burn their fingies
	response_disarm_continuous = "flails at"
	response_disarm_simple = "flail at"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"

	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity2"
	speed = 0
	combat_mode = TRUE
	damage_coeff = list(BRUTE = 1, BURN = -1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = INFINITY
	healable = 0
	faction = list("heliophage")
	pressure_resistance = 100
	AIStatus = AI_ON
	loot = list()
	del_on_death = TRUE
	deathmessage = "disintegrates into a cloud of stellar plasma."

/mob/living/simple_animal/hostile/heliophage/Initialize()
	. = ..()
	AddElement(/datum/element/simple_flying)
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/mob/living/simple_animal/hostile/heliophage/Destroy()
	var/turf/open/location = get_turf(loc)
	//Add smol plas fire on death
	location.atmos_spawn_air("o2=5;plasma=5;TEMP=1000")
	. = ..()

//Your most basic form of Heliophage - little floaty balls of fiery energy. Weak but fast-moving.
/mob/living/simple_animal/hostile/heliophage/spore
	name = "heliophage spore"
	real_name = "heliophage spore"
	desc = "A crackling ball of radiant living electroplasma. It moves and twitches through the air erratically, lashing out at its surroundings with electrical arcs."
	icon_state = "electricity2"
	icon_living = "electricity2"
	maxHealth = 35
	health = 35
	melee_damage_lower = 8
	melee_damage_upper = 10
	retreat_distance = 4 //These little shits are supposed to dodge and weave in and out of melee.
	attack_verb_continuous = "scorches"
	attack_verb_simple = "scorch"
	attack_sound = 'sound/weapons/sear.ogg'
	speed = 5