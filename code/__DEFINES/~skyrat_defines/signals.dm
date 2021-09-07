//Movable signals
///When someone talks into a radio
#define COMSIG_MOVABLE_RADIO_TALK_INTO "movable_radio_talk_into"				//from radio talk_into(): (obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)

//Mob signals
///Resting position for living mob updated
#define COMSIG_LIVING_UPDATED_RESTING "living_updated_resting" //from base of (/mob/living/proc/update_resting): (resting)
///Horror form bombastic flag
#define COMSIG_HORRORFORM_EXPLODE "horrorform_explode"
///Overlay for whitestuff
#define COMSIG_MOB_CUMFACED "mob_cumfaced" //from /datum/component/cumfaced/Initialize(), when you get covered in cum

//Gun signals
///When a gun is switched to automatic fire mode
#define COMSIG_GUN_AUTOFIRE_SELECTED "gun_autofire_selected"
///When a gun is switched off of automatic fire mode
#define COMSIG_GUN_AUTOFIRE_DESELECTED "gun_autofire_deselected"
///The gun needs to update the gun hud!
#define COMSIG_UPDATE_AMMO_HUD "update_ammo_hud"

/// Used by /obj/item/melee/hammer
#define COMSIG_BREACHING "breaching_signal_woop_woop"
///The gun has jammed.
#define COMSIG_GUN_JAMMED "gun_jammed"

//Mutant stuff
///When a mutant is cured of the virus
#define COMSIG_MUTANT_CURED "mutant_cured"

// Power signals
/// Sent when an obj/item calls item_use_power: (use_amount, user, check_only)
#define COMSIG_ITEM_POWER_USE "item_use_power"
	#define NO_COMPONENT NONE
	#define COMPONENT_POWER_SUCCESS (1<<0)
	#define COMPONENT_NO_CELL  (1<<1)
	#define COMPONENT_NO_CHARGE (1<<2)

// Health signals
/// /mob/living/proc/updatehealth()
#define COMSIG_MOB_RUN_ARMOR "mob_run_armor"
/// /mob/living/proc/adjustBruteLoss (amount)
#define COMSIG_MOB_LOSS_BRUTE "mob_loss_brute"
/// /mob/living/proc/adjustBurnLoss (amount)
#define COMSIG_MOB_LOSS_FIRE "mob_loss_fire"
/// /mob/living/proc/adjustCloneLoss (amount)
#define COMSIG_MOB_LOSS_CLONE "mob_loss_clone"
/// /mob/living/proc/adjustToxLoss (amount)
#define COMSIG_MOB_LOSS_TOX "mob_loss_tox"
////mob/living/proc/adjustOyxLoss (amount)
#define COMSIG_MOB_LOSS_OXY "mob_loss_oxy"
////mob/living/proc/adjustStaminaLoss (amount)
#define COMSIG_MOB_LOSS_STAMINA "mob_loss_stamina"
/// /mob/living/proc/adjustOrganLoss (slot, amount)
#define COMSIG_MOB_LOSS_ORGAN "mob_loss_organ"
///from base of /turf/handle_fall(): (mob/faller)
#define COMSIG_TURF_MOB_FALL "turf_mob_fall"
///from base of /obj/effect/abstract/liquid_turf/Initialize() (/obj/effect/abstract/liquid_turf/liquids)
#define COMSIG_TURF_LIQUIDS_CREATION "turf_liquids_creation"

// Firealarm signals
/// /obj/machinery/firealarm/proc/trigger_effects(manual = FALSE)
#define COMSIG_FIREALARM_TRIGGERED_ON "firealarm_triggered_on"
#define COMSIG_FIREALARM_TRIGGER_DOORS "firealarm_trigger_doors"
/// /obj/machinery/firealarm/proc/untrigger_effects()
#define COMSIG_FIREALARM_TRIGGERED_OFF "firealarm_triggered_off"
/// /obj/machinery/door/firedoor/proc/trigger_hot()
#define COMSIG_FIREDOOR_CLOSED_FIRE "firedoor_closed_fire"
