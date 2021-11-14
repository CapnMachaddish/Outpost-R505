/datum/pollutant/crocin
	name = "Crocin"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL
	descriptor = SCENT_DESC_SMELL
	smell_intensity = 1
	scent = "cotton candy"
	color = "#FFADFF"

/datum/pollutant/hexacrocin
	name = "Hexacrocin"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	descriptor = SCENT_DESC_FRAGRANCE
	thickness = 3
	smell_intensity = 5
	scent = "fruit"
	color = "#FF2BFF"
	var/datum/component/arousal/arousal

/datum/pollutant/hexacrocin/BreatheAct(mob/living/carbon/victim, amount)
	if(!(victim.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return
	if(!arousal)
		arousal = victim.GetComponent(/datum/component/arousal)
	arousal.adjustArousalLoss(5)

/datum/pollutant/breast_enlarger
	name = "Succubus Milk"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL
	descriptor = SCENT_DESC_SMELL
	thickness = 0.2
	smell_intensity = 1
	scent = "milk"

/datum/pollutant/penis_enlarger
	name = "Incubus Draft"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL
	descriptor = SCENT_DESC_FRAGRANCE
	thickness = 0.1
	smell_intensity = 10
	scent = "cinnamon"
	color = "#c49898"
