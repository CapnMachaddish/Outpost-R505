// list('ckey' = handled_ticket_count)
GLOBAL_LIST_INIT(ticket_counter, list())

/proc/ticket_counter_add_handled(ckey, number)
	if(isnull(GLOB.ticket_counter[ckey]))
		GLOB.ticket_counter[ckey] = 0
	GLOB.ticket_counter[ckey]+= number
	sortTim(GLOB.ticket_counter, cmp=/proc/cmp_numeric_dsc, associative = TRUE)

/datum/admin_help_tickets/stat_entry()
	var/list/L = ..()
	L[++L.len] = list(null, null, null, null)
	L[++L.len] = list("Ticket statistics", null, null, null)
	L[++L.len] = list("Admin:", "Tickets handled:", null, null)

	for(var/ckey in GLOB.ticket_counter)
		//assumption, that there's no keys with empty values
		L[++L.len] = list("[ckey]", "[GLOB.ticket_counter[ckey]]", null, null)

	return L

/datum/admin_help
	var/previously_closed = FALSE

/datum/admin_help/Close(key_name = key_name_admin(usr), silent = FALSE)
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/datum/admin_help/Resolve(key_name = key_name_admin(usr), silent = FALSE)
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/datum/admin_help/Reject(key_name = key_name_admin(usr))
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/datum/admin_help/ICIssue(key_name = key_name_admin(usr))
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE
