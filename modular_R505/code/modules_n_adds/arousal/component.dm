//This is so arousal can be applied to literally anything, if you want it to.
//Normally this is only applied to humans with arousal enabled.
//But, for admemery, and modularization, this is a component that can be added to anything, as long as they have a client

/datum/component/arousal
	//The amount of arousal the mob has. It is clamped by min_arousal and max_arousal
	var/arousalloss = 0
	//The minimum amount of arousal possible. Dunno why this is a var, really
	var/minimum_arousal = AROUSAL_MINIMUM
	//The highest amount of arousal possible. Affects how quickly it takes to get to maximum
	var/maximum_arousal = AROUSAL_MAXIMUM
	//The chance per tick to send a random message to the client, but it does not send twice in a row
	var/aroused_messages_chance = AROUSED_MESSAGE_CHANCE
	//Random messages to send to the player when they're erect	//UNUSED
	var/list/arousal_messages = AROUSED_MESSAGES
	//If the mob has genitals, then this is when the sprites will become erect
	var/erect_threshold = AROUSAL_ERECT
	//What counts as half-erect
	var/chub_threshold = AROUSAL_CHUB
	//When the mob is able to use certain lewd actions
	var/can_climax_after = AROUSAL_CLIMAX
	//Multiplier for how much one can coom
	var/productivity_multiplier = 1
	//The rate of which the mob's arousal increases.
	var/arousal_rate = AROUSAL_RATE
	//The rate of which the mob's arousal decreases.
	var/arousal_loss_rate = AROUSAL_RATE
	//How fast arousal should be updated
	var/tickrate = AROUSAL_TICKRATE
	//The cooldown between climaxes to prevent silly abuse and spam
	var/mb_cooldown = 0
	//The static var for the time in-between climaxes. mb_cooldown uses this to check if you can coom or not
	var/cooldown_for_mb = CLIMAX_COOLDOWN
	//This list contains the genitals to update erect appearances, and updates when the mob's genital amount changes
	var/list/genitals = list()
	//This is to keep track how aroused the mob gets for the amount of exposed genitals they have
	var/exposed_genitals = 0
	//This var may be changed via code to stop the mob from getting aroused. In this component, it does not change
	var/can_be_aroused = TRUE
	//Fake organs for non-carbons. Can be changed with the arousal tgui
	var/pseudo_penis = FALSE
	var/pseudo_testicles = FALSE
	var/pseudo_breasts = FALSE
	var/pseudo_vagina = FALSE
	var/pseudo_womb = FALSE

	var/mob/holder
	var/is_carbon = FALSE	//Efficiency! Stop checking for subtypes, instead compare 1 to 0
	var/is_human = FALSE
	var/datum/hud/defined_hud	//More efficiency!
	var/datum/dna/dna_type	//AAA!
	var/atom/movable/screen/arousal/arousal_hud = new

/datum/component/arousal/Initialize(min_arousal=AROUSAL_MINIMUM,max_arousal=AROUSAL_MAXIMUM,gain_rate=AROUSAL_RATE,loss_rate=AROUSAL_RATE,erect=AROUSAL_ERECT,chub=AROUSAL_CHUB,climax_when=AROUSAL_CLIMAX,climax_cooldown=CLIMAX_COOLDOWN,message_chance=AROUSED_MESSAGE_CHANCE,update_rate=AROUSAL_TICKRATE,productivity=1)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	holder = parent
	if(iscarbon(holder))
		is_carbon = TRUE
		var/mob/living/carbon/C = holder
		dna_type = C.dna
	if(ishuman(holder))
		is_human = TRUE

	minimum_arousal = min_arousal
	maximum_arousal = max_arousal
	arousal_rate = gain_rate
	arousal_loss_rate = loss_rate
	cooldown_for_mb = climax_cooldown
	tickrate = update_rate
	erect_threshold = erect
	chub_threshold = chub
	can_climax_after = climax_when
	aroused_messages_chance = message_chance
	productivity_multiplier = productivity

	defined_hud = holder.hud_used
	add_arousal_hud()

	START_PROCESSING(SSfastprocess, src)

