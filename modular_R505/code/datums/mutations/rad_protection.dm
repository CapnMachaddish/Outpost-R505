/datum/mutation/human/radiation_protection
	name = "Impervious Skin"
	desc = "Strengthens the skin of the host in a phenominal way that protects against the effects of radiation. The host can still become contaminated, however."
	quality = POSITIVE
	difficulty = 10
	instability = 25
	text_gain_indication = "<span class='warning'>Your skin feels baggy and leathery.</span>"
	text_lose_indication = "<span class='warning'>Your skin tightens and becomes crusty.</span>"

/datum/mutation/human/radiation_protection/on_acquiring(mob/living/carbon/human/H)
	if(..())
		return
	ADD_TRAIT(H, TRAIT_RADIMMUNE, GENETIC_MUTATION)

/datum/mutation/human/radiation_protection/on_losing(mob/living/carbon/human/H)
	if(..())
		return
	REMOVE_TRAIT(H, TRAIT_RADIMMUNE, GENETIC_MUTATION)
