//Basically copying over normal processing code, except editing it so we process all the time, constantly.
//This is for adding the fake-ish reagents over time
/obj/item/organ/genital/process(delta_time, times_fired)
	if(!owner)
		return ..()
	if(max_fluid_amount > 0)
		var/to_add = LERP(fluid_amount, max_fluid_amount, 0.05)+0.25	//Lerp is my new friend to logarithmic growth
		if(to_add >= max_fluid_amount && fluid_amount < max_fluid_amount)
			to_chat(owner, "<span class='info'>Your [return_proper_name()] finally feel full.</span>")
		fluid_amount = min(to_add, max_fluid_amount)

/obj/item/organ/genital/penis/set_size(size)
	..()
	max_fluid_amount *= 1+((genital_size*PENIS_DEFAULT_PRODUCTIVITY)/max_fluid_amount)

/obj/item/organ/genital/testicles/set_size(size)
	..()
	max_fluid_amount *= 1+(genital_size*TESTICLE_DEFAULT_PRODUCTIVITY)

/obj/item/organ/genital/breasts/set_size(size)
	..()
	max_fluid_amount *= 1+(genital_size*BREASTS_DEFAULT_PRODUCTIVITY)

/obj/item/organ/genital/Insert(mob/living/carbon/M, special, drop_if_replaced)
	if(!iscarbon(M) || owner == M)
		return

	var/obj/item/organ/replaced = M.getorganslot(slot)
	if(replaced)
		replaced.Remove(M, special = TRUE)
		if(drop_if_replaced)
			replaced.forceMove(get_turf(M))
		else
			qdel(replaced)

	SEND_SIGNAL(M, COMSIG_CARBON_GAIN_ORGAN, src, special)

	owner = M
	M.internal_organs |= src
	M.internal_organs_slot[slot] = src
	moveToNullspace()
	RegisterSignal(owner, COMSIG_PARENT_EXAMINE, .proc/on_owner_examine)
	for(var/X in actions)
		var/datum/action/A = X
		A.Grant(M)

/obj/item/organ/genital/Remove(mob/living/carbon/M, special)
	UnregisterSignal(owner, COMSIG_PARENT_EXAMINE)

	owner = null
	if(M)
		M.internal_organs -= src
		if(M.internal_organs_slot[slot] == src)
			M.internal_organs_slot.Remove(slot)
		if((organ_flags & ORGAN_VITAL) && !special && !(M.status_flags & GODMODE))
			M.death()
	for(var/X in actions)
		var/datum/action/A = X
		A.Remove(M)

	SEND_SIGNAL(M, COMSIG_CARBON_LOSE_ORGAN, src, special)

	update_genital_icon_state()
