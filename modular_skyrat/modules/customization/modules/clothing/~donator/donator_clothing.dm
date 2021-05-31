/**************SKYRAT REWARDS**************/
//SUITS
/obj/item/clothing/suit/hooded/wintercoat/polychromic
	name = "polychromic winter coat"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	icon_state = "coatpoly"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/polychromic

/obj/item/clothing/suit/hooded/wintercoat/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("666", "CBA", "00F"))

//We need this to color the hood that comes up
/obj/item/clothing/suit/hooded/wintercoat/polychromic/ToggleHood()
	. = ..()
	if(hood)
		hood.color = color
		hood.update_slot_icon()

/obj/item/clothing/head/hooded/winterhood/polychromic
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/head.dmi'
	icon_state = "winterhood_poly"

//SCARVES
/obj/item/clothing/neck/cloak/polychromic
	name = "polychromic cloak"
	desc = "For when you want to show off your horrible colour coordination skills."
	icon_state = "polycloak"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/neck.dmi'
	var/list/poly_colors = list("FFF", "FFF", "888")

/obj/item/clothing/neck/cloak/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/neck/cloak/polychromic/veil
	name = "polychromic veil"
	icon_state = "polyveil"

/obj/item/clothing/neck/cloak/polychromic/boat
	name = "polychromic boatcloak"
	icon_state = "polyboat"

/obj/item/clothing/neck/cloak/polychromic/shroud
	name = "polychromic shroud"
	icon_state = "polyshroud"

/obj/item/clothing/neck/cloak/rscloak
	name = "black cape"
	desc = "A black cape with a purple finish at the end."
	icon_state = "black"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/rscloak_cross
	name = "black cape"
	desc = "A black cape with a grey cross pattern on the back."
	icon_state = "black_cross"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/rscloak_champion
	name = "champion cape"
	desc = "A regal blue and gold cape!"
	icon_state = "champion"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/polychromic/rscloak
	name = "polychromic cape"
	desc = "A cape with a polychromic finish. It can be recoloured to the user's personal preference."
	icon_state = "polycape"

/obj/item/clothing/neck/cloak/polychromic/rscloak_cross
	name = "polychromic cape"
	desc = "A cape with a polychromic finish. It can be recoloured to the user's personal preference. This one has across pattern."
	icon_state = "polycape_cross"

//UNIFORMS
/obj/item/clothing/under/dress/skirt/polychromic
	name = "polychromic skirt"
	desc = "A fancy skirt made with polychromic threads."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polyskirt"
	mutant_variants = NONE
	var/list/poly_colors = list("FFF", "F88", "888")

/obj/item/clothing/under/dress/skirt/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/under/dress/skirt/polychromic/pleated
	name = "polychromic pleated skirt"
	desc = "A magnificent pleated skirt complements the woolen polychromatic sweater."
	icon_state = "polypleat"
	body_parts_covered = CHEST|GROIN|ARMS
	poly_colors = list("8CF", "888", "F33")

/obj/item/clothing/under/misc/poly_shirt
	name = "polychromic button-up shirt"
	desc = "A fancy button-up shirt made with polychromic threads."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polysuit"
	mutant_variants = NONE

/obj/item/clothing/under/misc/poly_shirt/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("FFF", "333", "333"))

/obj/item/clothing/under/misc/polyshorts
	name = "polychromic shorts"
	desc = "For ease of movement and style."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polyshorts"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	mutant_variants = NONE

/obj/item/clothing/under/misc/polyshorts/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("333", "888", "888"))

/obj/item/clothing/under/misc/polyjumpsuit
	name = "polychromic tri-tone jumpsuit"
	desc = "A fancy jumpsuit made with polychromic threads."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polyjump"
	can_adjust = FALSE
	mutant_variants = NONE

/obj/item/clothing/under/misc/polyjumpsuit/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("FFF", "888", "333"))

