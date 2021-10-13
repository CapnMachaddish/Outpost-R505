// Modular Booze REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/ethanol/whiskey
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //let's not force the detective to change his alcohol brand

// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/reagent/consumable/ethanol/synthanol
	name = "Synthanol"
	description = "A runny liquid with conductive capacities. Its effects on synthetics are similar to those of alcohol on organics."
	color = "#1BB1FF"
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	boozepwr = 50
	quality = DRINK_NICE
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi' // This should cover anything synthanol related. Will have to individually tag others unless we make an object path for skyrat drinks.
	glass_icon_state = "synthanolglass"
	glass_name = "Glass of Synthanol"
	glass_desc = "The equivalent of alcohol for synthetic crewmembers. They'd find it awful if they had tastebuds too."
	taste_description = "motor oil"

/datum/reagent/consumable/ethanol/synthanol/on_mob_life(mob/living/carbon/C)
	if(!(C.mob_biotypes & MOB_ROBOTIC))
		C.reagents.remove_reagent(type, 3.6) //gets removed from organics very fast
		if(prob(25))
			C.vomit(5, FALSE, FALSE)
	return ..()

/datum/reagent/consumable/ethanol/synthanol/expose_mob(mob/living/carbon/C, method=TOUCH, volume)
	. = ..()
	if(C.mob_biotypes & MOB_ROBOTIC)
		return
	if(method == INGEST)
		to_chat(C, pick("<span class = 'danger'>That was awful!</span>", "<span class = 'danger'>That was disgusting!</span>"))

/datum/reagent/consumable/ethanol/synthanol/robottears
	name = "Robot Tears"
	description = "An oily substance that an IPC could technically consider a 'drink'."
	color = "#363636"
	boozepwr = 25
	glass_icon_state = "robottearsglass"
	glass_name = "Glass of Robot Tears"
	glass_desc = "No robots were hurt in the making of this drink."
	taste_description = "existential angst"

/datum/reagent/consumable/ethanol/synthanol/trinary
	name = "Trinary"
	description = "A fruit drink meant only for synthetics, however that works."
	color = "#ADB21f"
	boozepwr = 20
	glass_icon_state = "trinaryglass"
	glass_name = "Glass of Trinary"
	glass_desc = "Colorful drink made for synthetic crewmembers. It doesn't seem like it would taste well."
	taste_description = "modem static"

/datum/reagent/consumable/ethanol/synthanol/servo
	name = "Servo"
	description = "A drink containing some organic ingredients, but meant only for synthetics."
	color = "#5B3210"
	boozepwr = 25
	glass_icon_state = "servoglass"
	glass_name = "Glass of Servo"
	glass_desc = "Chocolate - based drink made for IPCs. Not sure if anyone's actually tried out the recipe."
	taste_description = "motor oil and cocoa"

/datum/reagent/consumable/ethanol/synthanol/uplink
	name = "Uplink"
	description = "A potent mix of alcohol and synthanol. Will only work on synthetics."
	color = "#E7AE04"
	boozepwr = 15
	glass_icon_state = "uplinkglass"
	glass_name = "Glass of Uplink"
	glass_desc = "An exquisite mix of the finest liquoirs and synthanol. Meant only for synthetics."
	taste_description = "a GUI in visual basic"

/datum/reagent/consumable/ethanol/synthanol/synthncoke
	name = "Synth 'n Coke"
	description = "The classic drink adjusted for a robot's tastes."
	color = "#7204E7"
	boozepwr = 25
	glass_icon_state = "synthncokeglass"
	glass_name = "Glass of Synth 'n Coke"
	glass_desc = "Classic drink altered to fit the tastes of a robot, contains de-rustifying properties. Bad idea to drink if you're made of carbon."
	taste_description = "fizzy motor oil"

/datum/reagent/consumable/ethanol/synthanol/synthignon
	name = "Synthignon"
	description = "Someone mixed wine and alcohol for robots. Hope you're proud of yourself."
	color = "#D004E7"
	boozepwr = 25
	glass_icon_state = "synthignonglass"
	glass_name = "Glass of Synthignon"
	glass_desc = "Someone mixed good wine and robot booze. Romantic, but atrocious."
	taste_description = "fancy motor oil"

// Other Booze

/datum/reagent/consumable/ethanol/gunfire
	name = "Gunfire"
	description = "A drink that tastes like tiny explosions."
	color = "#e4830d"
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "tiny explosions"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "gunfire"
	glass_name = "Gunfire"
	glass_desc = "It pops constantly as you look at it, giving off tiny sparks."

