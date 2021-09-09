/datum/surgery_step/lobotomize/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, span_userdanger("Your head pounds with unimaginable pain!"))

/datum/surgery_step/lobotomize/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, span_userdanger("The pain in your head only seems to get worse!"))

/datum/surgery_step/lobotomize/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_pain(target, span_userdanger("Your head goes totally numb for a moment, the pain is overwhelming!"))
