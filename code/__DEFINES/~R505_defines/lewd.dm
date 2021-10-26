#define CLIMAX_PENIS 1
#define CLIMAX_VAGINA 2

#define INTERACT_PENIS 1
#define INTERACT_BREASTS 2
#define INTERACT_TESTICLES 3
#define INTERACT_VAGINA 4
#define INTERACT_CLITORIS 5

#define PARTNER_INTERACT_PENIS_PENIS 1		//frott
#define PARTNER_INTERACT_PENIS_VAGINA 2		//penetrating partner
#define PARTNER_INTERACT_VAGINA_PENIS 3		//getting penetrated
#define PARTNER_INTERACT_VAGINA_VAGINA 4	//frotting
#define PARTNER_INTERACT_IMPREGNATE_RECIEVING 5	//Getting belly
#define PARTNER_INTERACT_IMPREGNATE_GIVING 6	//Giving belly

#define PENIS_DEFAULT_PRODUCTIVITY		0.05
#define TESTICLE_DEFAULT_PRODUCTIVITY	0.45
#define BREASTS_DEFAULT_PRODUCTIVITY	0.4
#define VAGINA_DEFAULT_PRODUCTIVITY		0.27

#define DEFAULT_GENITAL_REAGENT_VOLUME 20

#define AROUSAL_MINIMUM 	0
#define AROUSAL_MAXIMUM 	100
#define AROUSAL_RATE		2
#define CLIMAX_COOLDOWN		4 SECONDS	//AKA cock clock
#define AROUSAL_TICKRATE	1625//Lower numbers will update arousal quicker
#define AROUSAL_ERECT		66	//The amount of arousalloss before genitals are defined as erect
#define AROUSAL_CHUB		40	//The amount genitals are defined as half-erect
#define AROUSAL_CLIMAX		30	//When you can begin to do some lewd actions like coom
#define AROUSAL		"arousal"

#define AROUSED_MESSAGE_CHANCE	5	//The chance per tick the mob will make a random message when fully erect
#define AROUSED_MESSAGES list("You feel a bit hot.", "You feel strong sexual urges.", "You feel in the mood.", "You're ready to go down on someone.")
#define AROUSED_MAX_MESSAGE_LENGTH	128	//todo

#define MINIMUM_CLIMAX_DECAL_VOLUME		3

#define TRAIT_NYMPHOMANIA	"nymphomania"
#define TRAIT_MASOCHISM		"masochism"
#define TRAIT_SADISM		"sadism"
#define TRAIT_BIMBO 		"bimbo"
#define TRAIT_NEVERBONER	"neverboner"
#define TRAIT_SOBSESSED		"sexual obsession"
#define APHRO_TRAIT			"aphro"				///traits gained by brain traumas, can be removed if the brain trauma is gone
#define LEWDQUIRK_TRAIT		"lewdquirks"		///traits gained by quirks, cannot be removed unless the quirk itself is gone
#define LEWDCHEM_TRAIT		"lewdchem"			///traits gained by chemicals, you get the idea

#define STRAPON_TRAIT 		"strapon"

//This is just for less typing, haddish
#define AROUSAL_VAR(varname, from)	var/datum/component/arousal/##varname = from.GetComponent(/datum/component/arousal)
