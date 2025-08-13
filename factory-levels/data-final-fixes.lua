if mods["omnimatter"] then
	log("Omnimatter detected, adding omnitractor")

	omnimatter_crusher_levels = {
		type = "assembling-machine",
		tiers = 2,
		base_machine_names = { "burner-omnitractor", "omnitractor-1" },
		base_level_tints = {
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 }
		},
		level_tint_multipliers = {
			{ r = 0, g = -0.032, b = -0.032 },
			{ r = 0, g = -0.008, b = -0.008 }
		},
		levels = { 10, 25 },
		base_speeds = { 1, 2 },
		speed_multipliers = { 0.04, 0.04 },
		quality_multipliers = { 0.04, 0.04 },
		base_consumption = { 75, 100 },
		consumption_multipliers = { 1, 2 },
		consumption_unit = { "kW", "kW" },
		base_pollution = { 2, 4 },
		pollution_multipliers = { 0.04, 0.12 },
		base_productivity = { 0, 0 },
		productivity_multipliers = { 0.002, 0.002 },
		levels_per_module_slots = { 25, 25 },
		base_module_slots = { 0, 1 },
		bonus_module_slots = { 0, 1 }
	}

	factory_levels.create_leveled_machines(omnimatter_crusher_levels)
end

factory_levels.fix_productivity(assembling_machine_levels)
factory_levels.fix_productivity(oil_refinery_levels)
factory_levels.fix_productivity(chemical_plant_levels)
factory_levels.fix_productivity(centrifuge_levels)
factory_levels.fix_productivity(burner_furnace_levels)
factory_levels.fix_productivity(electric_furnace_levels)

factory_levels.convert_furnace_to_assembling_machines(burner_furnace_levels)
factory_levels.convert_furnace_to_assembling_machines(electric_furnace_levels)