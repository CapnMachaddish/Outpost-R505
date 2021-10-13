/datum/augment_item/organ
	category = AUGMENT_CATEGORY_ORGANS
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC|MOB_UNDEAD //R505 Edit

/datum/augment_item/organ/apply(mob/living/carbon/human/H, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return
	var/obj/item/organ/new_organ = new path()
	new_organ.Insert(H,FALSE,FALSE)

//HEARTS
/datum/augment_item/organ/heart
	slot = AUGMENT_SLOT_HEART

/datum/augment_item/organ/heart/cybernetic
	name = "Cybernetic heart"
	path = /obj/item/organ/heart/cybernetic

//LUNGS
/datum/augment_item/organ/lungs
	slot = AUGMENT_SLOT_LUNGS

/datum/augment_item/organ/lungs/hot
	name = "Lungs Adapted to Heat"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/hot
	cost = 1

/datum/augment_item/organ/lungs/cold
	name = "Cold-Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/cold
	cost = 1
/datum/augment_item/organ/lungs/toxin
	name = "Lungs Adapted to Toxins"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/toxin
	cost = 1
/datum/augment_item/organ/lungs/oxy
	name = "Low-Pressure Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/lungs/oxy
	cost = 1
/datum/augment_item/organ/lungs/cybernetic
	name = "Cybernetic lungs"
	path = /obj/item/organ/lungs/cybernetic

//LIVERS
/datum/augment_item/organ/liver
	slot = AUGMENT_SLOT_LIVER

/datum/augment_item/organ/liver/cybernetic
	name = "Cybernetic liver"
	path = /obj/item/organ/liver/cybernetic

//STOMACHES
/datum/augment_item/organ/stomach
	slot = AUGMENT_SLOT_STOMACH

/datum/augment_item/organ/stomach/cybernetic
	name = "Cybernetic stomach"
	path = /obj/item/organ/stomach/cybernetic

//EYES
/datum/augment_item/organ/eyes
	slot = AUGMENT_SLOT_EYES

/datum/augment_item/organ/eyes/cybernetic
	name = "Cybernetic eyes"
	path = /obj/item/organ/eyes/robotic

/datum/augment_item/organ/eyes/highlumi
	name = "High-luminosity eyes"
	path = /obj/item/organ/eyes/robotic/glow
	//allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC //R505 Edit
	cost = 1

//TONGUES
/datum/augment_item/organ/tongue
	slot = AUGMENT_SLOT_TONGUE

/datum/augment_item/organ/tongue/normal
	name = "Organic tongue"
	path = /obj/item/organ/tongue

/datum/augment_item/organ/tongue/robo
	name = "Robotic voicebox"
	path = /obj/item/organ/tongue/robot

/datum/augment_item/organ/tongue/forked
	name = "Forked tongue"
	path = /obj/item/organ/tongue/lizard

/datum/augment_item/organ/tongue/bloodsucker //R505 Add Start
	name = "Bloodsucker tongue"
	path = /obj/item/organ/tongue/bloodsucker

/datum/augment_item/organ/tongue/lizard/bloodsucker
	name = "Forked Bloodsucker tongue"
	path = /obj/item/organ/tongue/lizard/bloodsucker

/datum/augment_item/organ/tongue/bone
	name = "Bone \"tongue\""
	path = /obj/item/organ/tongue/bone

/datum/augment_item/organ/tongue/bone/sans
	name = "Funny bone \"tongue\""
	path = /obj/item/organ/tongue/bone/sans

/datum/augment_item/organ/tongue/bone/papyrus
	name = "Cool bone \"tongue\""
	path = /obj/item/organ/tongue/bone/papyrus

/datum/augment_item/organ/tongue/bone/plasmaman
	name = "Plasma bone \"tongue\""
	path = /obj/item/organ/tongue/bone/plasmaman //R505 Add End