/datum/component/arousal/Destroy(force, silent)
	remove_arousal_hud()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/datum/component/arousal/proc/add_arousal_hud()
	if(!defined_hud)
		return
	if(!arousal_hud)
		arousal_hud = new()
	for(var/atom/movable/screen_obj in defined_hud.infodisplay)
		switch(screen_obj.type)
			if(/atom/movable/screen/healths)
				screen_obj.screen_loc = ui_health_arousal
			if(/atom/movable/screen/healthdoll)
				screen_obj.screen_loc = ui_healthdoll_arousal
			if(/atom/movable/screen/internals)
				screen_obj.screen_loc = ui_internal_arousal
			if(/atom/movable/screen/mood)
				screen_obj.screen_loc = ui_mood_arousal
			if(/atom/movable/screen/spacesuit)
				screen_obj.screen_loc = ui_spacesuit_arousal
	
	for(var/atom/movable/alert_obj in holder.screens)
		switch(alert_obj.screen_loc)
			if(ui_alert1)
				alert_obj.screen_loc = ui_alert1_arousal
			if(ui_alert2)
				alert_obj.screen_loc = ui_alert2_arousal
			if(ui_alert3)
				alert_obj.screen_loc = ui_alert3_arousal
			if(ui_alert4)
				alert_obj.screen_loc = ui_alert4_arousal
			if(ui_alert5)
				alert_obj.screen_loc = ui_alert5_arousal
	defined_hud.arousal = arousal_hud
	defined_hud.infodisplay |= arousal_hud
	holder.client.screen |= arousal_hud
	arousal_hud._arousal = src
	arousal_hud.hud = holder.hud_used

/datum/component/arousal/proc/remove_arousal_hud()
	if(!defined_hud)
		return
	for(var/atom/movable/screen_obj in defined_hud.infodisplay)
		switch(screen_obj.type)
			if(/atom/movable/screen/healths)
				screen_obj.screen_loc = ui_health
			if(/atom/movable/screen/healthdoll)
				screen_obj.screen_loc = ui_healthdoll
			if(/atom/movable/screen/internals)
				screen_obj.screen_loc = ui_internal
			if(/atom/movable/screen/mood)
				screen_obj.screen_loc = ui_mood
			if(/atom/movable/screen/spacesuit)
				screen_obj.screen_loc = ui_spacesuit

	for(var/atom/movable/alert_obj in holder.alerts)
		switch(alert_obj.screen_loc)
			if(ui_alert1_arousal)
				alert_obj.screen_loc = ui_alert1
			if(ui_alert2_arousal)
				alert_obj.screen_loc = ui_alert2
			if(ui_alert3_arousal)
				alert_obj.screen_loc = ui_alert3
			if(ui_alert4_arousal)
				alert_obj.screen_loc = ui_alert4
			if(ui_alert5_arousal)
				alert_obj.screen_loc = ui_alert5
	if(defined_hud.arousal)
		defined_hud.arousal = null
		defined_hud.infodisplay -= arousal_hud
		holder.client.screen -= arousal_hud
		arousal_hud._arousal = null
		arousal_hud.hud = null

/datum/component/arousal/process(deltatime)
	if(!(world.time % (tickrate * deltatime)) && can_be_aroused)
		process_arousal(FALSE)
		updatearousal()

//You always gain a steady arousal rate, but it changes if you have exposed genitals
/datum/component/arousal/proc/process_arousal(update=TRUE)
	ASSERT(can_be_aroused)
	if(!is_carbon)
		adjustArousalLoss(arousal_rate, FALSE, FALSE)
		return

	if(holder.client)
		var/exhibitionist
		if(dna_type)
			exhibitionist = (holder.client.prefs.r_preferences & R_PREF_EXHIBITIONIST)

		updateGenitalCount()
		var/watchers = 0
		for(var/mob/living/L in view(world.view, src))	//world.view because reasons
			if(L.client && !L.stat && !L.eye_blind)
				watchers++
		if(exhibitionist)
			adjustArousalLoss(arousal_rate + (exposed_genitals * watchers), update)
		else
			adjustArousalLoss(arousal_rate + -(exposed_genitals * watchers), update)

/datum/component/arousal/proc/updatearousal()
	update_arousal_hud()
	update_genital_arousal()

/datum/component/arousal/proc/adjustArousalLoss(amount, updating=TRUE, species_multiplier=TRUE)
	ASSERT(can_be_aroused)
	if(holder.status_flags & GODMODE)	//What do you mean this isn't damage?
		return FALSE
	. = arousalloss = clamp(arousalloss + (amount * (species_multiplier && dna_type ? dna_type.species.arousal_rate : 1)), minimum_arousal, maximum_arousal)
	if(updating)
		updatearousal()

