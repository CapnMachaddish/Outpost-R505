/datum/surgery_step/fix_brain/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, span_userdanger("Your head pounds with unimaginable pain!"))

/datum/surgery_step/fix_brain/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, span_userdanger("The pain in your head receeds, thinking becomes a bit easier!"))

/datum/surgery_step/fix_brain/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_pain(target, span_userdanger("Your head throbs with horrible pain and thinking becomes a little bit harder!"))
