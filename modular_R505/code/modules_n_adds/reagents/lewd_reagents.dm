///////////////////
///REPRODUCTIVES///
///////////////////
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


//girl liquidite
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

//////////////////
///APHRODISIACS///
//////////////////
/datum/reagent/drug/crocin
	name = "Crocin"
	description = "Naturally found in the crocus and gardenia flowers, this drug acts as a natural and safe aphrodisiac."
	taste_description = "strawberries"
	color = "#FFADFF"

/datum/reagent/drug/crocin/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	..()
	if(M.client && (M.client.prefs.r_preferences & R_PREF_LEWDCHEM))
		AROUSAL_VAR(arousal, M)
		if(DT_PROB(min(current_cycle/2,5), delta_time))
			M.emote(pick("moan","blush"))
		if(DT_PROB(min(current_cycle/4,10), delta_time))
			to_chat(M, span_notice("[pick(arousal.arousal_messages)]"))
		arousal.adjustArousalLoss(1)

/datum/reagent/drug/hexacrocin
	name = "Hexacrocin"
	description = "Chemically condensed form of basic crocin. This aphrodisiac is extremely powerful and addictive for most animals.\
					Addiction withdrawals can cause brain damage and shortness of breath. Overdose can lead to brain traumas."
	taste_description = "liquid desire"
	color = "#FF2BFF"//dark pink
	overdose_threshold = 28 //Heavy consequences. Supposed to be big value.

/datum/reagent/drug/hexacrocin/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	..()
	if(M.client && (M.client.prefs.r_preferences & R_PREF_LEWDCHEM))
		AROUSAL_VAR(arousal, M)
		if(DT_PROB(5, delta_time))
			if(prob(current_cycle))
				M.say(pick("Hnnnnngghh...", "Ohh...", "Mmnnn...","Ghhmph..."))
			else
				M.emote(pick("moan","blush"))
		if(DT_PROB(arousal.aroused_messages_chance, delta_time))
			var/aroused_message
			if(current_cycle>25)
				aroused_message = pick("You need to fuck someone!", "You're bursting with sexual tension!", "You can't get sex off your mind!")
			else
				aroused_message = pick(AROUSED_MESSAGES)
			to_chat(M, span_purple("[aroused_message]"))
		arousal.adjustArousalLoss(2)

/datum/reagent/drug/hexacrocin/overdose_process(mob/living/carbon/M)
	if(M.client && (M.client.prefs.r_preferences & R_PREF_LEWDCHEM))
		if(prob(5) && ishuman(M) && !HAS_TRAIT(M, TRAIT_BIMBO) && !HAS_TRAIT(M, TRAIT_SOBSESSED))
			to_chat(M, span_purple("Your libido is going haywire!..."))
			M.gain_trauma(/datum/brain_trauma/special/bimbo, TRAUMA_RESILIENCE_BASIC) //what am i doing with my life.
			ADD_TRAIT(M, TRAIT_BIMBO, LEWDCHEM_TRAIT)

////////////////////
///ANAPHRODISIACS///
////////////////////
/datum/reagent/drug/camphor
	name = "Camphor"
	description = "Naturally found in some species of evergreen trees, camphor is a waxy substance. When ingested by most animals, it acts as an anaphrodisiac\
					, reducing libido and calming them. Non-habit forming and non-addictive."
	taste_description = "dull bitterness"
	taste_mult = 2
	color = "#D9D9D9"
	reagent_state = SOLID

/datum/reagent/drug/camphor/on_mob_life(mob/living/carbon/M)
	..()
	if(M.client && (M.client.prefs.r_preferences & R_PREF_LEWDCHEM))
		M.GetComponent(/datum/component/arousal)?.adjustArousalLoss(-12)

/datum/reagent/drug/pentacamphor
	name = "Pentacamphor"
	description = "Chemically condensed camphor. Causes an extreme reduction in libido and a permanent one if overdosed. Non-addictive."
	taste_description = "tranquil celibacy"
	color = "#D9D9D9"
	reagent_state = SOLID
	overdose_threshold = 20

/datum/reagent/drug/pentacamphor/on_mob_life(mob/living/carbon/human/M)
	..()
	if(M.client && (M.client.prefs.r_preferences & R_PREF_LEWDCHEM))
		M.GetComponent(/datum/component/arousal)?.adjustArousalLoss(-18)

		M.reagents.remove_reagent(/datum/reagent/drug/crocin, 20)
		M.reagents.remove_reagent(/datum/reagent/drug/hexacrocin, 20)