/datum/component/arousal/proc/setArousalLoss(amount, updating=TRUE)
	ASSERT(can_be_aroused)
	if(holder.status_flags & GODMODE)
		return FALSE
	. = arousalloss = clamp(amount, minimum_arousal, maximum_arousal)
	if(updating)
		updatearousal()

/datum/component/arousal/proc/update_genital_arousal()
	if((!is_carbon || !can_be_aroused) && !IsAdminAdvancedProcCall())
		return
	var/aroused_level = get_arousal_level()
	for(var/obj/item/organ/genital/G in genitals)
		if(G.aroused != AROUSAL_CANT)
			G.aroused = aroused_level
		G.update_sprite_suffix()
	holder.update_body()

/datum/component/arousal/proc/update_arousal_hud()
	if(!holder.client)
		return
	if(!can_be_aroused)
		arousal_hud.icon_state = ""
	arousal_hud.icon_state = "arousal[get_arousal_percentage()]"	//0 to 10

/datum/component/arousal/proc/updateGenitalCount()
	if(!is_carbon)
		return
	var/mob/living/carbon/C = holder
	exposed_genitals = 0
	genitals = list()
	for(var/obj/item/organ/genital/G in C.internal_organs)
		genitals += G

		var/datum/sprite_accessory/genital/genital_sprite = GLOB.sprite_accessories[G.mutantpart_key][dna_type.species.mutant_bodyparts[G.mutantpart_key][MUTANT_INDEX_NAME]]
		if(!genital_sprite.is_hidden(C))	//May cause runtimes? not sure
			exposed_genitals++

/datum/component/arousal/proc/send_aroused_message(forced_message as text)
	to_chat(parent, "<span class='userlove'>[forced_message ? forced_message : pick(arousal_messages)]</span>")

//LEWD STUFF
/datum/component/arousal/proc/climax(mode, silent=FALSE, forced)
	if(forced)
		log_arousal(forced, holder)
	if(!silent)
		if(!is_groin_exposed(holder) && (get_organ_visibility(ORGAN_SLOT_PENIS) || get_organ_visibility(ORGAN_SLOT_VAGINA)))
			holder.visible_message(\
			span_love("[holder] shudders, bringing [holder.p_their()] legs together."),
			span_userlove("Your pleasure couldn't be held back; you climax underneath your clothes."))
			if(is_carbon)
				switch(mode)
					if(CLIMAX_PENIS)
						var/obj/item/organ/genital/testicles/testicles = get_owner_organ(ORGAN_SLOT_TESTICLES)
						var/obj/item/organ/genital/penis/penis = get_owner_organ(ORGAN_SLOT_PENIS)
						if(istype(testicles))
							testicles.return_fluid(TRUE, productivity_multiplier)
						if(istype(penis))
							penis.return_fluid(TRUE, productivity_multiplier)
					if(CLIMAX_VAGINA)
						var/obj/item/organ/genital/vagina/vagina = get_owner_organ(ORGAN_SLOT_VAGINA)
						if(istype(vagina))
							vagina.return_fluid(TRUE, productivity_multiplier)
			setArousalLoss(arousalloss * 0.12)
			SEND_SIGNAL(usr, COMSIG_ADD_MOOD_EVENT, AROUSAL, /datum/mood_event/pleasure_climax)
			return
		switch(mode)
			if(CLIMAX_PENIS)
				if(is_chest_exposed(holder))
					holder.visible_message(\
					span_love("[holder] shudders, and climaxes all over [holder.p_them()]self."),
					span_userlove("Your pleasure couldn't be held back, and you climax all over yourself."))
				else
					holder.visible_message(\
					span_love("[holder] shudders, and climaxes all over [holder.p_their()] clothes."),
					span_userlove("Your pleasure couldn't be held back, you climax all over yourself."))
				var/hasbits = FALSE
				if(is_carbon)
					hasbits = TRUE
					var/obj/item/organ/genital/testicles/testicles = get_owner_organ(ORGAN_SLOT_TESTICLES)
					var/obj/item/organ/genital/penis/penis = get_owner_organ(ORGAN_SLOT_PENIS)
					var/datum/reagents/R = new(1000)
					if(istype(testicles))
						R = testicles.return_fluid(TRUE)
						R.expose(holder.loc, show_message=FALSE)
					else if(testicles == TRUE)
						hasbits = FALSE
						
					if(istype(penis))
						hasbits=TRUE
						R = penis.return_fluid(TRUE, productivity_multiplier)
						R.expose(holder.loc, show_message=FALSE)
					else if(penis ==TRUE)
						hasbits = FALSE
				if(!hasbits)
					var/turf/T = get_turf(holder)
					if(T)
						var/obj/effect/decal/cleanable/ejaculate/semen/liquid = locate() in T
						if(!liquid)
							liquid = new(T)
						liquid.reagents.add_reagent(/datum/reagent/semen, 10)

			if(CLIMAX_VAGINA)
				holder.visible_message(\
				span_love("[holder] shudders, moaning as [holder.p_their()] legs flex and squeeze together."),
				span_userlove("Your pleasure couldn't be held back, you can't help but moan as you climax."))
				var/hasbits = FALSE
				if(is_carbon)
					hasbits=TRUE
					var/obj/item/organ/genital/vagina/vagina = get_owner_organ(ORGAN_SLOT_VAGINA)
					var/datum/reagents/R = new(1000)
					if(istype(vagina))
						R = vagina.return_fluid(TRUE, productivity_multiplier)
						R.expose(holder.loc, show_message=FALSE)
					else if(vagina == TRUE)
						hasbits=FALSE
				if(!hasbits)
					var/turf/T = get_turf(holder)
					if(T)
						var/obj/effect/decal/cleanable/ejaculate/femcum/liquid = locate() in T
						if(!liquid)
							liquid = new(T)
						liquid.reagents.add_reagent(/datum/reagent/femcum, 10)

	setArousalLoss(arousalloss * 0.1)
	SEND_SIGNAL(holder, COMSIG_ADD_MOOD_EVENT, AROUSAL, /datum/mood_event/pleasure_climax)