/datum/reagent/consumable/ethanol/gunfire/on_mob_life(mob/living/carbon/M)
	if (prob(3))
		to_chat(M,"<span class='notice'>You feel the gunfire pop in your mouth.</span>")
	return ..()

/datum/reagent/consumable/ethanol/hellfire
	name = "Hellfire"
	description = "A nice drink that isn't quite as hot as it looks."
	color = "#fb2203"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "cold flames that lick at the top of your mouth"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "hellfire"
	glass_name = "Hellfire"
	glass_desc = "An amber colored drink that isn't quite as hot as it looks."

/datum/reagent/consumable/ethanol/hellfire/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL + 30)
	return ..()

/datum/reagent/consumable/ethanol/sins_delight
	name = "Sin's Delight"
	description = "The drink smells like the seven sins."
	color = "#330000"
	boozepwr = 66
	quality = DRINK_FANTASTIC
	taste_description = "overpowering sweetness with a touch of sourness, followed by iron and the sensation of a warm summer breeze"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "sins_delight"
	glass_name = "Sin's Delight"
	glass_desc = "You can smell the seven sins rolling off the top of the glass."

/datum/reagent/consumable/ethanol/strawberry_daiquiri
	name = "Strawberry Daiquiri"
	description = "Pink looking alcoholic drink."
	boozepwr = 20
	color = "#FF4A74"
	quality = DRINK_NICE
	taste_description = "sweet strawberry, lime and the ocean breeze"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "strawberry_daiquiri"
	glass_name = "Strawberry Daiquiri"
	glass_desc = "Pink looking drink with flowers and a big straw to sip it. Looks sweet and refreshing, perfect for warm days."

/datum/reagent/consumable/ethanol/liz_fizz
	name = "Liz Fizz"
	description = "Triple citrus layered with some ice and cream."
	boozepwr = 0
	color = "#D8FF59"
	taste_description = "brain freezing sourness"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "liz_fizz"
	glass_name = "Liz Fizz"
	glass_desc = "Looks like a citrus sherbet seperated in layers? Why would anyone want that is beyond you."

/datum/reagent/consumable/ethanol/miami_vice
	name = "Miami Vice"
	description = "A drink layering Pina Colada and Strawberry Daiquiri"
	boozepwr = 30
	color = "#D8FF59"
	quality = DRINK_FANTASTIC
	taste_description = "sweet and refreshing flavor, complemented with strawberries and coconut, and hints of citrus"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "miami_vice"
	glass_name = "Miami Vice"
	glass_desc = "Strawberries and coconut, like yin and yang."

/datum/reagent/consumable/ethanol/malibu_sunset
	name = "Malibu Sunset"
	description = "A drink consisting of creme de coconut and tropical juices"
	boozepwr = 20
	color = "#FF9473"
	quality = DRINK_NICE
	taste_description = "coconut, with orange and grenadine accents"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "malibu_sunset"
	glass_name = "Malibu Sunset"
	glass_desc = "Tropical looking drinks, with ice cubes hovering on the surface and grenadine coloring the bottom."

/datum/reagent/consumable/ethanol/hotlime_miami
	name = "Hotlime Miami"
	description = "The essence of the 90's, if they were a bloody mess that is."
	boozepwr = 40
	color = "#A7FAE8"
	quality = DRINK_FANTASTIC
	taste_description = "coconut and aesthetic violence"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "hotlime_miami"
	glass_name = "Hotlime Miami"
	glass_desc = "This looks very aesthetically pleasing."

/datum/reagent/consumable/ethanol/hotlime_miami/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(50)
	M.adjustStaminaLoss(-2)
	return ..()

/datum/reagent/consumable/ethanol/coggrog
	name = "Cog Grog"
	description = "Now you can fill yourself with the power of Ratvar!"
	color = rgb(255, 201, 49)
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "a brass taste with a hint of oil"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "coggrog"
	glass_name = "Cog Grog"
	glass_desc = "Not even Ratvar's Four Generals could withstand this!  Qevax Jryy!"

/datum/reagent/consumable/ethanol/badtouch
	name = "Bad Touch"
	description = "A sour and vintage drink. Some say the inventor gets slapped a lot."
	color = rgb(31, 181, 99)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "a slap to the face"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "badtouch"
	glass_name = "Bad Touch"
	glass_desc = "We're nothing but mammals after all."