/obj/item/clothing/under/misc/poly_bottomless
	name = "polychromic bottomless shirt"
	desc = "Great for showing off your underwear in dubious style."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polybottomless"
	body_parts_covered = CHEST|ARMS	//Because there's no bottom included
	can_adjust = FALSE
	mutant_variants = NONE

/obj/item/clothing/under/misc/poly_bottomless/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("888", "F33", "FFF"))

/obj/item/clothing/under/misc/polysweater
	name = "polychromic sweater"
	desc = "Why trade style for comfort? Now you can go commando down south and still be cozy up north, AND do it in whatever color you choose."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "poly_turtle"
	worn_icon_state = "poly_turtle"
	body_parts_covered = CHEST|GROIN|ARMS //Commando sweater is long but still doesnt have pants
	can_adjust = FALSE
	mutant_variants = NONE

/obj/item/clothing/under/misc/polysweater/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("FFF"))

/obj/item/clothing/under/misc/poly_tanktop
	name = "polychromic tank top"
	desc = "For those lazy summer days."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polyshimatank"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	mutant_variants = NONE
	var/list/poly_colors = list("888", "FFF", "8CF")

/obj/item/clothing/under/misc/poly_tanktop/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/under/misc/poly_tanktop/female
	name = "polychromic feminine tank top"
	desc = "Great for showing off your chest in style. Not recommended for males."
	icon_state = "polyfemtankpantsu"
	poly_colors = list("888", "F33", "FFF")

/obj/item/clothing/under/shorts/polychromic
	name = "polychromic athletic shorts"
	desc = "95% Polychrome, 5% Spandex!"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "polyshortpants"
	mutant_variants = NONE
	var/list/poly_colors = list("FFF", "F88", "FFF")

/obj/item/clothing/under/shorts/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/under/shorts/polychromic/pantsu
	name = "polychromic panties"
	desc = "Topless striped panties. Now with 120% more polychrome!"
	icon_state = "polypantsu"
	body_parts_covered = GROIN
	mutant_variants = NONE
	poly_colors = list("FFF", "8CF", "FFF")

/**************CKEY EXCLUSIVES*************/

// Donation reward for Grunnyyy
/obj/item/clothing/suit/jacket/ryddid
	name = "Ryddid"
	desc = "An old worn out piece of clothing belonging to a certain small demon."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	icon_state = "darkcoat"
	inhand_icon_state = "darkcoat"
	mutant_variants = NONE

// Donation reward for Grunnyyy
/obj/item/clothing/neck/cloak/grunnyyy
	name = "black and red cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	mutant_variants = NONE

//Donation reward for Thedragmeme
// might make it have some flavour functionality in future, a'la rewritable piece of paper - JOKES ON YOU I'M MAKING IT DRAW
/obj/item/canvas/drawingtablet
	name = "drawing tablet"
	desc = "A portable tablet that allows you to draw. Legends say these can earn the owner a fortune in some sectors of space."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "drawingtablet"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	actions_types = list(/datum/action/item_action/dtselectcolor,/datum/action/item_action/dtcolormenu,/datum/action/item_action/dtcleargrid)
	pixel_x = 0
	pixel_y = 0
	width = 28
	height = 26
	nooverlayupdates = TRUE
	var/currentcolor = "#ffffff"
	var/list/colors = list("Eraser" = "#ffffff")

