/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"])
		switch(href_list["lookup_info"])
			if("genitals")
				var/list/line = list()
				for(var/genital in list("penis", "testicles", "vagina", "breasts"))
					if(!dna.species.mutant_bodyparts[genital])
						continue
					var/datum/sprite_accessory/genital/G = GLOB.sprite_accessories[genital][dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
					if(!G)
						continue
					if(G.is_hidden(src))
						continue
					var/obj/item/organ/genital/ORG = getorganslot(G.associated_organ_slot)
					if(!ORG)
						continue
					line += ORG.get_description_string(G)
				if(length(line))
					to_chat(usr, "<span class='notice'>[jointext(line, "\n")]</span>")
			if("flavor_text")
				if(length(dna.features["flavor_text"]))
					var/datum/browser/popup = new(usr, "[name]'s flavor text", "[name]'s Flavor Text", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s flavor text", replacetext(dna.features["flavor_text"], "\n", "<BR>")))
					popup.open()
					return

			if("ooc_prefs")
				if(client)
					var/str = "[src]'s OOC Notes : <br> <b>ERP :</b> [client.prefs.erp_pref] <b>| Non-Con :</b> [client.prefs.noncon_pref] <b>| Vore :</b> [client.prefs.vore_pref]"
					str += "<br>[html_encode(client.prefs.ooc_prefs)]"
					var/datum/browser/popup = new(usr, "[name]'s ooc info", "[name]'s OOC Information", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s OOC information", replacetext(str, "\n", "<BR>")))
					popup.open()
					return

			if("general_record")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s gen rec", "[name]'s General Record", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s general record", replacetext(client.prefs.general_record, "\n", "<BR>")))
					popup.open()
					return

			if("security_record")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s sec rec", "[name]'s Security Record", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s security record", replacetext(client.prefs.security_record, "\n", "<BR>")))
					popup.open()
					return

			if("medical_record")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s med rec", "[name]'s Medical Record", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s medical record", replacetext(client.prefs.medical_record, "\n", "<BR>")))
					popup.open()
					return

			if("background_info")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s flav bg", "[name]'s Background", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s background flavor", replacetext(client.prefs.background_info, "\n", "<BR>")))
					popup.open()
					return

			if("exploitable_info")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s exp info", "[name]'s Exploitable Info", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s exploitable information", replacetext(client.prefs.exploitable_info, "\n", "<BR>")))
					popup.open()
					return

/mob/living/carbon/human/species/synthliz
	race = /datum/species/robotic/synthliz

/mob/living/carbon/human/species/vox
	race = /datum/species/vox

/mob/living/carbon/human/species/ipc
	race = /datum/species/robotic/ipc

/mob/living/carbon/human/species/mammal
	race = /datum/species/mammal

/mob/living/carbon/human/species/podweak
	race = /datum/species/pod/podweak

/mob/living/carbon/human/species/xeno
	race = /datum/species/xeno

/mob/living/carbon/human/species/dwarf
	race = /datum/species/dwarf

/mob/living/carbon/human/species/roundstartslime
	race = /datum/species/jelly/roundstartslime

/mob/living/carbon/human/verb/toggle_undies()
	set category = "IC"
	set name = "Toggle underwear visibility"
	set desc = "Allows you to toggle which underwear should show or be hidden. Underwear will obscure genitals."

	if(stat != CONSCIOUS)
		to_chat(usr, "<span class='warning'>You can't toggle underwear visibility right now...</span>")
		return

	var/underwear_button = underwear_visibility & UNDERWEAR_HIDE_UNDIES ? "Show underwear" : "Hide underwear"
	var/undershirt_button = underwear_visibility & UNDERWEAR_HIDE_SHIRT ? "Show shirt" : "Hide shirt"
	var/socks_button = underwear_visibility & UNDERWEAR_HIDE_SOCKS ? "Show socks" : "Hide socks"
	var/list/choice_list = list("[underwear_button]" = 1,"[undershirt_button]" = 2,"[socks_button]" = 3,"Show all" = 4, "Hide all" = 5)
	var/picked_visibility = input(src, "Choose visibility setting", "Show/Hide underwear") as null|anything in choice_list
	if(picked_visibility)
		var/picked_choice = choice_list[picked_visibility]
		switch(picked_choice)
			if(1)
				underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
			if(2)
				underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
			if(3)
				underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
			if(4)
				underwear_visibility = NONE
			if(5)
				underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
		update_body()
	return

/mob/living/carbon/human/revive(full_heal = 0, admin_revive = 0)
	if(..())
		if(dna && dna.species)
			dna.species.spec_revival(src)

/mob/living/carbon/human/verb/toggle_mutant_part_visibility()
	set category = "IC"
	set name = "Show/Hide Mutant Parts"
	set desc = "Allows you to choose to try and hide your mutant bodyparts under your clothes."

	if(stat != CONSCIOUS)
		to_chat(usr, "<span class='warning'>You can't do this right now...</span>")
		return
	if(!try_hide_mutant_parts && !do_after(src, 3 SECONDS,target = src))
		return
	try_hide_mutant_parts = !try_hide_mutant_parts
	to_chat(usr, "<span class='notice'>[try_hide_mutant_parts ? "You try and hide your mutant body parts under your clothes." : "You no longer try and hide your mutant body parts"]</span>")
	update_mutant_bodyparts()

/mob/living/carbon/human/verb/acting()
	set category = "IC"
	set name = "Feign Impairment"
	set desc = "Slur, stutter or jitter for a short duration."

	if(stat != CONSCIOUS)
		to_chat(usr, "<span class='warning'>You can't do this right now...</span>")
		return

	var/list/choices = list("Drunkenness", "Stuttering", "Jittering")
	if(slurring >= 10 || stuttering >= 10 || jitteriness >= 10) //Give the option to end the impairment if there's one ongoing.
		var/disable = input(src, "Stop performing existing impairment?", "Impairments") as null|anything in choices
		if(disable)
			acting_expiry(disable)
			return

	var/impairment = input(src, "Select an impairment to perform:", "Impairments") as null|anything in choices
	if(!impairment)
		return

	var/duration = input(src, "Enter how long you will feign [impairment]. (1 - 60 seconds)", "Duration in seconds", 25) as num|null
	if(!isnum(duration))
		return
	if(duration > 60)
		to_chat(src, "Please choose a duration in seconds between 1 to 60.")
		return
	switch(impairment)
		if("Drunkenness")
			slurring = duration
		if("Stuttering")
			stuttering = duration
		if("Jittering")
			jitteriness = duration

	if(duration)
		addtimer(CALLBACK(src, .proc/acting_expiry, impairment), duration SECONDS)
		to_chat(src, "You are now feigning [impairment].")

/mob/living/carbon/human/proc/acting_expiry(var/impairment) //End only the impairment we're affected by.
	if(impairment)
		switch(impairment)
			if("Drunkenness")
				slurring = 0
			if("Stuttering")
				stuttering = 0
			if("Jittering")
				jitteriness = 0
		to_chat(src, "You are no longer feigning [impairment].")
