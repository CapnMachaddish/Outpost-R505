//quick and dirty aphrodisiacs for the new base

/datum/reagent/drug/aphrodisiac
	name = "Crocin"
	description = "Naturally found in the crocus and gardenia flowers, this drug acts as a natural and safe aphrodisiac."
	taste_description = "strawberries"
	color = "#FFADFF"//light pink, rgb(255, 173, 255)
	var/datum/component/arousal/arousal_component

/datum/reagent/drug/aphrodisiac/on_mob_life(mob/living/carbon/M)
	if(M.client && (M.client.prefs.skyrat_toggles & APHRO_PREF) && prob(66))
		if((prob(min(current_cycle/2,5))))
			M.emote(pick("moan","blush"))
		if(prob(min(current_cycle/4,10)))
			to_chat(M, "<span class='userlove'>[pick(list("You feel frisky...", "You're having trouble suppressing your urges...", "You feel in the mood..."))]</span>")
		if(!arousal_component)
			arousal_component = M.GetComponent(/datum/component/arousal)
		if(arousal_component)
			arousal_component.adjustArousalLoss(1)
		else
			for(var/obj/item/organ/genital/G in M.internal_organs)
				if(G.aroused != AROUSAL_CANT)
					G.aroused = AROUSAL_FULL
					G.update_sprite_suffix()
			M.update_body()
	..()

/datum/reagent/drug/aphrodisiacplus
	name = "Hexacrocin"
	description = "Chemically condensed form of basic crocin. This aphrodisiac is extremely powerful and addictive in most animals.\
					Addiction withdrawals can cause brain damage and shortness of breath. Overdosage can lead to brain damage."
	taste_description = "liquid desire"
	color = "#FF2BFF"//pink
	addiction_types = list(/datum/addiction/hallucinogens = 10)
	overdose_threshold = 20
	var/datum/component/arousal/arousal_component

/datum/reagent/drug/aphrodisiacplus/on_mob_life(mob/living/carbon/M)
	if(!arousal_component)
		arousal_component = M.GetComponent(/datum/component/arousal)
	if(arousal_component)
		arousal_component.adjustArousalLoss(1)
	else
		for(var/obj/item/organ/genital/G in M.internal_organs)
			if(!G.aroused == AROUSAL_CANT)
				G.aroused = AROUSAL_FULL
				G.update_sprite_suffix()
		M.update_body()
	if(M.client && (M.client.prefs.skyrat_toggles & APHRO_PREF))
		if(prob(5))
			if(prob(current_cycle))
				M.say(pick("Hnnnnngghh...", "Ohh...", "Mmnnn..."))
			else
				M.emote(pick("moan","blush"))
		if(prob(5))
			var/aroused_message
			if(current_cycle>25)
				aroused_message = pick("You need to fuck someone!", "You're bursting with sexual tension!", "You can't get sex off your mind!")
			else
				aroused_message = pick("You feel a bit hot.", "You feel strong sexual urges.", "You feel in the mood.", "You're ready to go down on someone.")
			to_chat(M, "<span class='userlove'>[aroused_message]</span>")
			
	..()

/datum/reagent/drug/aphrodisiacplus/overdose_process(mob/living/carbon/M)
	if(M.client && (M.client.prefs.skyrat_toggles & APHRO_PREF) && prob(33))
		if(prob(5) && ishuman(M))
			M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2, BRAIN_DAMAGE_SEVERE*0.75)
			to_chat(M, "<span class='notice'>Your libido is going haywire!</span>")
	..()

/obj/item/reagent_containers/pill/crocin
	name = "crocin pill"
	desc = "A safe aphrodisiac."
	icon_state = "pill_happy"
	list_reagents = list(/datum/reagent/drug/aphrodisiac = 20)
	rename_with_volume = TRUE

/obj/item/reagent_containers/pill/hexacrocin
	name = "hexacrocin pill"
	desc = "An extremely powerful and addictive aphrodisiac."
	icon_state = "pill_happy"
	list_reagents = list(/datum/reagent/drug/aphrodisiacplus = 20)
	rename_with_volume = TRUE
