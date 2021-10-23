#define TRAIT_SWIMMING	"swimming"
#define POOL_FRIGID 1
#define POOL_COOL 2
#define POOL_NORMAL 3
#define POOL_WARM 4
#define POOL_SCALDING 5

GLOBAL_LIST_INIT(blacklisted_pool_reagents, list(
	/datum/reagent/toxin/plasma, /datum/reagent/oxygen, /datum/reagent/nitrous_oxide, /datum/reagent/nitrogen,		//gases
	/datum/reagent/drug/crocin, /datum/reagent/drug/hexacrocin, /datum/reagent/drug/dopamine, /datum/reagent/drug/camphor, //Lewd shit BEGONE!
	/datum/reagent/drug/pentacamphor, /datum/reagent/breast_enlarger, /datum/reagent/penis_enlarger, /datum/reagent/semen, //Lewd shit BEGONE! pt. 2
	/datum/reagent/femcum	//Lewd shit BEGONE! pt. 3
	))
