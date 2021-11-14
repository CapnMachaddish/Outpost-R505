/atom/movable/screen/arousal
	name = "arousal menu"
	icon = 'modular_r505/icons/ported/hud.dmi'	//From citadel station
	icon_state = "arousal0"
	screen_loc = ui_arousal
	var/datum/component/arousal/_arousal
	interaction_flags_atom = NONE

/atom/movable/screen/arousal/Click()
	ui_interact(usr)

/atom/movable/screen/arousal/proc/get_component(mob/user)
	. = _arousal = user.GetComponent(/datum/component/arousal)

/atom/movable/screen/arousal/ui_interact(mob/user, datum/tgui/ui)

	var/dat = ""
	dat += "<table width='100%'><tr height='50%' valign='center'>"
	dat += "<td valign='left'><a href='?src=[REF(src)];poll_list=climax'>Climax</a></td>"
	dat += "<td valign='right'><a href='?src=[REF(src)];poll_list=climax_with'>Climax with partner</a></td>"
	dat += "</tr><tr height='50%' valign='center'>"
	dat += "<td valign='left'><a href='?src=[REF(src)];poll_list=massage'>Massage (w/ obj.)</a></td>"
	dat += "<td valign='right'><a href='?src=[REF(src)];poll_list=climax_in'>Climax in object</a></td>"
	dat += "</tr></table>"

	#ifdef TESTING
	dat += "<a href='?src=[REF(src)];setarousal=1'>Maximize Arousalloss</a>"
	#endif
	
	if(dat)
		var/datum/browser/popup = new(user, "arousal_info", "<div align='center'>Arousal Actions</div>", 300, 100)
		popup.set_content(dat)
		popup.open(FALSE)

/atom/movable/screen/arousal/Topic(href, list/href_list)
#ifdef TESTING
	if(href_list["set_aroual"])
		_arousal.setArousalLoss(100)
