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

if mods["ev-refining"] then
	ev_refining_crusher_levels = {
		type = "assembling-machine",
		tiers = 3,
		base_machine_names = { "crusher1", "crusher2", "crusher3" },
		base_level_tints = {
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 }
		},
		level_tint_multipliers = {
			{ r = 0, g = -0.02, b = -0.02 },
			{ r = 0, g = -0.01, b = -0.01 },
			{ r = 0, g = -0.005, b = -0.005 }
		},
		levels = { 25, 50, 100 },
		base_speeds = { 1, 2, 3 },
		speed_multipliers = { 0.04, 0.02, 0.03 },
		base_consumption = { 103, 207, 517 },
		consumption_multipliers = { 4.16, 6.2, 5.17 },
		consumption_unit = { "kW", "kW", "kW" },
		base_pollution = { 4, 3, 2 },
		pollution_multipliers = { 0.04, 0.03, 0.2 },
		base_productivity = { 0, 0, 0 },
		productivity_multipliers = { 0.0025, 0.0025, 0.0025 },
		quality_multipliers = { 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 20, 20, 25 },
		base_module_slots = { 1, 2, 4 },
		bonus_module_slots = { 1, 1, 1 }
	}

	ev_refining_echamber_levels = {
		type = "assembling-machine",
		tiers = 3,
		base_machine_names = { "echamber1", "echamber2", "echamber3" },
		base_level_tints = {
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 }
		},
		level_tint_multipliers = {
			{ r = 0, g = -0.02, b = -0.02 },
			{ r = 0, g = -0.01, b = -0.01 },
			{ r = 0, g = -0.005, b = -0.005 }
		},
		levels = { 25, 50, 100 },
		base_speeds = { 1, 2, 3 },
		speed_multipliers = { 0.04, 0.02, 0.03 },
		base_consumption = { 336, 413, 1030 },
		consumption_multipliers = { 3.08, 12.34, 10.3 },
		consumption_unit = { "kW", "kW", "kW" },
		base_pollution = { 3, 2, 1 },
		pollution_multipliers = { 0.04, 0.03, 0.2 },
		base_productivity = { 0, 0, 0 },
		productivity_multipliers = { 0.0025, 0.0025, 0.0025 },
		quality_multipliers = { 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 20, 20, 25 },
		base_module_slots = { 2, 2, 4 },
		bonus_module_slots = { 1, 1, 1 }
	}

	ev_refining_pchamber_levels = {
		type = "assembling-machine",
		tiers = 2,
		base_machine_names = { "pchamber1", "pchamber2" },
		base_level_tints = {
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 }
		},
		level_tint_multipliers = {
			{ r = 0, g = -0.01, b = -0.01 },
			{ r = 0, g = -0.005, b = -0.005 }
		},
		levels = { 50, 100 },
		base_speeds = { 1, 2 },
		speed_multipliers = { 0.02, 0.02 },
		base_consumption = { 775, 2070 },
		consumption_multipliers = { 25.9, 20.7 },
		consumption_unit = { "kW", "kW", "kW" },
		base_pollution = { 4, 2 },
		pollution_multipliers = { 0.04, 0.02 },
		base_productivity = { 0, 0 },
		productivity_multipliers = { 0.0025, 0.0025 },
		quality_multipliers = { 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 20, 25 },
		base_module_slots = { 2, 4 },
		bonus_module_slots = { 1, 1 }
	}

	factory_levels.create_leveled_machines(ev_refining_crusher_levels)
	factory_levels.create_leveled_machines(ev_refining_echamber_levels)
	factory_levels.create_leveled_machines(ev_refining_pchamber_levels)
end

factory_levels.fix_productivity(assembling_machine_levels)
factory_levels.fix_productivity(oil_refinery_levels)
factory_levels.fix_productivity(chemical_plant_levels)
factory_levels.fix_productivity(centrifuge_levels)
factory_levels.fix_productivity(burner_furnace_levels)
factory_levels.fix_productivity(electric_furnace_levels)

factory_levels.convert_furnace_to_assembling_machines(burner_furnace_levels)
factory_levels.convert_furnace_to_assembling_machines(electric_furnace_levels)