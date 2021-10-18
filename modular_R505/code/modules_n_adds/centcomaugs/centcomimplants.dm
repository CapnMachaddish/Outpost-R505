/obj/item/organ/cyberimp/arm/combat/centcom
	name = "combat cybernetics implant"
	desc = "A powerful cybernetic implant that contains combat modules built into the user's arm."
	contents = newlist(/obj/item/reagent_containers/hypospray/combat/nanites, /obj/item/restraints/handcuffs/energy/projector, /obj/item/melee/transforming/energy/blade/hardlight, /obj/item/gun/medbeam, /obj/item/assembly/flash/armimplant)
	organ_flags = EMP_PROTECT_SELF

/obj/item/organ/cyberimp/arm/combat/centcom/Initialize()
	. = ..()
	if(locate(/obj/item/assembly/flash/armimplant) in items_list)
		var/obj/item/assembly/flash/armimplant/F = locate(/obj/item/assembly/flash/armimplant) in items_list
		F.I = src

/obj/item/organ/cyberimp/arm/toolset/empproof
	name = "integrated toolset implant"
	desc = "A stripped-down version of the engineering cyborg toolset, designed to be installed on subject's arm. Contain advanced versions of every tool."
	contents = newlist(/obj/item/screwdriver/cyborg, /obj/item/wrench/cyborg, /obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/cyborg)
	organ_flags = EMP_PROTECT_SELF

/obj/item/organ/cyberimp/arm/toolset/empproof/l
	zone = BODY_ZONE_L_ARM

//Dust implant, for CC officers. Prevents gear theft if they die.

/obj/item/implant/dust
	name = "duster implant"
	desc = "An alarm which monitors host vital signs, transmitting a radio message and dusting the corpse on death."
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	actions_types = list(/datum/action/item_action/dusting_implant)

/obj/item/implant/dust/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Ultraviolet Corp XX-13 Security Implant<BR>
				<b>Life:</b> Activates upon death.<BR>
				<b>Important Notes:</b> Vaporizes organic matter<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Contains a compact, electrically activated heat source that turns its host to ash upon activation, or their death. <BR>
				<b>Special Features:</b> Vaporizes<BR>
				"}
	return dat

/obj/item/implant/dust/trigger(emote, mob/source)
	if(emote == "deathgasp")
		activate("death")

/obj/item/implant/dust/activate(cause)
	if(!cause || !imp_in || cause == "emp")
		return 0
	if(cause == "action_button" && alert(imp_in, "Are you sure you want to activate your dusting implant? This will turn you to ash!", "Dusting Confirmation", "Yes", "No") != "Yes")
		return 0
	to_chat(imp_in, "<span class='notice'>Your dusting implant activates!</span>")
	imp_in.visible_message("<span class = 'warning'>[imp_in] burns up in a flash!</span>")
	imp_in.dust(FALSE, FALSE, TRUE)

/obj/item/implant/dust/emp_act(severity)
	return

/obj/item/implanter/dust
	name = "implanter (Dust-on-death)"

/obj/item/implanter/dust/New()
	imp = new /obj/item/implant/dust(src)
	..()

/obj/item/gun/energy/e_gun/advtaser/mounted/infcharge
	cell_type = "/obj/item/stock_parts/cell/infinite"