/obj/item/canvas/drawingtablet/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/dtselectcolor))
		currentcolor = input(user, "", "Choose Color", currentcolor) as color|null
	else if(istype(action, /datum/action/item_action/dtcolormenu))
		var/list/selects = colors.Copy()
		selects["Save"] = "Save"
		selects["Delete"] = "Delete"
		var/selection = input(user, "", "Color Menu", currentcolor) as null|anything in selects
		if(QDELETED(src) || !user.canUseTopic(src, BE_CLOSE))
			return
		switch(selection)
			if("Save")
				var/name = input(user, "", "Name the color!", "Pastel Purple") as text|null
				if(name)
					colors[name] = currentcolor
			if("Delete")
				var/delet = input(user, "", "Color Menu", currentcolor) as null|anything in colors
				if(delet)
					colors.Remove(delet)
			if(null)
				return
			else
				currentcolor = colors[selection]
	else if(istype(action, /datum/action/item_action/dtcleargrid))
		var/yesnomaybe = alert("Are you sure you wanna clear the canvas?", ,"Yes","No","Maybe")
		if(QDELETED(src) || !user.canUseTopic(src, BE_CLOSE))
			return
		switch(yesnomaybe)
			if("Yes")
				reset_grid()
				SStgui.update_uis(src)
			if("No")
				return
			if("Maybe")
				playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
				audible_message("<span class='warning'>The [src] buzzes!</span>")
				return

/obj/item/canvas/drawingtablet/get_paint_tool_color()
	return currentcolor

/obj/item/canvas/drawingtablet/finalize()
	return // no finalizing this piece

/obj/structure/sign/painting/frame_canvas(mob/user,obj/item/canvas/new_canvas)
	if(istype(new_canvas, /obj/item/canvas/drawingtablet)) // NO FINALIZING THIS BITCH.
		return
	else
		..()

/obj/item/canvas/var/nooverlayupdates = FALSE

/obj/item/canvas/update_overlays()
	if(nooverlayupdates)
		return
	. = ..()

/datum/action/item_action/dtselectcolor
	name = "Change Color"
	desc = "Change your color."
	icon_icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcolormenu
	name = "Color Menu"
	desc = "Select, save, or delete a color in your tablet's color menu!"
	icon_icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcleargrid
	name = "Clear Canvas"
	desc = "Clear the canvas of your drawing tablet."
	icon_icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

//Donation reward for Thedragmeme
/obj/item/clothing/suit/furcoat
	name = "leather coat"
	desc = "A thick, comfy looking leather coat. It's got some fluffy fur at the collar and sleeves."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	icon_state = "furcoat"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	mutant_variants = NONE

//Donation reward for Thedragmeme
/obj/item/clothing/under/syndicate/tacticool/black
	name = "black turtleneck"
	desc = "Tacticool as fug. Comfy too."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	icon_state = "black_turtleneck"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	mutant_variants = NONE
	can_adjust = FALSE //There wasnt an adjustable sprite anyways
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, WOUND = 5)	//same armor as a greyshirt - DONOR ITEMS ARE PURELY COSMETIC
	has_sensor = HAS_SENSORS	//Actually has sensors, to balance the new lack of armor

//Donation reward for Thedragmeme
/obj/item/clothing/shoes/jackboots/heel
	name = "high-heeled jackboots"
	desc = "Almost like regular jackboots... why are they on a high heel?"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/feet.dmi'
	icon_state = "heel-jackboots"
	mutant_variants = NONE

//Donation reward for Bloodrite
/obj/item/clothing/shoes/clown_shoes/britches
	desc = "The prankster's standard-issue clowning shoes. They look extraordinarily cute. Ctrl-click to toggle waddle dampeners."
	name = "Britches' shoes"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/feet.dmi'
	icon_state = "clown_shoes_cute"
	mutant_variants = NONE

//Donation reward for Bloodrite
/obj/item/clothing/under/rank/civilian/clown/britches
	name = "Britches' dress"
	desc = "<i>'HONK!' (but cute)</i>"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	icon_state = "clowndress"
	mutant_variants = NONE

//Donation reward for Bloodrite
/obj/item/clothing/mask/gas/britches
	name = "Britches' mask"
	desc = "A true prankster's facial attire. Cute."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/mask.dmi'
	icon_state = "cute_mask"
	inhand_icon_state = "clown_hat"
	dye_color = "clown"
	mutant_variants = NONE
	clothing_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

