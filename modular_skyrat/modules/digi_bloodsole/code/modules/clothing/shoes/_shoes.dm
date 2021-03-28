/obj/item/clothing/shoes/worn_overlays(isinhands = FALSE,icon_file,mutant_styles=NONE)
	. = list()
	if(isinhands)
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedshoe")
	if(HAS_BLOOD_DNA(src))
		if (mutant_styles & STYLE_DIGITIGRADE)
			if(clothing_flags & LARGE_WORN_ICON)
				. += mutable_appearance('modular_skyrat/modules/digi_bloodsole/icons/effects/64x64.dmi', "shoeblood_large")
			else
				. += mutable_appearance('modular_skyrat/modules/digi_bloodsole/icons/effects/blood.dmi', "shoeblood")
		else
			if(clothing_flags & LARGE_WORN_ICON)
				. += mutable_appearance('icons/effects/64x64.dmi', "shoeblood_large")
			else
				. += mutable_appearance('icons/effects/blood.dmi', "shoeblood")
