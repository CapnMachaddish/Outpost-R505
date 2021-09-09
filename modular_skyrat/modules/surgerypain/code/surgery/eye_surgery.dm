/datum/surgery_step/fix_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, span_userdanger("You feel a stabbing pain in your eyes!"))

/datum/surgery_step/fix_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, span_userdanger("Your vision blurs, but it seems like you can see a little better now!"))

/datum/surgery_step/fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	if(target.getorgan(/obj/item/organ/brain))
		display_pain(target, span_userdanger("You feel a visceral stabbing pain right through your head, into your brain!"))
	else
		display_pain(target, span_userdanger("You feel a visceral stabbing pain right through your head!")) // dunno who can feel pain w/o a brain but may as well be consistent.
