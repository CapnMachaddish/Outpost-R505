/obj/item/melee/hammer
	name = "D-4 Tactical hammer"
	desc = "A metallic-plastic composite breaching hammer, looks like a whack with this would severly harm or tire someone."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "peacekeeper_hammer"
	inhand_icon_state = "peacekeeper_hammer"
	worn_icon_state = "classic_baton"
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 20
	throw_range = 1
	wound_bonus = 30
	bare_wound_bonus = 40
	block_chance = 25
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("whacks","breaches","bulldozes","flings","thwachs")
	attack_verb_simple = list("breach","hammer","whack","slap","thwach","fling")
	/// Delay between door hits
	var/breaching_delay = 2 SECONDS
	/// The door we aim to breach
	var/breaching_target = null
	/// If we are in the process of breaching
	var/breaching = FALSE
	/// If we are tracking the door and ourselves
	var/registered = FALSE
	/// The person breaching , initially us but we receive a signal with another one
	var/breacher = null
	/// the amount that the force is multiplied by , that is then applied as damage to the door.
	var/breaching_multipler = 2.5

/obj/item/melee/hammer/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 5 // Less likely to parry a fucking bullet
	return ..()

/obj/item/melee/hammer/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/machinery/door))
		user.changeNext_move(5 SECONDS)
		if(!registered)
			RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/remove_track, FALSE)
			RegisterSignal(target, COMSIG_BREACHING, .proc/try_breaching, TRUE)
			to_chat(user, text = "You prepare to forcefully strike the door")
			registered = TRUE
		breacher = user
		SEND_SIGNAL(target, COMSIG_BREACHING, user)
		breaching_target = target
	if(iscarbon(target))
		user.changeNext_move(2 SECONDS)
		var/mob/living/carbon/H = target
		H.apply_damage_type(40, STAMINA)
		H.throw_at(get_step_away(H, user), 1, 1, user, TRUE, gentle = TRUE)

/// Removes any form of tracking from the user and the item , make sure to call it on he proper item
/obj/item/melee/hammer/proc/remove_track(mob/living/carbon/human/user)
	SIGNAL_HANDLER
	if(!registered)
		return FALSE
	registered = FALSE
	breaching = FALSE
	to_chat(user, text = "You relax yourself , and lay down the breaching hammer")
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(breaching_target, COMSIG_BREACHING)
	breaching_target = null
	breacher = null

/// Does the checks for breaching
/obj/item/melee/hammer/proc/try_breaching(obj/target, mob/living/carbon/human/user)
	SIGNAL_HANDLER
	if(breaching || (user == breacher))
		return FALSE
	if(!(user.Adjacent(target)))
		remove_track(user)
		return NONE
	var/mob/living/carbon/human/breach_buddy = breacher
	var/target_item = breach_buddy.held_items.Find(src, 1, 0)
	var/obj/item/melee/hammer/second_hammer = null
	if(target_item)
		second_hammer = breach_buddy.held_items[target_item]
	if(!second_hammer)
		remove_track(user)
		return FALSE
	breaching = TRUE
	INVOKE_ASYNC(src, /obj/item/melee/hammer.proc/breaching_loop , user, target)
	INVOKE_ASYNC(second_hammer, /obj/item/melee/hammer.proc/breaching_loop , breacher, target)
	to_chat(breacher , text = "You begin forcefully smashing the [target]")
	to_chat(user, text = "You begin forcefully smashing the [target]")

/// Keeps looping under the door is no more , or someone moves , gets shot , dies , incapacitated , stunned , etc
/obj/item/melee/hammer/proc/breaching_loop(mob/living/user, obj/target)
	if(user.stat || !target)
		remove_track(user)
		return FALSE
	if(!(user.Adjacent(target)))
		remove_track(user)
		return FALSE
	if(target.get_integrity() < 1)
		do_smoke(3, target.loc)
		remove_track(user)
		qdel(target, TRUE)
	var/mob/living/carbon/human/silly = breacher
	if(!silly)
		remove_track(user)
		return FALSE
	if(!(silly.Adjacent(target)))
		remove_track(user)
		return FALSE
	if(do_after(user, breaching_delay))
		if(QDELETED(target))
			return FALSE
		target.take_damage(force*breaching_multipler)
		playsound(target, 'sound/weapons/sonic_jackhammer.ogg', 70)
		visible_message("[user] smashes the [target] forcefully with the [src]")
		user.do_attack_animation(target, used_item = src)
		breaching_loop(user, target)
		return TRUE
	remove_track(user)

