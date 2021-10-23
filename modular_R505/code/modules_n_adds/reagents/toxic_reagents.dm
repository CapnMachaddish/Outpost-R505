//Placeholder damage reagents that people can use inside of other code
/datum/reagent/exotic_damage
	name = "Unnatural Enzymes"
	metabolization_rate = REAGENTS_METABOLISM * 2

/datum/reagent/exotic_damage/type_1/on_mob_life(mob/living/carbon/C, delta_time, times_fired)
	..()
	C.adjustStaminaLoss(5 * REM * delta_time)
	C.adjustOxyLoss(3 * REM * delta_time)

/datum/reagent/exotic_damage/type_2/on_mob_life(mob/living/carbon/C, delta_time, times_fired)
	..()
	if(current_cycle > 20 && DT_PROB(20, delta_time))
		C.emote("cough")
		if(C.toxloss < 25)
			C.adjustToxLoss(1 * REM * delta_time)

/datum/reagent/exotic_damage/type_3/on_mob_life(mob/living/carbon/C, delta_time, times_fired)
	..()
	if(current_cycle < 35 && DT_PROB(70, delta_time))
		if(C.fireloss < 45)
			C.adjustFireLoss(0.25 * REM * delta_time)
			to_chat(C, span_warning("You feel steamy."))

/datum/reagent/exotic_damage/type_4/on_mob_life(mob/living/carbon/C, delta_time, times_fired)
	..()
	if(C.cloneloss < 50 && C.health > C.maxHealth/2 && current_cycle > 10)
		C.adjustCloneLoss(1 * REM * delta_time)
		if(prob(20))
			C.apply_effect(5 * REM * delta_time, EFFECT_SLUR)

/datum/reagent/exotic_damage/type_5/on_mob_life(mob/living/carbon/C, delta_time, times_fired)
	..()
	if(!(current_cycle % 8) && current_cycle > 10)	//once every 5 ticks
		var/obj/item/organ/stomach/stomach = C.getorganslot(ORGAN_SLOT_STOMACH)
		if(stomach)
			stomach.applyOrganDamage(3)
			if(DT_PROB(50, delta_time))
				to_chat(C, span_warning("You feel sick."))
		else if(DT_PROB(50, delta_time))
			C.adjustStaminaLoss(25)
			C.Knockdown(1)
			C.Stun(3)
			C.apply_effect(10, EFFECT_JITTER)
			to_chat(C, span_warning("A wrily pain kicks inside you!"))