/datum/reagent/consumable/ethanol/marsblast
	name = "Marsblast"
	description = "A spicy and manly drink in honor of the first colonists on Mars."
	color = rgb(246, 143, 55)
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "hot red sand"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "marsblast"
	glass_name = "Marsblast"
	glass_desc = "One of these is enough to leave your face as red as the planet."

/datum/reagent/consumable/ethanol/mercuryblast
	name = "Mercuryblast"
	description = "A sour burningly cold drink that's sure to chill the drinker."
	color = rgb(29, 148, 213)
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "chills down your spine"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "mercuryblast"
	glass_name = "Mercuryblast"
	glass_desc = "No thermometers were harmed in the creation of this drink"

/datum/reagent/consumable/ethanol/mercuryblast/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-30 * TEMPERATURE_DAMAGE_COEFFICIENT, T0C)
	return ..()

/datum/reagent/consumable/ethanol/piledriver
	name = "Piledriver"
	description = "A bright drink that leaves you with a burning sensation."
	color = rgb(241, 146, 59)
	boozepwr = 45
	quality = DRINK_NICE
	taste_description = "a fire in your throat"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "piledriver"
	glass_name = "Piledriver"
	glass_desc = "Not the only thing to leave your throat sore."

/datum/reagent/consumable/ethanol/zenstar
	name = "Zen Star"
	description = "A sour and bland drink, rather dissapointing."
	color = rgb(51, 87, 203)
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "dissapointment"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "zenstar"
	glass_name = "Zen Star"
	glass_desc = "You'd think something so balanced would actually taste nice... you'd be dead wrong."

// RACE SPECIFIC DRINKS

/datum/reagent/consumable/ethanol/coldscales
	name = "Coldscales"
	color = "#5AEB52" //(90, 235, 82)
	description = "A cold looking drink made for people with scales."
	boozepwr = 50 //strong!
	taste_description = "minty mushrooms" //R505 Edit Start (ends at frisky kitty)
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "coldscales"
	glass_name = "Coldscales"
	glass_desc = "I can't believe it's not Leporazine!"
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/coldscales/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(islizard(M))
		M.adjust_bodytemperature(-5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * delta_time, M.get_body_temp_normal())
		M.adjust_bodytemperature(25 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * delta_time, 0, M.get_body_temp_normal())
		return ..()

/datum/reagent/consumable/ethanol/oil_drum
	name = "Oil Drum"
	color = "#000000" //(0, 0, 0)
	description = "Industrial grade oil mixed with some ethanol to make it a drink. Somehow not known to be toxic."
	boozepwr = 45
	taste_description = "an oil spill"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "oil_drum"
	glass_name = "Oil Drum"
	glass_desc = "You can feel the penguins dying in your hands."
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/oil_drum/on_mob_metabolize(mob/living/L)
	if(L.mob_biotypes & (MOB_ROBOTIC))
		..()
		L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)
		return ..()

/datum/reagent/consumable/ethanol/oil_drum/on_mob_end_metabolize(mob/living/L)
	if(L.mob_biotypes & (MOB_ROBOTIC))
		L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)
		..()	
		return ..()

/datum/reagent/consumable/ethanol/nord_king
	name = "Nordic King"
	color = "#EB1010" //(235, 16, 16)
	description = "Strong mead mixed with even more honey and ethanol. Beloved by its human patrons."
	boozepwr = 50 //strong!
	taste_description = "honey and red wine"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "nord_king"
	glass_name = "Nordic King"
	glass_desc = "Red mead mixed in a mountainside. Magnificent."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/nord_king/on_mob_metabolize(mob/living/M)
	if(ishumanbasic(M) || isdwarf(M))
		to_chat(M, span_notice("I am a dwarf and I'm digging a hole..."))
		boozepwr = 25 // you're used to it.

/datum/reagent/consumable/ethanol/nord_king/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(ishumanbasic(M) || isdwarf(M))
		M.adjustBruteLoss(-1.5 * REM * delta_time)
		M.adjustFireLoss(-1.5 * REM * delta_time)
		return ..()

/datum/reagent/consumable/ethanol/velvet_kiss
	name = "Velvet Kiss"
	color = "#EB1010" //(235, 16, 16)
	description = "A bloody wine, supposedly very unholy."
	boozepwr = 10 //weak
	taste_description = "tart hemoglobin"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "velvet_kiss"
	glass_name = "Velvet Kiss"
	glass_desc = "A blood-red drink for the more bloodthirsty undead in your (un)life."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/velvet_kiss/on_mob_metabolize(mob/living/M)
	if(iszombie(M) || isvampire(M) || isdullahan(M)) 
		to_chat(M, span_notice("The Blood Moon is rising..."))

