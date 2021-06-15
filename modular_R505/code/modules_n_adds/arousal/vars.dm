/datum/species
	//The multiplier for how fast a species gets aroused
	var/arousal_rate = AROUSAL_RATE
	//The multiplier for how fast a species loses arousal. Currently unused
	var/arousal_loss_rate = AROUSAL_RATE

/datum/hud
	var/atom/movable/screen/arousal/arousal

/obj/item/organ/genital
	//The arousal forced to be shown, changed by verbs, if non-zero
	var/forced_arousal = AROUSAL_CANT
	//How many units of cum/milk/JUICE is inside this genital
	var/fluid_amount = 0
	//This is scaled with a proc
	var/max_fluid_amount = 0
	//What this genital produces when it has to produce something.
	var/fluid_type = list()
	//And how productive this genital is when secreting the fluids
	var/productivity = 0.65

/obj/item/organ/genital/penis
	fluid_type = list(/datum/reagent/precum=0.78,/datum/reagent/water=0.22)
	max_fluid_amount = DEFAULT_GENITAL_REAGENT_VOLUME
	productivity = PENIS_DEFAULT_PRODUCTIVITY

/obj/item/organ/genital/testicles
	fluid_type = list(/datum/reagent/semen=1)
	max_fluid_amount = DEFAULT_GENITAL_REAGENT_VOLUME
	productivity = TESTICLE_DEFAULT_PRODUCTIVITY

/obj/item/organ/genital/breasts
	fluid_type = list(/datum/reagent/consumable/milk=1)
	max_fluid_amount = DEFAULT_GENITAL_REAGENT_VOLUME
	productivity = BREASTS_DEFAULT_PRODUCTIVITY

/obj/item/organ/genital/vagina
	fluid_type = list(/datum/reagent/femcum=0.78,/datum/reagent/water=0.22)
	max_fluid_amount = DEFAULT_GENITAL_REAGENT_VOLUME
	productivity = VAGINA_DEFAULT_PRODUCTIVITY
