/*
/datum/game_mode/proc/generate_station_locale_report()
	if(!SSticker.chosen_roundstart_event)
		return
	var/texty = SSticker.chosen_roundstart_event.generate_report_details()
	if(!texty)
		return
	return "<hr><b>Locale Divergencies for [station_name()]:</b><BR>[texty]<BR>"
*/
