/*
Miauw's big Say() rewrite.
This file has the basic atom/movable level speech procs.
And the base of the send_speech() proc, which is the core of saycode.
*/
GLOBAL_LIST_INIT(freqtospan, list(
	"[FREQ_SCIENCE]" = "sciradio",
	"[FREQ_MEDICAL]" = "medradio",
	"[FREQ_ENGINEERING]" = "engradio",
	"[FREQ_SUPPLY]" = "suppradio",
	"[FREQ_SERVICE]" = "servradio",
	"[FREQ_SECURITY]" = "secradio",
	"[FREQ_COMMAND]" = "comradio",
	"[FREQ_AI_PRIVATE]" = "aiprivradio",
	"[FREQ_SYNDICATE]" = "syndradio",
	"[FREQ_CENTCOM]" = "centcomradio",
	"[FREQ_FACTION]" = "suppradio", //SKYRAT EDIT ADDITIION - FACTION
	"[FREQ_CYBERSUN]" = "syndradio", //SKYRAT EDIT ADDITION - MAPPING
	"[FREQ_INTERDYNE]" = "syndradio", //SKYRAT EDIT ADDITION - MAPPING
	"[FREQ_GUILD]" = "syndradio", //SKYRAT EDIT ADDITION - MAPPING
	"[FREQ_CTF_RED]" = "redteamradio",
	"[FREQ_CTF_BLUE]" = "blueteamradio",
	"[FREQ_CTF_GREEN]" = "greenteamradio",
	"[FREQ_CTF_YELLOW]" = "yellowteamradio"
	))

/atom/movable/proc/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(sanitize)
		message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_selected_language()
	send_speech(message, 7, src, , spans, message_language=language)

/atom/movable/proc/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args)

/atom/movable/proc/can_speak()
	//SHOULD_BE_PURE(TRUE)
	return TRUE

/atom/movable/proc/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language = null, list/message_mods = list())
	var/rendered = compose_message(src, message_language, message, , spans, message_mods)
	for(var/atom/movable/AM as anything in get_hearers_in_view(range, source))
		AM.Hear(rendered, src, message_language, message, , spans, message_mods)

/atom/movable/proc/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), face_name = FALSE)
	//This proc uses text() because it is faster than appending strings. Thanks BYOND.
	//Basic span
	var/spanpart1 = "<span class='[radio_freq ? get_radio_span(radio_freq) : "game say"]'>"
	//Start name span.
	var/spanpart2 = "<span class='name'>"
	//Radio freq/name display
	var/freqpart = radio_freq ? "\[[get_radio_name(radio_freq)]\] " : ""
	//Speaker name
	var/namepart = "[speaker.GetVoice()][speaker.get_alt_name()]"
	if(face_name && ishuman(speaker))
		var/mob/living/carbon/human/H = speaker
		namepart = "[H.get_face_name()]" //So "fake" speaking like in hallucinations does not give the speaker away if disguised
	//End name span.
	var/endspanpart = "</span>"

	//Message
	//SKYRAT EDIT CHANGE - EMOTES
	// var/messagepart = " <span class='message'>[lang_treat(speaker, message_language, raw_message, spans, message_mods)]</span></span>" - ORIGINAL
	var/messagepart = " <span class='message'>[say_emphasis(lang_treat(speaker, message_language, raw_message, spans, message_mods))]</span></span>"
	//SKYRAT EDIT END
	var/languageicon = ""
	var/datum/language/D = GLOB.language_datum_instances[message_language]
	if(istype(D) && D.display_icon(src))
		languageicon = "[D.get_icon()] "

	return "[spanpart1][spanpart2][freqpart][languageicon][compose_track_href(speaker, namepart)][namepart][compose_job(speaker, message_language, raw_message, radio_freq)][endspanpart][messagepart]"

/atom/movable/proc/compose_track_href(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/say_mod(input, message_mods) //SKYRAT custom sayverb old code: /atom/movable/proc/say_mod(input, list/message_mods = list())
	var/ending = copytext_char(input, -1)
	if(copytext_char(input, -2) == "!!")
		return verb_yell
	else if(message_mods[MODE_SING])
		. = verb_sing
	else if(ending == "?")
		return verb_ask
	else if(ending == "!")
		return verb_exclaim
	else
		return verb_say

/atom/movable/proc/say_quote(input, list/spans=list(speech_span), list/message_mods = list())
	if(!input)
		input = "..."

	if(copytext_char(input, -2) == "!!")
		spans |= SPAN_YELL

	var/spanned = attach_spans(input, spans)
	return "[say_mod(input, message_mods)][spanned ? ", \"[spanned]\"" : ""]"
//SKYRAT custom verb edit. [spanned ? ", \"[spanned]\"" : ""]"

//SKYRAT custom sayverb
/atom/movable/proc/quoteless_say_quote(input, list/spans = list(speech_span), message_mods)
	if((input[1] == "!") && (length_char(input) > 1))
		return ""
	var/pos = findtext(input, "*")
	return pos? copytext(input, pos + 1) : input
//SKYRAT custom sayverb end.