/datum/component/arousal/proc/climax_with(mob/partner, mode, datum/component/arousal/component, silent=FALSE, forced)
	if(forced)
		log_arousal(forced, holder, partner)
	if(!component)
		component = partner.GetComponent(/datum/component/arousal)
		if(!component)
			return

	if(!silent)
		switch(mode)
			if(PARTNER_INTERACT_PENIS_PENIS)
				holder.visible_message(span_love("[holder] climaxes with [partner], spreading seed onto themselves."), ignored_mobs=list(holder, partner))
				to_chat(holder, span_userlove("You climax with [partner], ejaculating onto [partner.p_them()]."))
				to_chat(partner, span_userlove("You climax with [holder], ejaculating onto [holder.p_them()]."))
			if(PARTNER_INTERACT_PENIS_VAGINA)
				holder.visible_message(span_love("[holder] climaxes with [partner], ejaculating into [partner.p_them()]."), ignored_mobs=list(holder, partner))
				to_chat(holder, span_userlove("You climax with [partner], ejaculating into [partner.p_them()]."))
				to_chat(partner, span_userlove("You climax with [holder], letting pleasure rush through your body."))
			if(PARTNER_INTERACT_VAGINA_PENIS)
				holder.visible_message(span_love("[holder] climaxes with [partner] as [holder.p_they()] get[holder.p_s()] pounded by [partner.p_them()]."), ignored_mobs=list(holder, partner))
				to_chat(holder, span_userlove("You climax with [partner], letting pleasure rush through your body."))
				to_chat(partner, span_userlove("You climax with [holder], ejaculating into [holder.p_them()]."))
			if(PARTNER_INTERACT_VAGINA_VAGINA)
				holder.visible_message(span_love("[holder] climaxes with [partner] as they rub against eachother's vaginas."), ignored_mobs=list(holder, partner))
				to_chat(holder, span_userlove("You climax with [partner], letting pleasure rush through your body."))
				to_chat(partner, span_userlove("You climax with [holder], letting pleasure rush through your body."))
	switch(mode)
		if(PARTNER_INTERACT_PENIS_PENIS)
			climax(CLIMAX_PENIS, TRUE, forced)
			component.climax(CLIMAX_PENIS, TRUE, forced)
		if(PARTNER_INTERACT_PENIS_VAGINA)
			climax(CLIMAX_PENIS, TRUE, forced)
			component.climax(CLIMAX_VAGINA, TRUE, forced)
		if(PARTNER_INTERACT_VAGINA_PENIS)
			climax(CLIMAX_VAGINA, TRUE, forced)
			component.climax(CLIMAX_PENIS, TRUE, forced)
		if(PARTNER_INTERACT_VAGINA_VAGINA)
			climax(CLIMAX_VAGINA, TRUE, forced)
			component.climax(CLIMAX_VAGINA, TRUE, forced)

