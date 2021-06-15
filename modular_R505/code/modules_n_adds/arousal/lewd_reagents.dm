//REAGENTS
//Semen
/datum/reagent/semen
	name = "Semen"
	description = "A viscious fluid, secreted by most male biological forms."
	color = "#fff9f1"
	ph = 8
	taste_description = "viscosity and tang"
	taste_mult = 2
	glass_icon_state = "semen"	//Icon ported from citadel
	glass_name = "chalice of semen"
	glass_desc = "In the Sumerian mythology, Enki - the God of water, was believed to have created the Tigris and Euphrates rivers by masturbating and ejaculating into their empty riverbeds."
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/semen/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < MINIMUM_CLIMAX_DECAL_VOLUME)
		return
	if(!isopenturf(exposed_turf))
		return
	if(isspaceturf(exposed_turf))
		return
	var/obj/effect/decal/cleanable/ejaculate/semen/liquid = locate() in exposed_turf
	if(!liquid)
		liquid = new(exposed_turf)
	liquid.reagents.add_reagent(/datum/reagent/semen, reac_volume)

/datum/reagent/semen/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	if(!(methods & TOUCH))
		return ..()
	if(ishuman(exposed_mob))
		switch(reac_volume)
			if(0 to 19)
				exposed_mob.AddComponent(/datum/component/cleanable, 'modular_R505/icons/ported/obj/cumoverlay.dmi', "cum_normal")	//From Hyperstation
			else
				exposed_mob.AddComponent(/datum/component/cleanable, 'modular_R505/icons/ported/obj/cumoverlay.dmi', "cum_large")		//From Hyperstation
	return ..()

/datum/reagent/semen/expose_obj(obj/exposed_obj, reac_volume)
	if(reac_volume > 10)
		exposed_obj.AddComponent(/datum/component/cleanable, 'modular_R505/icons/ported/obj/cumoverlay.dmi', "cum_obj", TRUE)	//From Hyperstation
	return ..()

//Precum
/datum/reagent/precum
	name = "Pre-Ejaculate"
	description = "A slimy lubricant, secreted by most male-gender organisms on instinct before climax."
	color = "#d2d5d6aa"
	ph = 9
	taste_description = "musk"
	glass_icon_state = "glass_clear"
	glass_name = "glass of water"
	glass_desc = "The father of all refreshments."
	shot_glass_icon_state = "shotglassclear"

/datum/reagent/precum/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < MINIMUM_CLIMAX_DECAL_VOLUME)
		return
	if(!isopenturf(exposed_turf))
		return
	if(isspaceturf(exposed_turf))
		return
	var/obj/effect/decal/cleanable/ejaculate/femcum/precum/liquid = locate() in exposed_turf
	if(!liquid)
		liquid = new(exposed_turf)
	liquid.reagents.add_reagent(/datum/reagent/precum, reac_volume)


//girl liquidz
/datum/reagent/femcum
	name = "Female Ejaculate"
	description = "A lubricant found in most female-gender mammals and other animals of similar nature."
	color = "#d2d5d656"
	ph = 6
	taste_description = "tangy"
	glass_icon_state = "glass_clear"
	glass_name = "glass of water"
	glass_desc = "The father of all refreshments."
	shot_glass_icon_state = "shotglassclear"

/datum/reagent/femcum/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < MINIMUM_CLIMAX_DECAL_VOLUME)
		return
	if(!isopenturf(exposed_turf))
		return
	if(isspaceturf(exposed_turf))
		return
	var/obj/effect/decal/cleanable/ejaculate/femcum/liquid = locate() in exposed_turf
	if(!liquid)
		liquid = new(exposed_turf)
	liquid.reagents.add_reagent(/datum/reagent/femcum, reac_volume)


//Milk
/datum/reagent/consumable/milk/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < MINIMUM_CLIMAX_DECAL_VOLUME)
		return
	if(!isopenturf(exposed_turf))
		return
	if(isspaceturf(exposed_turf))
		return
	var/obj/effect/decal/cleanable/ejaculate/milk/liquid = locate() in exposed_turf
	if(!liquid)
		liquid = new(exposed_turf)
	liquid.reagents.add_reagent(/datum/reagent/consumable/milk, reac_volume)

//DECALS
/obj/effect/decal/cleanable/ejaculate
	name = "ejaculate"
	icon = 'modular_r505/icons/ported/obj/genital_fluids.dmi'	//Ported from citadel
	icon_state = "semen1"

/obj/effect/decal/cleanable/ejaculate/semen
	name = "semen"
	icon_state = "semen1"
	random_icon_states = list("semen1", "semen2", "semen3", "semen4")

/obj/effect/decal/cleanable/ejaculate/femcum
	name = "female ejaculate"
	icon_state = "fem1"
	random_icon_states = list("fem1", "fem2", "fem3", "fem4")

/obj/effect/decal/cleanable/ejaculate/femcum/precum
	name = "precum"

/obj/effect/decal/cleanable/ejaculate/milk
	name = "milk"
	icon_state = "milk1"
	random_icon_states = list("milk1", "milk2", "milk3", "milk4")
