/datum/component/cleanable
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/icon/decal
	var/clean_flags

/datum/component/cleanable/Initialize(icon, icon_state, cut=FALSE, flags=CLEAN_TYPE_ACID)
	if(!icon_state && !icon)
		return COMPONENT_INCOMPATIBLE
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	var/atom/A = parent
	clean_flags = flags
	if(cut && !isturf(parent))
		decal = icon(A.icon, A.icon_state, frame=1)
		decal.Blend(icon(icon, icon_state), ICON_MULTIPLY)	//man
		A.add_overlay(decal)
	else
		decal = new/mutable_appearance(icon, icon_state)
		A.add_overlay(decal)

/datum/component/cleanable/RegisterWithParent()
	RegisterSignal(parent, list(COMSIG_COMPONENT_CLEAN_ACT, COMSIG_COMPONENT_CLEAN_FACE_ACT), .proc/clean_decal)

/datum/component/cleanable/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_COMPONENT_CLEAN_ACT, COMSIG_COMPONENT_CLEAN_FACE_ACT))

/datum/component/cleanable/proc/clean_decal(datum/source, clean_types)
	SIGNAL_HANDLER

	. = NONE
	if(clean_types & clean_flags)
		var/atom/A = parent
		A.cut_overlay(decal)
		qdel(src)
		return COMPONENT_CLEANED
