/datum/pollutant/toxic
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	descriptor = SCENT_DESC_ODOR
	thickness = 8
	smell_intensity = 20
	//The reagent that gets added when we breathe this in
	var/datum/reagent/reagent_breathing
	//How many units of the reagent we breathe in
	var/reagent_amount = REAGENTS_METABOLISM

/datum/pollutant/toxic/BreatheAct(mob/living/carbon/victim, amount)
	victim.reagents.add_reagent(reagent_breathing, reagent_amount * amount)

/datum/pollutant/toxic/sulfur
	name = "Sulfur"
	color = "#BF8C00"
	scent = "rotten eggs"
	reagent_breathing = /datum/reagent/sulfur

/datum/pollutant/toxic/sulfur/BreatheAct(mob/living/carbon/victim, amount)
	..()
	if(amount > 10)
		victim.emote("cough")