//Donation reward for Random516
/obj/item/clothing/head/drake_skull
	name = "skull of an ashdrake"
	desc = "How did they get this?"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/hats.dmi'
	icon_state = "drake_skull"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/large-worn-icons/32x64/head.dmi'
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	mutant_variants = NONE

//Donation reward for Random516
/obj/item/clothing/gloves/fingerless/blutigen_wraps
	name = "Blutigen Wraps"
	desc = "The one who wears these had everything and yet lost it all..."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/gloves.dmi'
	icon_state = "blutigen_wraps"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/hands.dmi'

//Donation reward for Random516
/obj/item/clothing/suit/blutigen_kimono
	name = "Blutigen Kimono"
	desc = "For the eyes bestowed upon this shall seek adventure..."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	icon_state = "blutigen_kimono"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	mutant_variants = NONE

//Donation reward for Random516
/obj/item/clothing/under/custom/blutigen_undergarment
	name = "Dragon Undergarments"
	desc = "The Dragon wears the sexy?"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	icon_state = "blutigen_undergarment"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	mutant_variants = NONE
	fitted = FEMALE_UNIFORM_TOP

//Donation reward for NetraKyram
/obj/item/clothing/under/custom/kilano
	name = "black and gold dress uniform"
	desc = "A light black and gold dress made out some sort of silky material."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	icon_state = "kilanosuit"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	mutant_variants = NONE
	fitted = FEMALE_UNIFORM_TOP

//Donation reward for NetraKyram
/obj/item/clothing/gloves/kilano
	name = "black and gold gloves"
	desc = "Some black and gold gloves, It seems like they're made to match something."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/gloves.dmi'
	icon_state = "kilanogloves"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/hands.dmi'

//Donation reward for NetraKyram
/obj/item/clothing/shoes/winterboots/kilano
	name = "black and gold boots"
	desc = "Some heavy furred boots, why would you need fur on a space station? Seems redundant."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/shoes.dmi'
	icon_state = "kilanoboots"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/feet.dmi'
	mutant_variants = NONE


/****************LEGACY REWARDS***************/
//Donation reward for inferno707
/obj/item/clothing/neck/cloak/inferno
	name = "Kiara's Cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

//Donation reward for inferno707
/obj/item/clothing/neck/human_petcollar/inferno
	name = "Kiara's Collar"
	desc = "A soft black collar that seems to stretch to fit whoever wears it."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "infcollar"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	tagname = null

//Donation reward for inferno707
/obj/item/clothing/accessory/medal/steele
	name = "Insignia Of Steele"
	desc = "An intricate pendant given to those who help a key member of the Steele Corporation."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "steele"
	medaltype = "medal-silver"

//Donation reward for inferno707
/obj/item/toy/darksabre
	name = "Kiara's Sabre"
	desc = "This blade looks as dangerous as its owner."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	lefthand_file = 'modular_skyrat/modules/customization/icons/~donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/modules/customization/icons/~donator/mob/inhands/donator_right.dmi'

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi', "darksheath-darksabre")

//Donation reward for inferno707
/obj/item/storage/belt/sabre/darksabre
	name = "Ornate Sheathe"
	desc = "An ornate and rather sinister looking sabre sheathe."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	icon_state = "darksheath"

/obj/item/storage/belt/sabre/darksabre/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(
		/obj/item/toy/darksabre
		))

/obj/item/storage/belt/sabre/darksabre/PopulateContents()
	new /obj/item/toy/darksabre(src)
	update_icon()

//Donation reward for inferno707
/obj/item/clothing/suit/armor/vest/darkcarapace
	name = "Dark Armor"
	desc = "A dark, non-functional piece of armor sporting a red and black finish."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	mutant_variants = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

//Donation reward for inferno707
/obj/item/clothing/mask/hheart
	name = "Hollow Heart"
	desc = "It's an odd ceramic mask. Set in the internal side are several suspicious electronics branded by Steele Tech."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/masks.dmi'
	icon_state = "hheart"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)
	mutant_variants = NONE