/datum/reagent/drug/pentacamphor/overdose_process(mob/living/carbon/human/M, delta_time, times_fired)
	if(M.client && (M.client.prefs.r_preferences & R_PREF_LEWDCHEM))
		if(!HAS_TRAIT(M, TRAIT_BIMBO) && !HAS_TRAIT(M, TRAIT_NEVERBONER))
			to_chat(M, span_notice("You feel like you'll never feel aroused again...")) //Go to horny jail *bonk*
			ADD_TRAIT(M,TRAIT_NEVERBONER, LEWDCHEM_TRAIT)

		if(HAS_TRAIT(M, TRAIT_BIMBO))
			if(DT_PROB(30, delta_time))
				M.cure_trauma_type(/datum/brain_trauma/special/bimbo, TRAUMA_RESILIENCE_BASIC)
				to_chat(M, span_notice("Your mind is free from purple liquid substance. Your thoughts are pure and innocent again."))
				REMOVE_TRAIT(M, TRAIT_BIMBO, LEWDCHEM_TRAIT)

////////////////////////////////////////////////////////////////////////////////////////////////////
//										ENLARGE CHEMS											  //
////////////////////////////////////////////////////////////////////////////////////////////////////
/datum/reagent/breast_enlarger
	name = "Succubus milk"
	description = "A volatile collodial mixture derived from milk that encourages mammary production via a potent estrogen mix."
	color = "#E60584" // rgb: 96, 0, 255
	taste_description = "ice cream"
	overdose_threshold = 17
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/breast_enlarger/on_mob_metabolize(mob/living/M)
	. = ..()
	if(!ishuman(M)) //The monkey clause
		if(volume >= 15)
			var/turf/T = get_turf(M)
			var/obj/item/organ/genital/breasts/B = new /obj/item/organ/genital/breasts(T)
			M.visible_message(span_warning("A pair of breasts suddenly fly out of the [M]!</b>"))	//beautiful
			var/T2 = get_random_station_turf()
			M.adjustBruteLoss(25)
			M.Paralyze(50)
			M.Stun(50)
			M.emote("scream")
			B.throw_at(T2, 8, 1)
		M.reagents.del_reagent(type)
		return