/atom/movable/proc/lang_treat(atom/movable/speaker, datum/language/language, raw_message, list/spans, list/message_mods = list(), no_quote = FALSE)
	if(has_language(language))
		var/atom/movable/AM = speaker.GetSource()
		if(AM) //Basically means "if the speaker is virtual"
			return no_quote ? AM.quoteless_say_quote(raw_message, spans, message_mods) : AM.say_quote(raw_message, spans, message_mods) //SKYRAT custom sayverb old code: return no_quote ? raw_message : AM.say_quote(raw_message, spans, message_mods)
		else
			return no_quote ? speaker.quoteless_say_quote(raw_message, spans, message_mods) : speaker.say_quote(raw_message, spans, message_mods) //SKYRAT custom sayverb old code: return no_quote ? raw_message : speaker.say_quote(raw_message, spans, message_mods)
	else if(language)
		var/atom/movable/AM = speaker.GetSource()
		var/datum/language/D = GLOB.language_datum_instances[language]
		raw_message = D.scramble(raw_message)
		if(AM)
			return no_quote ? AM.quoteless_say_quote(raw_message, spans, message_mods) : AM.say_quote(raw_message, spans, message_mods) //SKYRAT custom sayverb old code: return no_quote ? raw_message : AM.say_quote(raw_message, spans, message_mods)
		else
			return no_quote ? speaker.quoteless_say_quote(raw_message, spans, message_mods) : speaker.say_quote(raw_message, spans, message_mods) //SKYRAT custom sayverb old code: return no_quote ? raw_message : speaker.say_quote(raw_message, spans, message_mods)
	else
		return "makes a strange sound."

/proc/get_radio_span(freq)
	var/returntext = GLOB.freqtospan["[freq]"]
	if(returntext)
		return returntext
	return "radio"

/proc/get_radio_name(freq)
	var/returntext = GLOB.reverseradiochannels["[freq]"]
	if(returntext)
		return returntext
	return "[copytext_char("[freq]", 1, 4)].[copytext_char("[freq]", 4, 5)]"

//SKYRAT custom sayverb
/atom/movable/proc/attach_spans(input, list/spans)
	if((input[1] == "!") && (length(input) > 2))
		return
	var/customsayverb = findtext(input, "*")
	if(customsayverb)
		input = capitalize(copytext(input, customsayverb + length(input[customsayverb])))
	if(input)
		return "[message_spans_start(spans)][input]</span>"
	else
		return
//SKYRAT custom sayverb end.
/* Old code:
/proc/attach_spans(input, list/spans)
	return "[message_spans_start(spans)][input]</span>"
*/

/proc/message_spans_start(list/spans)
	var/output = "<span class='"
	for(var/S in spans)
		output = "[output][S] "
	output = "[output]'>"
	return output

/proc/say_test(text)
	var/ending = copytext_char(text, -1)
	if (ending == "?")
		return "1"
	else if (ending == "!")
		return "2"
	return "0"

/atom/movable/proc/GetVoice()
	return "[src]" //Returns the atom's name, prepended with 'The' if it's not a proper noun

/atom/movable/proc/IsVocal()
	return 1

/atom/movable/proc/get_alt_name()

//HACKY VIRTUALSPEAKER STUFF BEYOND THIS POINT
//these exist mostly to deal with the AIs hrefs and job stuff.

/atom/movable/proc/GetJob() //Get a job, you lazy butte

/atom/movable/proc/GetSource()

/atom/movable/proc/GetRadio()

//VIRTUALSPEAKERS
/atom/movable/virtualspeaker
	var/job
	var/atom/movable/source
	var/obj/item/radio/radio

INITIALIZE_IMMEDIATE(/atom/movable/virtualspeaker)
/atom/movable/virtualspeaker/Initialize(mapload, atom/movable/M, _radio)
	. = ..()
	radio = _radio
	source = M
	if(istype(M))
		name = radio.anonymize ? "Unknown" : M.GetVoice()
		verb_say = M.verb_say
		verb_ask = M.verb_ask
		verb_exclaim = M.verb_exclaim
		verb_yell = M.verb_yell

	// The mob's job identity
	if(ishuman(M))
		// Humans use their job as seen on the crew manifest. This is so the AI
		// can know their job even if they don't carry an ID.
		var/datum/data/record/findjob = find_record("name", name, GLOB.data_core.general)
		if(findjob)
			job = findjob.fields["rank"]
		else
			job = "Unknown"
	else if(iscarbon(M))  // Carbon nonhuman
		job = "No ID"
	else if(isAI(M))  // AI
		job = "AI"
	else if(iscyborg(M))  // Cyborg
		var/mob/living/silicon/robot/B = M
		job = "[B.designation] Cyborg"
	else if(istype(M, /mob/living/silicon/pai))  // Personal AI (pAI)
		job = "Personal AI"
	else if(isobj(M))  // Cold, emotionless machines
		job = "Machine"
	else  // Unidentifiable mob
		job = "Unknown"

/atom/movable/virtualspeaker/GetJob()
	return job

/atom/movable/virtualspeaker/GetSource()
	return source

/atom/movable/virtualspeaker/GetRadio()
	return radio