/datum/reagent/consumable/ethanol/velvet_kiss/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(iszombie(M) || isvampire(M) || isdullahan(M)) //Rare races!
		holder.remove_reagent(/datum/reagent/water/holywater, 1 * REM * delta_time)
		holder.remove_reagent(/datum/reagent/consumable/garlic, 2 * REM * delta_time)
		M.adjustFireLoss(-2 * REM * delta_time)
		return ..()

/datum/reagent/consumable/ethanol/abduction_fruit
	name = "Abduction Fruit"
	color = "#DEFACD" //(222, 250, 205)
	description = "A strange blend of juices with an alien taste."
	boozepwr = 80 //Strong
	taste_description = "something out of this world"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "abduction_fruit"
	glass_name = "Abduction Fruit"
	glass_desc = "Mixed fruits that were never meant to be mixed..."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/abduction_fruit/on_mob_metabolize(mob/living/L)
	if(isabductor(L) || isxenohybrid(L))
		..()
		ADD_TRAIT(L, TRAIT_FASTMED, type)
		ADD_TRAIT(L, TRAIT_QUICK_CARRY, type)

/datum/reagent/consumable/ethanol/abduction_fruit/on_mob_end_metabolize(mob/living/L)
	if(isabductor(L) || isxenohybrid(L))
		REMOVE_TRAIT(L, TRAIT_FASTMED, type)
		REMOVE_TRAIT(L, TRAIT_QUICK_CARRY, type)
		..()

/datum/reagent/consumable/ethanol/bug_zapper
	name = "Bug Zapper"
	color = "#F5882A" //(222, 250, 205)
	description = "Copper and lemon juice. Hardly even a drink."
	boozepwr = 5 //No booze really
	taste_description = "a metallic tingle"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "bug_zapper"
	glass_name = "Bug Zapper"
	glass_desc = "Electrifying."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/bug_zapper/on_mob_metabolize(mob/living/L)
	if(isinsect(L) || isflyperson(L) || ismoth(L))
		..()
		L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
		ADD_TRAIT(L, TRAIT_NUMBED, src)
		L.throw_alert("numbed", /atom/movable/screen/alert/numbed)

/datum/reagent/consumable/ethanol/bug_zapper/on_mob_end_metabolize(mob/living/L)
	if(isinsect(L) || isflyperson(L) || ismoth(L))
		L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
		REMOVE_TRAIT(L, TRAIT_NUMBED, src)
		L.clear_alert("numbed")
		..()

/datum/reagent/consumable/ethanol/bug_zapper/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(isinsect(M) || isflyperson(M) || ismoth(M))
		M.set_drugginess(30 * REM * delta_time)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
		return ..()

/datum/reagent/consumable/ethanol/mush_crush
	name = "Mush Crush"
	color = "#F5882A" //(222, 250, 205)
	description = "Soil in a glass, decorated with a Destroying Angel fungi."
	boozepwr = 5 //No booze really
	taste_description = "enriched soil"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "mush_crush"
	glass_name = "Mush Crush"
	glass_desc = "Mushroom! We're rich!"
	quality = RACE_DRINK
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/mush_crush/on_mob_metabolize(mob/living/M)
	if(ispodperson(M))
		to_chat(M, span_notice("You feel bioluminescence spread through your body!"))
		light_holder = new(M)
		light_holder.set_light(4, 0.9, "#C5FFC2")

/datum/reagent/consumable/ethanol/mush_crush/on_mob_end_metabolize(mob/living/M)
	if(ispodperson(M))
		to_chat(M, span_notice("The glow in your body fades."))
		QDEL_NULL(light_holder)

/datum/reagent/consumable/ethanol/mush_crush/on_mob_life(mob/living/carbon/M)
	if(ispodperson(M))
		if(QDELETED(light_holder))
			holder.del_reagent(type)
		else if(light_holder.loc != M)
			light_holder.forceMove(M)
		return ..()

/datum/reagent/consumable/ethanol/hollow_bone
	name = "Hollow Bone"
	color = "#FCF7D4" //(252, 247, 212)
	description = "A shockingly harmless mix of bone toxins and milk."
	boozepwr = 15
	taste_description = "creamy marrow"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "hollow_bone"
	glass_name = "Hollow Bone"
	glass_desc = "A bone-chilling drink sure to spook ya!"
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/velvet_kiss/on_mob_metabolize(mob/living/M)
	if(isplasmaman(M) || isskeleton(M))
		to_chat(M, span_notice("On days like these, boneheads like you should be having a good time."))