#endif
	switch(href_list["poll_list"])
		if("climax")
			var/obj/item/organ/genital/penis/penis = _arousal.get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina/vagina = _arousal.get_owner_organ(ORGAN_SLOT_VAGINA)
			if(!(penis || vagina))
				to_chat(usr, "<span class='warning'>You can't do that right now.</span>")
				return
			if(_arousal.arousalloss <= _arousal.can_climax_after || usr.stat)
				to_chat(usr, "<span class='warning'>You can't do that right now.</span>")
				return

			var/list/genitals = list()

			if(istype(penis))
				genitals[penis.return_proper_name()] = CLIMAX_PENIS
			else if(penis == TRUE)
				genitals["Penis"] = CLIMAX_PENIS

			if(istype(vagina))
				genitals[vagina.return_proper_name()] = CLIMAX_VAGINA
			else if(vagina == TRUE)
				genitals["Vagina"] = CLIMAX_VAGINA
			var/chosen_action = input(usr, "Which genital do you want to use?", "Climax Option") as null|anything in genitals
			if(chosen_action)
				climax(genitals[chosen_action])
		
		if("climax_with")	//This part is VERY ugly but only for efficiency reasons. This is inside a topic, after all
			if(!ismob(usr.pulling))	//Oops! All runtimes!
				to_chat(usr, "<span class='warning'>You have to be holding someone to climax with them.</span>")
				return
			var/mob/partner = usr.pulling
			if(usr.stat || partner.stat)
				to_chat(usr, "<span class='warning'>You can't do this right now.</span>")
				return
		#ifndef TESTING
			if(!partner.client)
				return
			if(isliving(partner))
				var/mob/living/L = partner
				if(L.ssd_indicator && L.lastclienttime)
					to_chat(usr, "<span class='warning'>You can't do that right now.</span>")
					return
		#endif
			AROUSAL_VAR(partner_arousal, partner)
			if(!partner_arousal)
				to_chat(usr, "<span class='warning'>[partner] cannot climax.</span>")
				to_chat(partner, "<span class='warning'>[usr] tried to climax with you, but you do not have arousal.</span>")
				return

			var/obj/item/organ/genital/penis/partner_penis = partner_arousal.get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina/partner_vagina = partner_arousal.get_owner_organ(ORGAN_SLOT_VAGINA)
			if(!(partner_penis || partner_vagina))
				to_chat(usr, "<span class='warning'>Your partner doesn't have any genitals.</span>")
				return
			var/obj/item/organ/genital/penis/src_penis = _arousal.get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina/src_vagina = _arousal.get_owner_organ(ORGAN_SLOT_VAGINA)
			if(!(src_penis || src_vagina))
				to_chat(usr, "<span class='warning'>You have no genitals to climax with.</span>")
				return

			var/list/partner_genitals = list()
			var/list/src_genitals = list()
			if(istype(partner_penis))
				partner_genitals["Partner's [partner_penis.return_proper_name()]"] = CLIMAX_PENIS
			else if(partner_penis==TRUE)
				partner_genitals["Partner's penis"] = CLIMAX_PENIS
			
			if(istype(partner_vagina))
				partner_genitals["Partner's [partner_vagina.return_proper_name()]"] = CLIMAX_VAGINA
			else if(partner_vagina==TRUE)
				partner_genitals["Partner's vagina"] = CLIMAX_VAGINA
			
			if(istype(src_penis))
				src_genitals["Your [src_penis.return_proper_name()]"] = CLIMAX_PENIS
			else if(src_penis==TRUE)
				src_genitals["Your penis"] = TRUE
			
			if(istype(src_vagina))
				src_genitals["Your [src_vagina.return_proper_name()]"] = CLIMAX_VAGINA
			else if(src_vagina==TRUE)
				src_genitals["Your vagina"] = TRUE
			
			var/usr_use = input(usr, "Which genital do you want to use on your partner?", "Your Genitals") as null|anything in src_genitals
			if(!usr_use)
				return
			var/partner_use = input(usr, "Which of your partner's genitals do you want to target?", "Partner's Genitals") as null|anything in partner_genitals
			if(!partner_use)
				return
			
			switch(src_genitals[usr_use])
				if(CLIMAX_PENIS)
					switch(partner_genitals[partner_use])
						if(CLIMAX_PENIS)
							climax_with(PARTNER_INTERACT_PENIS_PENIS, partner)
						if(CLIMAX_VAGINA)
							climax_with(PARTNER_INTERACT_PENIS_VAGINA, partner)
				if(CLIMAX_VAGINA)
					switch(partner_genitals[partner_use])
						if(CLIMAX_PENIS)
							climax_with(PARTNER_INTERACT_VAGINA_PENIS, partner)
						if(CLIMAX_VAGINA)
							climax_with(PARTNER_INTERACT_VAGINA_VAGINA, partner)
		if("massage")
			var/obj/item/organ/genital/penis/penis = _arousal.get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/testicles/testicles = _arousal.get_owner_organ(ORGAN_SLOT_TESTICLES)
			var/obj/item/organ/genital/vagina/vagina = _arousal.get_owner_organ(ORGAN_SLOT_VAGINA)
			var/obj/item/organ/genital/breasts/breasts = _arousal.get_owner_organ(ORGAN_SLOT_BREASTS)
			if(!(penis || testicles || vagina || breasts))
				to_chat(usr, "<span class='warning'>You have no genitals to interact with.</span>")
			var/list/genitals = list()

			if(istype(penis))
				genitals[penis.return_proper_name()] = INTERACT_PENIS
			else if(penis==TRUE)
				genitals["Penis"] = INTERACT_PENIS
			if(istype(breasts))
				genitals[breasts.return_proper_name()] = INTERACT_BREASTS
			else if(breasts==TRUE)
				genitals["Breasts"] = INTERACT_BREASTS
			if(testicles)
				genitals["Testicles"] = INTERACT_TESTICLES
			if(istype(vagina))
				genitals[vagina.return_proper_name()] = INTERACT_VAGINA
				genitals["Clitoris"] = INTERACT_CLITORIS
			else if(vagina==TRUE)
				genitals["Vagina"] = INTERACT_VAGINA
				genitals["Clitoris"] = INTERACT_CLITORIS
			
			var/choice = input(usr, "What would you like to massage?", "Genital Choice") as null|anything in genitals
			if(!choice)
				return
			massage(genitals[choice], usr.get_active_held_item())
		
		if("climax_in")
			if(!(usr.get_active_held_item() || usr.pulling))
				return
			var/obj/item/I
			if(ismob(usr.pulling))
				I = usr.get_active_held_item()
			else
				I = usr.get_active_held_item() || usr.pulling
			if(!I.is_open_container())
				to_chat(usr, "<span class='warning'>You can only climax inside of open containers.</span>")
				return
			var/obj/item/organ/genital/penis/penis = _arousal.get_owner_organ(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/breasts/breasts = _arousal.get_owner_organ(ORGAN_SLOT_BREASTS)
			var/obj/item/organ/genital/testicles/testicles = _arousal.get_owner_organ(ORGAN_SLOT_TESTICLES)
			if(!(penis || breasts))
				to_chat(usr, "<span class='warning'>You have no organs that can fill containers.</span>")
			var/list/choices = list()
			if(istype(penis))
				choices[penis.return_proper_name()] = INTERACT_PENIS
			else if(penis==TRUE)
				choices["Penis"] = INTERACT_PENIS
			if(testicles)
				choices["Testicles"] = INTERACT_TESTICLES
			if(istype(breasts))
				choices[breasts.return_proper_name()] = INTERACT_BREASTS
			else if(breasts==TRUE)
				choices["Breasts"] = INTERACT_BREASTS
			var/chosen = input(usr, "Select which genital you want to use", "Select Genital") as null|anything in choices
			if(!chosen)
				return
			climax_in(choices[chosen], I)

/atom/movable/screen/arousal/proc/climax(mode)
	if(!_arousal.can_use_activity())
		to_chat(usr, "<span class='warning'>You need to wait to use this action again.</span>")
		return
	switch(mode)
		if(CLIMAX_PENIS)
			if(!_arousal.get_organ_visibility(ORGAN_SLOT_PENIS))	//Hidden
				usr.visible_message(\
				"<span class='love'>[usr] huffs...</span>",
				"<span class='userlove'>You get ready to climax [is_groin_exposed(hud.mymob) ? "inside your clothes" : "without anyone knowing"]...</span>")
			else	//Not hidden
				usr.visible_message(\
				"<span class='love'>[usr] starts rubbing [usr.p_their()] penis, about to climax...</span>",
				"<span class='userlove'>You begin rubbing your penis, about to climax...</span>")
		if(CLIMAX_VAGINA)
			if(!_arousal.get_organ_visibility(ORGAN_SLOT_VAGINA))	//Hidden
				usr.visible_message(\
				"<span class='love'>[usr] huffs...</span>",
				"<span class='userlove'>You get ready to climax[is_groin_exposed(hud.mymob) ? " inside your clothes" : ", without anyone knowing"]...</span>")
			else	//Not hidden
				usr.visible_message(\
				"<span class='love'>[usr] fingers [usr.p_their()] vagina, getting ready to climax...</span>",
				"<span class='userlove'>You begin to penetrate your vagina with your fingers, ready to climax...</span>")
	_arousal.mb_cooldown = world.time
	if(do_after(usr, abs(_arousal.arousalloss - (_arousal.maximum_arousal-20)), usr, IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE))
		_arousal.mb_cooldown = world.time
		_arousal.climax(mode)
	else if(_arousal.get_arousal_level() < AROUSAL_FULL)
		_arousal.adjustArousalLoss(_arousal.maximum_arousal/_arousal.arousalloss+1)

/atom/movable/screen/arousal/proc/climax_with(mode, mob/partner)
	AROUSAL_VAR(partner_arousal, partner)
	if(!_arousal.can_use_activity() || !partner_arousal.can_use_activity())
		to_chat(usr, "<span class='warning'>You need to wait to use this action again.</span>")
		return

	var/usr_climax = FALSE
	var/partner_climax = FALSE
	if(_arousal.arousalloss > _arousal.can_climax_after)
		usr_climax = TRUE
	if(partner_arousal.arousalloss > partner_arousal.can_climax_after)
		partner_climax = TRUE

	if(!(usr_climax || partner_climax))
		to_chat(usr, "<span class='warning'>You cannot climax with [partner], neither of you are aroused enough.</span>")
		to_chat(partner, "<span class='warning'>[usr] tried to climax with you, but neither of you are aroused enough.</span>")
		return
	else
		switch(mode)
			if(PARTNER_INTERACT_IMPREGNATE_RECIEVING)
				if(!partner_climax)
					to_chat(usr, "<span class='warning'>You cannot climax with [partner], they are not aroused enough.</span>")
					to_chat(partner, "<span class='warning'>[usr] tried to get impregnated by you, but you are not aroused enough.</span>")
					return
			if(PARTNER_INTERACT_IMPREGNATE_GIVING)
				if(!usr_climax)
					to_chat(usr, "<span class='warning'>You cannot climax with [partner], you are not aroused enough.</span>")
					to_chat(partner, "<span class='warning'>[usr] tried to impregnate you, but they are not aroused enough.</span>")
					return
	switch(mode)
		if(PARTNER_INTERACT_PENIS_PENIS)
			usr.visible_message(\
			"<span class='love'>[usr] grinds their penis against [partner]'s groin, ready to climax with them...</span>",
			"<span class='userlove'>You grind yourself against [partner], about to climax...</span>")
			_arousal.mb_cooldown = world.time
			if(do_after(usr, 6 SECONDS, partner, IGNORE_HELD_ITEM))
				_arousal.mb_cooldown = world.time
				_arousal.climax_with(partner, PARTNER_INTERACT_PENIS_PENIS, partner_arousal)
		if(PARTNER_INTERACT_PENIS_VAGINA, PARTNER_INTERACT_IMPREGNATE_GIVING)
			usr.visible_message(\
			"<span class='love'>[usr] inserts [usr.p_their()] penis into [partner], about to climax...</span>",
			"<span class='userlove'>You insert your rod into [partner], about to climax with them...</span>")
			_arousal.mb_cooldown = world.time
			if(do_after(usr, 10 SECONDS, partner, IGNORE_HELD_ITEM))	//Long time because impregnation, you need proper consent
				_arousal.mb_cooldown = world.time
				_arousal.climax_with(partner, mode, partner_arousal)
		if(PARTNER_INTERACT_VAGINA_PENIS, PARTNER_INTERACT_IMPREGNATE_RECIEVING)
			usr.visible_message(\
			"<span class='love'>[usr] presents [usr.p_them()]self to [partner], willing to climax with them...</span>",
			"<span class='userlove'>You present your pussy to [partner], having them insert their dick into you...</span>",
				ignored_mobs = list(partner))
			partner.visible_message(\
			"<span class='love'>[partner] inserts [partner.p_their()] length into [usr], about to climax inside of them...</span>",
			"<span class='userlove'>You insert your whole length into your partner, about to climax into them...</span>",
				ignored_mobs = list(usr))
			_arousal.mb_cooldown = world.time
			if(do_after(usr, 10 SECONDS, partner, IGNORE_HELD_ITEM))	//Long time because impregnation, you need proper consent
				_arousal.mb_cooldown = world.time
				_arousal.climax_with(partner, mode, partner_arousal)
		if(PARTNER_INTERACT_VAGINA_VAGINA)
			usr.visible_message(\
			"<span class='love'>[usr] starts grinding [usr.p_their()] pussy against [partner]'s, about to climax with them...</span>",
			"<span class='userlove'>You start grinding against [partner]'s pussy, ready to climax with them...</span>")
			_arousal.mb_cooldown = world.time
			if(do_after(usr, 6 SECONDS, partner, IGNORE_HELD_ITEM))
				_arousal.mb_cooldown = world.time
				_arousal.climax_with(partner, PARTNER_INTERACT_VAGINA_VAGINA, partner_arousal)

/atom/movable/screen/arousal/proc/massage(mode, obj/item/I)
	if(usr.stat)
		to_chat(usr, "<span class='warning'>You can't do that right now.</span>")
		return
	if(!_arousal.can_use_activity())
		to_chat(usr, "<span class='warning'>You need to wait to use this action again.</span>")
		return
	if(I)
		if(I.sharpness)
			I = null	//Don't play with that you'll go blind
	
	var/p_their = usr.p_their()
	var/p_them = usr.p_them()

	var/massaged = FALSE

	switch(mode)
		if(INTERACT_TESTICLES)
			if(!(_arousal.get_organ_visibility(ORGAN_SLOT_TESTICLES) || is_groin_exposed(usr)))
				usr.visible_message(\
				"<span class='love'>[usr] rubs [p_their] crotch area.</span>",
				"<span class='userlove'>You rub your testicles from the outside of your clothing, bringing you pleasure.</span>")
				massaged = TRUE
			else
				usr.visible_message(\
				"<span class='love'>[usr] pleasures [p_them]self by massaging [p_their] testicles.</span>",
				"<span class='userlove'>You pleasure yourself by massaging your testicles.</span>")
				massaged = TRUE
		if(INTERACT_VAGINA)
			if(!(_arousal.get_organ_visibility(ORGAN_SLOT_VAGINA) || is_groin_exposed(usr)))
				usr.visible_message(\
				"<span class='love'>[usr] rubs [p_their] lower crotch area.</span>",
				"<span class='userlove'>You rub your vagina from the outside of your clothing, bringing you pleasure.</span>")
				massaged = TRUE
			else
				usr.visible_message(\
				"<span class='love'>[usr] fingers [p_their] vagina, pleasuring [p_them]self.</span>",
				"<span class='userlove'>You insert your fingers over and over into your vagina.</span>")
				massaged = TRUE
		if(INTERACT_CLITORIS)
			if(!(_arousal.get_organ_visibility(ORGAN_SLOT_VAGINA) || is_groin_exposed(usr)))
				usr.visible_message(\
				"<span class='love'>[usr] rubs [p_their] crotch area.</span>",
				"<span class='userlove'>You play with your clitoris outside of your clothing, bringing you pleasure.</span>")
				massaged = TRUE
			else
				usr.visible_message(\
				"<span class='love'>[usr] starts playing with [p_their] clitoris, bringing in pleasure...</span>",
				"<span class='userlove'>You massage your clitoris, sending in teasing pleasure...</span>")
				massaged = TRUE

	if(massaged)
		_arousal.adjustArousalLoss(4)
		_arousal.mb_cooldown = world.time
		return

	if(I)
		var/p_it = I.p_them()	//fucking pit
		var/open_container = I.is_open_container()

		//When the item is an open container
		if(open_container)
			switch(mode)
				if(INTERACT_PENIS)
					if(_arousal.get_organ_visibility(ORGAN_SLOT_PENIS) || is_groin_exposed(usr))
						usr.visible_message(\
						"<span class='love'>[usr] starts massaging [p_their] penis over [I]...</span>",
						"<span class='userlove'>You start massaging yourself over [I]...</span>")
						_arousal.mb_cooldown = world.time
						if(do_after(usr, 6 SECONDS, usr))
							usr.visible_message(\
							"<span class='love'>[usr] massages [p_their] penis over [I], leaking precum into [p_it]...</span>",
							"<span class='userlove'>You play with your penis over [I], trying to fill [p_it] up with precum...</span>")
							massaged = TRUE
					else
						open_container = FALSE
				if(INTERACT_BREASTS)
					var/obj/item/organ/genital/breasts/B
					if(!(_arousal.get_organ_visibility(ORGAN_SLOT_BREASTS) || is_chest_exposed(usr)))
						open_container = FALSE
					else if(iscarbon(usr))
						var/mob/living/carbon/C = usr
						B = C.getorganslot(ORGAN_SLOT_BREASTS)
						if(B.should_lactate())
							usr.visible_message(\
							"<span class='love'>[usr] starts squeezing [p_their] nipples over [I]...</span>",
							"<span class='userlove'>You start squeezing your nipples over [I]...</span>")
							_arousal.mb_cooldown = world.time
							if(do_after(usr, 6 SECONDS, usr))	//TODO: scale time with how much milk is in their breasts
								usr.visible_message(\
								"<span class='love'>[usr] plays with [p_their] breasts over [I], leaking milk into [p_it].</span>",
								"<span class='userlove'>You squeeze and play with your nipples over [I], filling [p_it] up with milk.</span>")
								massaged = TRUE
						else
							B = null
					if(!B && open_container)
						usr.visible_message(\
						"<span class='love'>[usr] starts rubbing [I] against [p_their] breasts...</span>",
						"<span class='userlove'>You start rubbing [I] against your breasts...</span>")
						_arousal.mb_cooldown = world.time
						if(do_after(usr, 6 SECONDS, usr))
							if(I.reagents)
								if(I.reagents.total_volume / I.reagents.maximum_volume > 0.75)
									var/datum/reagents/R = new(1000)
									I.reagents.trans_to(R, round(I.reagents.total_volume/rand(4,7)))
									if(prob(80))
										usr.visible_message(\
										"<span class='love'>[usr] rubs [I] against [p_their] breasts, spilling some contents onto them in the process!</span>",
										"<span class='userlove'>You rub [I] around your breasts, and spill some of its contents onto yourself!</span>")
										R.expose(usr, show_message=FALSE)
										massaged = TRUE
									else
										usr.visible_message(\
										"<span class='love'>[usr] rubs [I] against [p_their] breasts, spilling some of its contents onto the floor!</span>",
										"<span class='userlove'>You rub [I] around your breasts, and spill some of its contents onto the floor!</span>")
										R.expose(get_turf(usr), show_message=FALSE)
										massaged = TRUE
								else
									usr.visible_message(\
									"<span class='love'>[usr] messages [I] against [p_their] breasts, not spilling a drop.</span>",
									"<span class='userlove'>You message your breasts with [I], not spilling any of its contents.</span>")
									massaged = TRUE
		//When the item is not an open container, or when our genitals aren't exposed
		if(!open_container)
			switch(mode)
				if(INTERACT_PENIS)
					if(!(_arousal.get_organ_visibility(ORGAN_SLOT_PENIS) || is_groin_exposed(usr)))
						usr.visible_message(\
						"<span class='love'>[usr] starts rubbing [I] against their crotch area...</span>",
						"<span class='userlove'>You start to rub [I] against your crotch...</span>")
						_arousal.mb_cooldown = world.time
						if(do_after(usr, 6 SECONDS, usr))
							_arousal.mb_cooldown = world.time
							usr.visible_message(\
							"<span class='love'>[usr] rubs [I] against their crotch.</span>",
							"<span class='userlove'>You rub [I] against your crotch area.</span>")
							massaged = TRUE
					else
						if(istype(I, /obj/item/soap))
							var/obj/item/soap/S = I
							usr.visible_message(\
							"<span class='love'>[usr] starts cleaning [p_their] penis with [S]...</span>",
							"<span class='userlove'>You start to clean your dick with [S]...</span>")
							_arousal.mb_cooldown = world.time
							if(do_after(usr, S.cleanspeed * 1.5, usr))
								_arousal.mb_cooldown = world.time
								usr.wash(CLEAN_SCRUB)
								usr.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
								S.decreaseUses(usr)
								usr.visible_message(\
								"<span class='love'>[usr] cleans [p_their] penis with [S].</span>",
								"<span class='userlove'>You clean your penis with [S].</span>")
								massaged = TRUE
						else
							usr.visible_message(\
							"<span class='love'>[usr] starts rubbing [p_their] penis against [I]...</span>",
							"<span class='userlove'>You start rubbing your dick against [I]...</span>")
							_arousal.mb_cooldown = world.time
							if(do_after(usr, 6 SECONDS, usr))
								_arousal.mb_cooldown = world.time
								usr.visible_message(\
								"<span class='love'>[usr] frotts [p_their] penis against [I], rubbing precum onto [p_it].</span>",
								"<span class='userlove'>You massage your penis over [I] and frott with [p_it].</span>")
								massaged = TRUE
				if(INTERACT_BREASTS)
					if(!(_arousal.get_organ_visibility(ORGAN_SLOT_PENIS) || is_chest_exposed(usr)))
						usr.visible_message(\
						"<span class='love'>[usr] starts rubbing [I] against [p_their] chest...</span>",
						"<span class='userlove'>You start to rub [I] against your breasts...</span>")
						_arousal.mb_cooldown = world.time
						if(do_after(usr, 6 SECONDS, usr))
							_arousal.mb_cooldown = world.time
							usr.visible_message(\
							"<span class='love'>[usr] rubs [I] against [p_their] chest.</span>",
							"<span class='userlove'>You rub [I] against your breasts from the outside of your clothing.</span>")
							massaged = TRUE
					else
						if(istype(I, /obj/item/soap))
							var/obj/item/soap/S = I
							usr.visible_message(\
							"<span class='love'>[usr] starts washing [p_their] breasts with [S]...</span>",
							"<span class='userlove'>You start washing your breasts with [S]...</span>")
							_arousal.mb_cooldown = world.time
							if(do_after(usr, S.cleanspeed * 1.5, usr))
								_arousal.mb_cooldown = world.time
								usr.wash(CLEAN_SCRUB)
								usr.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
								S.decreaseUses(usr)
								usr.visible_message(\
								"<span class='love'>[usr] cleans [p_their] breasts with [S].</span>",
								"<span class='userlove'>You clean your breasts with [S].</span>")
								massaged = TRUE
						else
							usr.visible_message(\
							"<span class='love'>[usr] starts rubbing [p_their] breasts with [I]...</span>",
							"<span class='userlove'>You start to rub [I] against your breasts...</span>")
							_arousal.mb_cooldown = world.time
							if(do_after(usr, 6 SECONDS, usr))
								_arousal.mb_cooldown = world.time
								var/obj/item/organ/genital/breasts/B
								if(iscarbon(usr))
									var/mob/living/carbon/C = usr
									B = C.getorganslot(ORGAN_SLOT_BREASTS)
									if(B.should_lactate())
										usr.visible_message(\
										"<span class='love'>[usr] rubs [p_their] breasts with [I], leaking some milk onto it.</span>",
										"<span class='userlove'You rub your breasts against [I], leaking some milk onto it in the process.</span>")
										massaged = TRUE
									else
										B = null
								if(!B)
									usr.visible_message(\
									"<span class='love'>[usr] rubs [p_their] breasts with [I].</span>",
									"<span class='userlove'>You rub your breasts against [I].</span>")
									massaged = TRUE
	//No item
	else
		switch(mode)
			if(INTERACT_PENIS)
				if(!_arousal.get_organ_visibility(ORGAN_SLOT_PENIS))
					usr.visible_message(\
					"<span class='love'>[usr] starts rubbing [p_their] crotch...</span>",
					"<span class='userlove'>You start rubbing your crotch area...</span>")
				else
					usr.visible_message(\
					"<span class='love'>[usr] starts rubbing [p_their] penis...</span>",
					"<span class='userlove'>You start rubbing your penis...</span>")
				_arousal.mb_cooldown = world.time
				if(do_after(usr, 6 SECONDS, usr, IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE))
					if(!_arousal.get_organ_visibility(ORGAN_SLOT_PENIS))
						usr.visible_message(\
						"<span class='love'>[usr] stops rubbing [p_their] crotch.</span>",
						"<span class='userlove'>You rub your penis, gainin pleasure.")
					else
						usr.visible_message(\
						"<span class='love'>[usr] rubs [p_their] penis.</span>",
						"<span class='userlove'>You rub your penis, gaining pleasure.</span>")
					massaged = TRUE
			if(INTERACT_BREASTS)
				if(!_arousal.get_organ_visibility(ORGAN_SLOT_BREASTS) && !is_chest_exposed(usr))
					usr.visible_message(\
					"<span class='love'>[usr] starts feeling up [p_their] breasts from the outside of [p_their] clothing...</span>",
					"<span class='userlove'>You begin to massage and wiggle your breasts from the outside of your clothes...</span>")
				else
					usr.visible_message(\
					"<span class='love'>[usr] rubs and massages [p_their] breasts...</span>",
					"<span class='userlove'>You beging to massage your breasts...</span>")
				_arousal.mb_cooldown = world.time
				if(do_after(usr, 6 SECONDS, usr, IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE))
					if(!_arousal.get_organ_visibility(ORGAN_SLOT_BREASTS) && !is_chest_exposed(usr))
						usr.visible_message(\
						"<span class='love'>[usr] finishes playing with [p_their] chest.</span>",
						"<span class='userlove'>You massage your breasts, gaining pleasure.</span>")
					else
						usr.visible_message(\
						"<span class='love'>[usr] finishes playing with [p_their] breasts.</span>",
						"<span class='userlove'>You massage your breasts, gaining pleasure.</span>")
					massaged = TRUE
	
	if(massaged)	//after ALLLLL that, adjust arousal and give mood bonus
		_arousal.mb_cooldown = world.time
		_arousal.adjustArousalLoss(8)
		SEND_SIGNAL(usr, COMSIG_ADD_MOOD_EVENT, AROUSAL, /datum/mood_event/pleasure_low)

/atom/movable/screen/arousal/proc/climax_in(mode, obj/item/target)
	if(!isobj(target))
		return
	
	switch(mode)
		if(INTERACT_PENIS)
			if(!_arousal.get_organ_visibility(ORGAN_SLOT_PENIS))
				to_chat(usr, "<span class='warning'>Your penis has to be visible to use that.</span>")
				return
			usr.visible_message(\
			"<span class='love'>[usr] begins stroking [usr.p_their()] penis over [target], ready to fill it up...</span>",
			"<span class='userlove'>You begin to massage your penis over [target], about to climax in it...</span>")
		if(INTERACT_TESTICLES)
			if(!_arousal.get_organ_visibility(ORGAN_SLOT_TESTICLES))
				to_chat(usr, "<span class='warning'>Your testicles have to be visible to massage them.</span>")
				return
			usr.visible_message(\
			"<span class='love'>[usr] begins massaging [usr.p_their()] testicles over [target], trying to leak into the container...</span>",
			"<span class='userlove'>You begin massaging your testicles over [target], ready to fill it slowly...</span>")
		if(INTERACT_BREASTS)
			if(!_arousal.get_organ_visibility(ORGAN_SLOT_BREASTS))
				to_chat(usr, "<span class='warning'>Your breasts have to be visible to massage them.</span>")
				return
			var/obj/item/organ/genital/breasts/breasts = _arousal.get_owner_organ(ORGAN_SLOT_BREASTS)
			if(!breasts.should_lactate())
				to_chat(usr, "<span class='warning'>Your breasts cannot lactate.</span>")
				return
			usr.visible_message(\
			"<span class=love'>[usr] squeezes [usr.p_their()] breasts over [target], trying to leak milk into the container...</span>",
			"<span class='userlove'>You begin squeezing your nipples over [target], trying to fill it up with your milk...</span>")
	_arousal.mb_cooldown = world.time
	if(do_after(usr, 6 SECONDS, usr))
		_arousal.mb_cooldown = world.time
		_arousal.climax_in(target, mode)