/datum/reagent/breast_enlarger/on_mob_life(mob/living/carbon/human/H) //Increases breast size
	..()
	if(!ishuman(H))
		return
	if(!(H.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return

	var/obj/item/organ/genital/breasts/B = H.getorganslot(ORGAN_SLOT_BREASTS)

	if(!B)
		B = new(H)
		B.build_from_dna(H.dna, "breasts", TRUE)
		B.genital_size = 1
		B.Insert(H)
		B.update_genital_icon_state()

	B.set_size(B.genital_size + (0.07 * purity))
	H.update_body()

/datum/reagent/breast_enlarger/overdose_process(mob/living/carbon/human/H)
	if(!ishuman(H))
		return
	if(!(H.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return

	var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)

	if(P)
		P.set_size(P.genital_size - (0.2 / purity))
		if(P.genital_size < 2)
			P.Remove(H)
			qdel(P)
			if(prob(1) && prob(20))	//i gotta
				to_chat(H, span_warning("Your penis turns into a penwas!"))
	if(T)
		P.set_size(T.genital_size - (0.2 / purity))
		if(T.genital_size < 1)
			T.Remove(H)
			qdel(T)
		
	if(!P && !T && H.gender == MALE)
		H.set_gender(FEMALE)
		H.body_type = FEMALE
		H.update_body()
		H.update_mutations_overlay()
		if(!H.reagents.has_reagent(/datum/reagent/penis_enlarger))	//Spam prevention
			to_chat(H, span_warning("You feel a newfound sensitivity on your chest that you never felt before."))
		return
	H.update_body()

/datum/reagent/penis_enlarger
	name = "Incubus draft"
	description = "A volatile collodial mixture derived from various masculine solutions that encourages a larger gentleman's package via a potent testosterone mix, formula derived from a collaboration from Fermichem  and Doctor Ronald Hyatt, who is well known for his phallus palace." //The toxic masculinity thing is a joke because I thought it would be funny to include it in the reagents, but I don't think many would find it funny? dumb
	color = "#c49898" //pinkish/greyish
	taste_description = "chinese dragon powder"
	overdose_threshold = 17 //ODing makes you male and removes female genitals
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/penis_enlarger/on_mob_metabolize(mob/living/M)
	. = ..()
	if(!ishuman(M)) //Just monkeying around.
		if(volume >= 15)
			var/turf/T = get_turf(M)
			var/obj/item/organ/genital/penis/P = new /obj/item/organ/genital/penis(T)
			M.visible_message(span_warning("A penis suddenly flies out of the [M]!</b>"))
			var/T2 = get_random_station_turf()
			M.adjustBruteLoss(25)
			M.Paralyze(50)
			M.Stun(50)
			M.emote("scream")
			P.throw_at(T2, 8, 1)
		M.reagents.del_reagent(type)
		return

/datum/reagent/penis_enlarger/on_mob_life(mob/living/carbon/human/H)
	..()
	if(!ishuman(H))
		return
	if(!(H.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return

	var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)

	if(!P)
		P = new(H)
		P.build_from_dna(H.dna, "penis", TRUE)
		P.genital_size = 1
		P.Insert(H)
		P.update_genital_icon_state()
	
	var/increase = 0.7 * purity
	P.girth += increase * 0.3
	P.set_size(P.genital_size + increase)
	H.update_body()

/datum/reagent/penis_enlarger/overdose_process(mob/living/carbon/human/H) //Turns you into a male if female and ODing, doesn't touch nonbinary and object genders.
	if(!istype(H))
		return
	if(!(H.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return
	
	var/obj/item/organ/genital/breasts/B = H.getorganslot(ORGAN_SLOT_BREASTS)

	if(B)
		B.genital_size -= 0.2 / purity
		if(B.genital_size < 2)
			B.Remove(H)
			qdel(B)
		else
			B.update_sprite_suffix()
		
	if(!B && H.gender == FEMALE)
		var/obj/item/organ/genital/vagina/V = H.getorganslot(ORGAN_SLOT_VAGINA)
		var/obj/item/organ/genital/womb/W = H.getorganslot(ORGAN_SLOT_WOMB)
		var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)
		if(V)
			V.Remove(H)
			qdel(V)
		if(W)
			W.Remove(H)
			qdel(W)
		if(!T)	//Only give 'em a new pair if they didn't have any before
			T = new(H)
			T.build_from_dna(H.dna, "testicles", TRUE)
			T.set_size(1.3)
			T.Insert(H)

		H.set_gender(MALE)
		H.body_type = MALE
		H.update_body()
		H.update_mutations_overlay()
		if(!H.reagents.has_reagent(/datum/reagent/breast_enlarger))	//Spam prevention
			to_chat(H, span_warning("You feel a newfound sensitivity on your groin that you never felt before."))
		return
	H.update_body()

/datum/reagent/testicle_enlarger
	name = "Incubus Expedite"
	description = "A volatile collodial mixture derived from zinc that encourages a larger coin pouch via a potent mix."
	color = "#c7f7ef"	//light blue
	taste_description = "shellfish"
	overdose_threshold = 17 //ODing makes you hungry as hell
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/testicle_enlarger/on_mob_life(mob/living/carbon/human/H)
	..()
	if(!ishuman(H))
		return
	if(!(H.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return
	
	var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)

	if(!T)
		T = new(H)
		T.build_from_dna(H.dna, "testicles", TRUE)
		T.Insert(H)
		T.update_genital_icon_state()

	T.set_size(T.genital_size + (0.008 * purity))	//Takes about 30 units to increase one size (in one "gulp"), it should stay like this
	H.update_body()

/datum/reagent/testicle_enlarger/overdose_process(mob/living/carbon/human/H, delta_time, times_fired)
	..()
	if(!ishuman(H))
		return
	if(!(H.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return
	
	var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)
	if(H.nutrition <= NUTRITION_LEVEL_STARVING)
		H.adjustToxLoss((times_fired / T.genital_size) * REM * delta_time, 0)
	H.adjust_nutrition((T.genital_size*-0.5) * REM * delta_time)
	T.genital_size += 0.032	//If you really wanna get huge

/datum/reagent/production_enhancer
	name = "Production Enhancer"
	description = "A crude, unnatural chemical that increases the productivity capabilities of most creatures."
	color = "#787a4f"	//tar-like, dark-brown
	taste_description = "flower petals"
	metabolization_rate = REAGENTS_METABOLISM * 0.25
	var/datum/component/arousal/arousal
	var/datum/species/species

/datum/reagent/production_enhancer/on_mob_add(mob/living/L, amount)
	..()
	//sleep(10)	//Oops! All errors! Add this if possible
	L.emote("gag")

	if(!(L.client?.prefs.r_preferences & R_PREF_LEWDCHEM))
		return
	
	arousal = L.GetComponent(/datum/component/arousal)
	arousal?.productivity_multiplier *= 2
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		species = H.dna.species

/datum/reagent/production_enhancer/on_mob_life(mob/living/carbon/C, delta_time, times_fired)
	..()
	if(!arousal)
		C.reagents.add_reagent(/datum/reagent/exotic_damage/type_1, metabolization_rate)
		return
	if(!species || QDELETED(species) || QDELING(species))
		C.adjustToxLoss(1)
		return

	switch(species.id)
		if(SPECIES_MOTH, SPECIES_FLY, SPECIES_INSECT)
			C.reagents.add_reagent(/datum/reagent/exotic_damage/type_2, metabolization_rate)
		if(SPECIES_ETHEREAL, SPECIES_PLASMAMAN)
			C.reagents.add_reagent(/datum/reagent/exotic_damage/type_3, metabolization_rate)
		if(SPECIES_JELLYPERSON, SPECIES_SLIMEPERSON, SPECIES_LUMINESCENT, SPECIES_STARGAZER)
			if(current_cycle == 5)
				to_chat(C, span_warning("You feel cold."))
			C.reagents.add_reagent(/datum/reagent/exotic_damage/type_4, metabolization_rate)
		if(SPECIES_SKELETON)
			if(current_cycle == 2)
				C.emote("scream")	//meme because why would a skeleton drink this
				C.reagents.del_reagent(type)
		else
			C.reagents.add_reagent(/datum/reagent/exotic_damage/type_5, metabolization_rate)

///////////////////////
///BOTTLES AND PILLS///
///////////////////////

//bottles

/obj/item/reagent_containers/glass/bottle/crocin
	name = "crocin bottle"
	desc = "A bottle of mild aphrodisiac. Increases libido."
	list_reagents = list(/datum/reagent/drug/crocin = 30)

/obj/item/reagent_containers/glass/bottle/hexacrocin
	name = "hexacrocin bottle"
	desc = "A bottle of strong aphrodisiac. Increases libido. Potentially  dangerous."
	list_reagents = list(/datum/reagent/drug/hexacrocin = 30)

/obj/item/reagent_containers/glass/bottle/dopamine //this one is hard to obtain.
	name = "dopamine bottle"
	desc = "Pleasure and happines, in its purest form."
	list_reagents = list(/datum/reagent/drug/dopamine = 30)

/obj/item/reagent_containers/glass/bottle/camphor
	name = "camphor bottle"
	desc = "A bottle of mild anaphrodisiac. Reduces libido."
	list_reagents = list(/datum/reagent/drug/camphor = 30)

/obj/item/reagent_containers/glass/bottle/pentacamphor
	name = "pentacamphor bottle"
	desc = "A bottle of strong anaphrodisiac. Reduces libido."
	list_reagents = list(/datum/reagent/drug/pentacamphor = 30)

/obj/item/reagent_containers/glass/bottle/breast_enlarger
	name = "succubus milk bottle"
	desc = "A bottle of strong breast enlargement reagent."
	list_reagents = list(/datum/reagent/breast_enlarger = 30)

/obj/item/reagent_containers/glass/bottle/penis_enlarger
	name = "incubus draft bottle"
	desc = "A bottle of strong penis enlargement reagent."
	list_reagents = list(/datum/reagent/penis_enlarger = 30)

//pills

/obj/item/reagent_containers/pill/crocin
	name = "crocin pill (10u)"
	desc = "I've fallen, and I can't get it up!"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "crocin"
	list_reagents = list(/datum/reagent/drug/crocin = 10)

/obj/item/reagent_containers/pill/hexacrocin
	name = "hexacrocin pill (10u)"
	desc = "Pill in creepy heart form."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "hexacrocin"
	list_reagents = list(/datum/reagent/drug/hexacrocin = 10)

/obj/item/reagent_containers/pill/dopamine
	name = "dopamine pill (5u)"
	desc = "Feelings of orgasm, contained in a pill... Weird."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "dopamine"
	list_reagents = list(/datum/reagent/drug/dopamine = 5)

/obj/item/reagent_containers/pill/camphor
	name = "camphor pill (10u)"
	desc = "For the early bird."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "camphor"
	list_reagents = list(/datum/reagent/drug/camphor = 10)

/obj/item/reagent_containers/pill/pentacamphor
	name = "pentacamphor pill (10u)"
	desc = "The chemical equivalent of horny jail."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "pentacamphor"
	list_reagents = list(/datum/reagent/drug/pentacamphor = 10)

//keg

/obj/structure/reagent_dispensers/keg/aphro
	name = "keg of aphrodisiac"
	desc = "A keg of aphrodisiac."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/kegs.dmi'
	icon_state = "crocin"
	reagent_id = /datum/reagent/drug/crocin
	tank_volume = 150

/obj/structure/reagent_dispensers/keg/aphro/strong
	name = "keg of strong aphrodisiac"
	desc = "A keg of strong and addictive aphrodisiac."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/kegs.dmi'
	icon_state = "hexacrocin"
	reagent_id = /datum/reagent/drug/hexacrocin
	tank_volume = 150
