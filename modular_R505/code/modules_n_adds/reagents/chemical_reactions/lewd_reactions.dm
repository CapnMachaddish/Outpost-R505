
////////////////////////
///CHEMICAL REACTIONS///
////////////////////////

/datum/chemical_reaction/crocin
	results = list(/datum/reagent/drug/crocin = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/water = 1)
	required_temp = 400
	mix_message = "The mixture boils off a pink vapor..."
	mob_react = FALSE
	reaction_tags = REACTION_TAG_OTHER
	pollutant_type = /datum/pollutant/crocin

/datum/chemical_reaction/hexacrocin
	results = list(/datum/reagent/drug/hexacrocin = 1)
	required_reagents = list(/datum/reagent/drug/crocin = 6, /datum/reagent/phenol = 1)
	required_temp = 600 //hexacrocin now more dangerous, so higher temperature to prevent clowns making it in ghetto and using smokemachine with it.
	mix_message = "The mixture rapidly condenses and darkens in color..."
	reaction_tags = REACTION_TAG_OTHER
	pollutant_type = /datum/pollutant/hexacrocin
	pollutant_amount = 0.35

/datum/chemical_reaction/camphor
	results = list(/datum/reagent/drug/camphor = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/sulfur = 1)
	required_temp = 400
	mix_message = "The mixture boils off a yellow, smelly vapor..."//Sulfur burns off, leaving the camphor
	reaction_tags = REACTION_TAG_OTHER
	pollutant_type = /datum/pollutant/toxic/sulfur

/datum/chemical_reaction/pentacamphor //liquid equivalent of horny jail
	results = list(/datum/reagent/drug/pentacamphor = 1)
	required_reagents = list(/datum/reagent/drug/camphor = 5, /datum/reagent/acetone = 1)
	required_temp = 500
	mix_message = "The mixture thickens..."
	reaction_tags = REACTION_TAG_OTHER

/datum/chemical_reaction/breast_enlarger
	results = list(/datum/reagent/breast_enlarger = 8)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/silicon = 3, /datum/reagent/drug/crocin = 3)
	mix_message = "the reaction gives off a white mist."
	reaction_tags = REACTION_TAG_OTHER
	pollutant_type = /datum/pollutant/breast_enlarger
	pollutant_amount = 0.1

/datum/chemical_reaction/penis_enlarger
	results = list(/datum/reagent/penis_enlarger = 8)
	required_reagents = list(/datum/reagent/blood = 5, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/carbon = 2, /datum/reagent/drug/crocin = 2, /datum/reagent/medicine/salglu_solution = 1)
	mix_message = "the reaction gives off a spicy scent."
	reaction_tags = REACTION_TAG_OTHER
	pollutant_type = /datum/pollutant/penis_enlarger
	pollutant_amount = 0.1