/datum/reagent/consumable/ethanol/hollow_bone/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(isplasmaman(M) || isskeleton(M))
		holder.remove_reagent(/datum/reagent/toxin/bonehurtingjuice, 2 * REM * delta_time)
		M.adjustBruteLoss(-2 * REM * delta_time)
		return ..()

/datum/reagent/consumable/ethanol/jell_wyrm
	name = "Jell Wyrm"
	color = "#FF6200" //(255, 98, 0)
	description = "Horrible mix of Co2, toxins and heat. Meant for slime based life."
	boozepwr = 40
	taste_description = "a tropical sea"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "jell_wyrm"
	glass_name = "Jell Wyrm"
	glass_desc = "A bubbly drink that makes you feel like melting into a puddle."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/jell_wyrm/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(isjellyperson(M) || isslimeperson(M) || isluminescent(M))
		M.adjustBruteLoss(-0.5 * REM * delta_time, 0)
		M.adjustFireLoss(-0.5 * REM * delta_time, 0)
		M.adjustOxyLoss(-0.5 * REM * delta_time, 0)
		M.adjustToxLoss(-0.5 * REM * delta_time, 0, TRUE)
		return ..()

/datum/reagent/consumable/ethanol/laval_spit //Yes Laval
	name = "Laval Spit"
	color = "#DE3009" //(222, 48, 9)
	description = "Heat minerals and some mauna loa. Meant for rock based life."
	boozepwr = 30
	taste_description = "exotic minerals"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "laval_spit"
	glass_name = "Laval Spit"
	glass_desc = "A piping hot drink for those who can stomach the heat of lava."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/laval_spit/on_mob_metabolize(mob/living/L)
	if(isgolem(L))
		..()
		L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)
		return ..()

/datum/reagent/consumable/ethanol/laval_spit/on_mob_end_metabolize(mob/living/L)
	if(isgolem(L))
		L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)
		..()	
		return ..()

/datum/reagent/consumable/ethanol/laval_spit/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(isgolem(M))
		M.adjustBruteLoss(-2 * REM * delta_time, 0)
		return ..()

/datum/reagent/consumable/ethanol/frisky_kitty
	name = "Frisky Kitty"
	color = "#FCF7D4" //(252, 247, 212)
	description = "Warm milk mixed with catnip."
	boozepwr = 0
	taste_description = "creamy catnip"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "frisky_kitty"
	glass_name = "Frisky Kitty"
	glass_desc = "A warm drink bound to awaken the predator within."
	quality = RACE_DRINK

/datum/reagent/consumable/ethanol/frisky_kitty/on_mob_metabolize(mob/living/L)
	if(ismammal(L) || isfelinid(L))
		..()
		ADD_TRAIT(L, TRAIT_PERFECT_ATTACKER, type)

/datum/reagent/consumable/ethanol/frisky_kitty/on_mob_end_metabolize(mob/living/L)
	if(ismammal(L) || isfelinid(L))
		REMOVE_TRAIT(L, TRAIT_PERFECT_ATTACKER, type)
		..()

/datum/reagent/consumable/ethanol/frisky_kitty/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(ismammal(M) || isfelinid(M))
		M.adjustToxLoss(-2 * REM * delta_time, 0)
		M.adjustBruteLoss(-2 * REM * delta_time, 0)
		return ..() //R505 Edit End (starts at coldscales)

/datum/reagent/consumable/ethanol/appletini
	name = "Appletini"
	color = "#9bd1a9" //(155, 209, 169)
	description = "The electric-green appley beverage nobody can turn down!"
	boozepwr = 50
	taste_description = "Sweet and green"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "appletini"
	glass_name = "glass of Appletini"
	glass_desc = "An appley beverage in a martini glass"

/datum/reagent/consumable/ethanol/quadruple_sec/cityofsin //making this a subtype was some REAL JANK, but it saves me a headache, and it looks good!
	name = "City of Sin"
	color = "#eb9378" //(235, 147, 120)
	description = "A smooth, fancy drink for people of ill repute"
	boozepwr = 70
	taste_description = "Your own sins"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "cityofsin"
	glass_name = "glass of City of Sin"
	glass_desc = "Looking at it makes you recall every mistake you’ve made."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
