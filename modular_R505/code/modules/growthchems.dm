//These chems are currently not possible to create, merely skeletons for now.

//Titchem
/datum/reagent/drug/succubus_milk
	name = "Succubus Milk"
	description = "A drug, well known amongst certain circles, rumored to increase the size of one's bust."
	taste_description = "silky smooth, with a stange and offputting aftertaste"
	trippy = FALSE
	overdose_threshold = 30
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/succubus_milk/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/obj/item/organ/genital/breasts/breast
	var/mob/living/carbon/human/H = M
	for(var/X in H.internal_organs)
		if(istype(X, /obj/item/organ/genital/breasts))
			breast = X
	if(!breast)
		breast.uses_skintones = TRUE
		breast.Initialize()
		breast.Insert(H)
	to_chat(H, "You feel a tingling in your chest...")
	breast.change_breast_size(0.04) //1 cup size per 5u
	..()
	return

/datum/reagent/drug/succubus_milk/overdose_process(mob/living/M, delta_time, times_fired)
	var/obj/item/organ/genital/breasts/breast
	var/mob/living/carbon/human/H = M
	for(var/X in H.internal_organs)
		if(istype(X, /obj/item/organ/genital/breasts))
			breast = X
	if(!breast)
		breast.New()
		breast.Initialize()
		breast.uses_skintones = TRUE
		breast.Insert(H)
	var/obj/item/organ/genital/penis/dick
	to_chat(H, "<span class='userdanger'>You feel your chest burn and your groin shrivel...</span>")
	for(var/X in H.internal_organs)
		if(istype(X, /obj/item/organ/genital/penis))
			dick = X
	breast.change_breast_size(0.04 * REM * delta_time) //Grow yo titties
	if(dick)
		dick.change_penis_length(-0.04 * REM * delta_time) //Shrink yo dicc, if you have one.
	..()
	return


//Dickchem
/datum/reagent/drug/incubus_draft
	name = "Incubus draft"
	description = "A drug, well known amongst certain circles, rumored to increase the size of one's member."
	taste_description = "vile and repulsive"
	trippy = FALSE
	overdose_threshold = 30
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/incubus_draft/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	var/obj/item/organ/genital/penis/dick
	var/mob/living/carbon/human/H = M
	for(var/X in H.internal_organs)
		if(istype(X, /obj/item/organ/genital/penis))
			dick = X
	if(!dick)
		dick.Initialize()
		dick.uses_skintones = TRUE
		dick.Insert(H)
	to_chat(H, "You feel a tingling in your groin...")
	dick.change_penis_length(0.04) //Increases by 1 inch per 5u.
	..()
	return

/datum/reagent/drug/incubus_draft/overdose_process(mob/living/M, delta_time, times_fired)
	var/obj/item/organ/genital/breasts/breast
	var/mob/living/carbon/human/H = M
	for(var/X in H.internal_organs)
		if(istype(X, /obj/item/organ/genital/breasts))
			breast = X
	var/obj/item/organ/genital/penis/dick
	to_chat(H, "<span class='userdanger'> You feel your groin burn and your chest flatten...</span>")
	for(var/X in H.internal_organs)
		if(istype(X, /obj/item/organ/genital/penis))
			dick = X
	if(!dick)
		dick.Initialize()
		dick.uses_skintones = TRUE
		dick.Insert(H)
	if(breast)
		breast.change_breast_size(-0.04 * REM * delta_time) //Shrink yo titties, if you have one
	dick.change_penis_length(0.04 * REM * delta_time) //Grow yo dicc
	..()
	return