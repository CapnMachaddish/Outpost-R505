//GLOBAL FILE FOR DECLARING CUSTOM ZLEVEL TRAITS

#define ZTRAIT_TRENCH_RUINS "Trench Ruins"
#define ZTRAIT_OCEAN_RUINS "Ocean Ruins"
#define ZTRAIT_OCEAN_RUINS_NEARSTATION "Nearstation Ocean Ruins"
#define ZTRAIT_OCEAN_STATION "Ocean Station" //If a station level has this, the SSmapping will try and spawn adjacent ocean levels

#define ZTRAITS_ROCKPLANET list(ZTRAIT_MINING = TRUE,ZTRAIT_ACIDRAIN = TRUE,ZTRAIT_ROCKPLANET_RUINS = TRUE,ZTRAIT_BOMBCAP_MULTIPLIER = 2,ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/lowpressure)

#define ZTRAITS_ICEMOONSKYRAT list(ZTRAIT_MINING = TRUE,ZTRAIT_SNOWSTORM = TRUE,ZTRAIT_ICE_RUINS = TRUE,ZTRAIT_ICE_RUINS_UNDERGROUND = TRUE,ZTRAIT_BOMBCAP_MULTIPLIER = 2,ZTRAIT_BASETURF = /turf/open/lava/plasma/ice_moon) //Remove ZTRAIT_ICE_RUINS if anyone makes multi-z icemoon ruins, as it'll cause problems here.

#define ZTRAITS_TIDALLOCK list(ZTRAIT_MINING = TRUE,ZTRAIT_ACIDRAIN = TRUE,ZTRAIT_LAVA_RUINS = TRUE,ZTRAIT_ICE_RUINS = TRUE,ZTRAIT_BOMBCAP_MULTIPLIER = 2,ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid)

#define ZTRAITS_OCEAN_LEVEL list(ZTRAIT_GRAVITY = TRUE,ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid,ZTRAIT_OCEAN_RUINS = TRUE)

#define ZTRAITS_TRENCH_LEVEL list(ZTRAIT_GRAVITY = TRUE,ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid,ZTRAIT_TRENCH_RUINS = TRUE)
