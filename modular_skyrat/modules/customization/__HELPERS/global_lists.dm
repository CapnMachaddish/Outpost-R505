/proc/make_skyrat_datum_references()
	make_sprite_accessory_references()
	make_body_marking_references()
	make_body_marking_set_references()
	make_body_marking_dna_block_references()
	make_loadout_references()
	make_augment_references()
	make_culture_references()
	//We're loading donators here because it's the least intrusive way modularly
	load_donators()
	load_veteran_players()

/proc/make_culture_references()
	for(var/path in subtypesof(/datum/cultural_info/culture))
		var/datum/cultural_info/L = path
		if(!initial(L.name))
			continue
		L = new path()
		GLOB.culture_cultures[path] = L
	for(var/path in subtypesof(/datum/cultural_info/location))
		var/datum/cultural_info/L = path
		if(!initial(L.name))
			continue
		L = new path()
		GLOB.culture_locations[path] = L
	for(var/path in subtypesof(/datum/cultural_info/faction))
		var/datum/cultural_info/L = path
		if(!initial(L.name))
			continue
		L = new path()
		GLOB.culture_factions[path] = L

/proc/make_sprite_accessory_references()
	// Here we build the global list for all accessories
	for(var/path in subtypesof(/datum/sprite_accessory))
		var/datum/sprite_accessory/P = path
		if(initial(P.key) && initial(P.name))
			P = new path()
			if(!GLOB.sprite_accessories[P.key])
				GLOB.sprite_accessories[P.key] = list()
			GLOB.sprite_accessories[P.key][P.name] = P
			if(P.genetic)
				if(!GLOB.dna_mutant_bodypart_blocks[P.key])
					GLOB.dna_mutant_bodypart_blocks[P.key] = GLOB.dna_total_feature_blocks+1
				if(!GLOB.genetic_accessories[P.key])
					GLOB.genetic_accessories[P.key] = list()
					GLOB.dna_total_feature_blocks += DNA_BLOCKS_PER_FEATURE
				GLOB.genetic_accessories[P.key] += P.name
			//TODO: Replace "generic" definitions with something better
			if(P.generic && !GLOB.generic_accessories[P.key])
				GLOB.generic_accessories[P.key] = P.generic

/proc/make_body_marking_references()
	// Here we build the global list for all body markings
	for(var/path in subtypesof(/datum/body_marking))
		var/datum/body_marking/BM = path
		if(initial(BM.name))
			BM = new path()
			GLOB.body_markings[BM.name] = BM
			//We go through all the possible affected bodyparts and a name reference where applicable
			for(var/marking_zone in GLOB.marking_zones)
				var/bitflag = GLOB.marking_zone_to_bitflag[marking_zone]
				if(BM.affected_bodyparts & bitflag)
					if(!GLOB.body_markings_per_limb[marking_zone])
						GLOB.body_markings_per_limb[marking_zone] = list()
					GLOB.body_markings_per_limb[marking_zone] += BM.name

/proc/make_body_marking_set_references()
	// Here we build the global list for all body markings sets
	for(var/path in subtypesof(/datum/body_marking_set))
		var/datum/body_marking_set/BM = path
		if(initial(BM.name))
			BM = new path()
			GLOB.body_marking_sets[BM.name] = BM

/proc/make_body_marking_dna_block_references()
	for(var/marking_zone in GLOB.marking_zones)
		GLOB.dna_body_marking_blocks[marking_zone] = GLOB.dna_total_feature_blocks+1
		GLOB.dna_total_feature_blocks += DNA_BLOCKS_PER_MARKING_ZONE

/proc/make_loadout_references()
	// Here we build the global loadout lists
	for(var/path in subtypesof(/datum/loadout_item))
		var/datum/loadout_item/L = path
		if(initial(L.path))
			L = new path()
			GLOB.loadout_items[L.path] = L
			if(!GLOB.loadout_category_to_subcategory_to_items[L.category])
				GLOB.loadout_category_to_subcategory_to_items[L.category] = list()
			if(!GLOB.loadout_category_to_subcategory_to_items[L.category][L.subcategory])
				GLOB.loadout_category_to_subcategory_to_items[L.category][L.subcategory] = list()
			GLOB.loadout_category_to_subcategory_to_items[L.category][L.subcategory] += L.path

/proc/make_augment_references()
	// Here we build the global loadout lists
	for(var/path in subtypesof(/datum/augment_item))
		var/datum/augment_item/L = path
		if(initial(L.path))
			L = new path()
			GLOB.augment_items[L.path] = L

			if(!GLOB.augment_slot_to_items[L.slot])
				GLOB.augment_slot_to_items[L.slot] = list()
				if(!GLOB.augment_categories_to_slots[L.category])
					GLOB.augment_categories_to_slots[L.category] = list()
				GLOB.augment_categories_to_slots[L.category] += L.slot
			GLOB.augment_slot_to_items[L.slot] += L.path