/*/datum/component/arousal/proc/climax_over(atom/movable/AM, mode, forced)
	if(forced)
		log_arousal(holder, "[forced], with [AM] ([AM.type])")*/

/datum/component/arousal/proc/climax_in(obj/item/I, mode, forced)
	if(forced)
		log_arousal(forced, holder)
	var/volume_till_full = I.reagents.maximum_volume - I.reagents.total_volume
	var/datum/reagents/R
	switch(mode)
		if(INTERACT_PENIS)
			var/obj/item/organ/genital/penis/penis = get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/testicles/testicles = get_owner_organ(ORGAN_SLOT_TESTICLES)
			if(!penis)
				return
			if(testicles)
				R = testicles.return_fluid(TRUE, productivity_multiplier)
			else
				R = penis.return_fluid(TRUE, productivity_multiplier)

			if(R.total_volume > volume_till_full)
				if(R.total_volume > volume_till_full * 2)
					holder.visible_message(\
					span_love("[holder] climaxes into [I], overflowing it with semen."),
					span_userlove("You climax into [I] and overflow it with cum, and then some."))
					I.AddComponent(/datum/component/cleanable, 'modular_R505/icons/ported/obj/cumoverlay.dmi', "cum_obj", TRUE)
				else
					holder.visible_message(\
					span_love("[holder] climaxes into [I], filling it to the brim with semen."),
					span_userlove("You climax into [I], filling it completely with semen."))
			else
				holder.visible_message(\
				span_love("[holder] climaxes into [I], filling it with cum."),
				span_userlove("You climax into [I], filling it up with cum."))
		if(INTERACT_TESTICLES)
			var/obj/item/organ/genital/penis/penis = get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/testicles/testicles = get_owner_organ(ORGAN_SLOT_TESTICLES)
			if(!penis)
				return
			R = penis.return_fluid(TRUE, productivity_multiplier)
			if(testicles)	//How did we get here if we don't have testicles? Oh well, check anyways!
				var/datum/reagents/R2 = testicles.return_fluid(TRUE, productivity_multiplier)
				R2.trans_to(R, R2.total_volume)
			if(R.total_volume > volume_till_full * 3)	//damn hypers squeezing their balls
				holder.visible_message(\
				span_love("[holder] gently squeezes [holder.p_their()] testicles and over-fills [I] with semen!"),
				span_userlove("You gently press against your testicles and overflow [I] with semen."))
				I.AddComponent(/datum/component/cleanable, 'modular_R505/icons/ported/obj/cumoverlay.dmi', "cum_obj", TRUE)
			else
				holder.visible_message(\
				span_love("[holder] massages [holder.p_their()] testicles until they leak semen into [I]."),
				span_userlove("You play with your testicles until you start leaking cum into [I]."))
		if(INTERACT_BREASTS)
			var/obj/item/organ/genital/breasts/breasts = get_owner_organ(ORGAN_SLOT_BREASTS)
			if(!breasts)
				return
			R = breasts.return_fluid(TRUE, productivity_multiplier)
			if(R.total_volume > volume_till_full)
				if(R.total_volume > volume_till_full * 2)
					holder.visible_message(\
					span_love("[holder] squeezes and massages [holder.p_their()] breasts over [I], overfilling it with milk!"),
					span_userlove("You squeeze and carress your breasts and leak milk into [I], overfilling it!"))
					//TODO: No overlay yet
				else
					holder.visible_message(\
					span_love("[holder] squeezes and massages [holder.p_their()] breasts over [I], filling it to the brim with milk."),
					span_userlove("You squeeze your nipples and leak your milk into [I], filling it to the brim with milk."))
			else
				holder.visible_message(\
				span_love("[holder] squeezes [holder.p_their()] breasts over [I], filling it up with [holder.p_their()] milk."),
				span_userlove("You squeeze your nipples over [I], leaking milk into the container."))
	R.trans_to(I, R.maximum_volume)
	setArousalLoss(arousalloss * 0.05)
	SEND_SIGNAL(holder, COMSIG_ADD_MOOD_EVENT, AROUSAL, /datum/mood_event/pleasure_climax)
