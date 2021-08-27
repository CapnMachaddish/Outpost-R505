/obj/machinery/light
	icon = 'modular_skyrat/modules/aesthetics/lights/icons/lighting.dmi'
	overlayicon = 'modular_skyrat/modules/aesthetics/lights/icons/lighting_overlay.dmi'
	var/maploaded = FALSE //So we don't have a lot of stress on startup.
	var/turning_on = FALSE //More stress stuff.
	var/constant_flickering = FALSE // Are we always flickering?
	var/flicker_timer = null
	var/roundstart_flicker = FALSE
	var/firealarm = FALSE

/obj/machinery/light/proc/turn_on(trigger, play_sound = TRUE)
	if(QDELETED(src))
		return
	turning_on = FALSE
	if(!on)
		return
	var/BR = brightness
	var/PO = bulb_power
	var/CO = bulb_colour
	if(color)
		CO = color
	if (firealarm)
		CO = bulb_emergency_colour
	else if (nightshift_enabled)
		BR = nightshift_brightness
		PO = nightshift_light_power
		if(!color)
			CO = nightshift_light_color
	var/matching = light && BR == light.light_range && PO == light.light_power && CO == light.light_color
	if(!matching)
		switchcount++
		if(rigged)
			if(status == LIGHT_OK && trigger)
				explode()
		else if( prob( min(60, (switchcount^2)*0.01) ) )
			if(trigger)
				burn_out()
		else
			use_power = ACTIVE_POWER_USE
			set_light(BR, PO, CO)
			playsound(src.loc, 'modular_R505/sound/machines/lightsOn.ogg', 65, 1)

/obj/machinery/light/proc/firealarm_on()
	SIGNAL_HANDLER

	firealarm = TRUE
	update()

/obj/machinery/light/proc/firealarm_off()
	SIGNAL_HANDLER

	firealarm = FALSE
	update()

/obj/machinery/light/Initialize(mapload = TRUE)
	. = ..()
	if(on)
		maploaded = TRUE

/obj/item/light/tube
	icon = 'modular_skyrat/modules/aesthetics/lights/icons/lighting.dmi'
