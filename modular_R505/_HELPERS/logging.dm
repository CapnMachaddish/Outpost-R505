/proc/log_arousal(text, mob/partner1, mob/partner2)
	var/to_send = "AROUSAL: [text]"
	if(partner1 || partner2)
		to_send += " ("
		if(partner1 && partner2)
			to_send += "[partner1.ckey], [partner2.ckey]"
		else if(partner1)
			to_send += "[partner1.ckey]"
		else
			to_send += "[partner2.ckey]"
		to_send += ")"
	WRITE_LOG(GLOB.world_game_log, to_send)
