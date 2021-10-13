/obj/item/organ/tongue/bloodsucker
	name = "bloodsucker tongue"
	actions_types = list(/datum/action/item_action/organ_action/bloodsucker)
	color = "#1C1C1C"
	var/drain_cooldown = 0

/obj/item/organ/tongue/lizard/bloodsucker
    name = "forked bloodsucker tongue"
    actions_types = list(/datum/action/item_action/organ_action/bloodsucker)
    color = "#1C1C1C"
    var/drain_cooldown = 0

#define VAMP_DRAIN_AMOUNT 25

/datum/action/item_action/organ_action/bloodsucker
	name = "Suck Blood"
	desc = "Leech out blood from any person you are passively grabbing."

/datum/action/item_action/organ_action/bloodsucker/Trigger()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/human/sucker = owner
		var/obj/item/organ/tongue/bloodsucker/V = target
		if(V.drain_cooldown >= world.time)
			to_chat(sucker, span_warning("You just drained blood, wait a few seconds!"))
			return
		if(sucker.pulling && iscarbon(sucker.pulling))
			var/mob/living/carbon/human/victim = sucker.pulling
			if(sucker.nutrition >= NUTRITION_LEVEL_WELL_FED)
				to_chat(sucker, span_warning("You couldn't drink another ounce!"))
				return
			if(!victim.blood_volume || (victim.dna && ((NOBLOOD in victim.dna.species.species_traits) || victim.dna.species.exotic_blood)))
				to_chat(sucker, span_warning("[victim] doesn't have blood!"))
				return
			V.drain_cooldown = world.time + 30
			if(!do_after(sucker, 30, target = victim))
				return
			var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - sucker.blood_volume //How much capacity we have left to absorb blood
			var/drained_blood = min(victim.blood_volume, VAMP_DRAIN_AMOUNT, blood_volume_difference)
			to_chat(victim, span_danger("[sucker] is draining your blood!"))
			to_chat(sucker, span_notice("You drain some blood!"))
			playsound(sucker, 'sound/items/drink.ogg', 30, TRUE, -2)
			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			sucker.blood_volume = clamp(sucker.blood_volume + drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			sucker.reagents.add_reagent(/datum/reagent/blood, 10)
			if(!victim.blood_volume)
				to_chat(sucker, span_notice("You finish off [victim]'s blood supply."))

#undef VAMP_DRAIN_AMOUNT