/obj/item/clothing/mask/hheart/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "Toggle Mode"
	desc = "Toggle the color of the hollow heart."

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_inv_wear_mask()
		ooser.update_action_buttons_icon()
		to_chat(ooser, "<span class='notice'>You toggle the [src] to [possible_colors[c_color_index]].</span>")

//Donation reward for asky / Zulie
/obj/item/clothing/suit/hooded/cloak/zuliecloak
	name = "Project: Zul-E"
	desc = "A standard version of a prototype cloak given out by Nanotrasen higher ups. It's surprisingly thick and heavy for a cloak despite having most of it's tech stripped. It also comes with a bluespace trinket which calls it's accompanying hat onto the user. A worn inscription on the inside of the cloak reads 'Fleuret' ...the rest is faded away."
	icon_state = "zuliecloak"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/zuliecloak
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	mutant_variants = NONE

/obj/item/clothing/head/hooded/cloakhood/zuliecloak
	name = "NT Special Issue"
	desc = "This hat is unquestionably the best one, bluespaced to and from CentComm. It smells of Fish and Tea with a hint of antagonism"
	icon_state = "zuliecap"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/neck.dmi'
	flags_inv = null
	mutant_variants = NONE

//Donation reward for Kathrin Bailey / Floof Ball
/obj/item/clothing/under/custom/lannese
	name = "Lannese Dress"
	desc = "An alien cultural garment for women, coming from a distant planet named Cantalan."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	icon_state = "lannese"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	mutant_variants = NONE
	inhand_icon_state = "lannese"
	can_adjust = TRUE
	fitted = FEMALE_UNIFORM_TOP
	body_parts_covered = CHEST|GROIN|LEGS|FEET

/obj/item/clothing/under/custom/lannese/vambrace
	desc = "An alien cultural garment for women, coming from a distant planet named Cantalan. Shiny vambraces included!"
	icon_state = "lannese_vambrace"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET

//Donation reward for Hacker T.Dog
/obj/item/clothing/suit/scraparmour
	name = "Scrap Armour"
	desc = "A shoddily crafted piece of armour. It provides no benefit apart from being clunky."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	icon_state = "scraparmor"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	worn_icon_state = "scraparmor"
	body_parts_covered = CHEST

//Donation reward for Enzoman
/obj/item/clothing/mask/luchador/enzo
	name = "mask of El Red Templar"
	desc = "A mask belonging to El Red Templar, a warrior of lucha. Taking it from him is not recommended."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/mask.dmi'
	icon_state = "luchador"
	worn_icon_state = "luchador"
	clothing_flags = MASKINTERNALS
	mutant_variants = NONE

//Donation Reward for Grand Vegeta
/obj/item/clothing/under/mikubikini
	name = "starlight singer bikini"
	desc = " "
	icon_state = "mikubikini"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	worn_icon_state = "mikubikini"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_TOP

//Donation Reward for Grand Vegeta
/obj/item/clothing/suit/mikujacket
	name = "starlight singer jacket"
	desc = " "
	icon_state = "mikujacket"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	worn_icon_state = "mikujacket"

//Donation Reward for Grand Vegeta
/obj/item/clothing/head/mikuhair
	name = "starlight singer hair"
	desc = " "
	icon_state = "mikuhair"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/head.dmi'
	worn_icon_state = "mikuhair"
	flags_inv = HIDEHAIR

//Donation Reward for Grand Vegeta
/obj/item/clothing/gloves/mikugloves
	name = "starlight singer gloves"
	desc = " "
	icon_state = "mikugloves"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/hands.dmi'
	worn_icon_state = "mikugloves"

//Donation Reward for Grand Vegeta
/obj/item/clothing/shoes/sneakers/mikuleggings
	name = "starlight singer leggings"
	desc = " "
	icon_state = "mikuleggings"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/feet.dmi'
	worn_icon_state = "mikuleggings"
