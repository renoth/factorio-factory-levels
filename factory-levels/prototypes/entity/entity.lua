assembling_machine_levels = {
	type = "assembling-machine",
	tiers = 3,
	base_machine_names = { "assembling-machine-1", "assembling-machine-2", "assembling-machine-3" },
	base_level_tints = {
		{ r = 1, g = 1, b = 1 },
		{ r = 1, g = 1, b = 1 },
		{ r = 1, g = 1, b = 1 }
	},
	level_tint_multipliers = {
		{ r = -0.02, g = -0.02, b = 0 },
		{ r = 0, g = 0, b = -0.016 },
		{ r = 0, g = -0.008, b = -0.008 },
	},
	levels = { 25, 50, 100 },
	base_speeds = { 0.5, 0.75, 1.25 },
	speed_multipliers = { 0.01, 0.01, 0.0175 },
	base_consumption = { 75, 150, 375 },
	consumption_multipliers = { 2.5, 4.5, 7.5 },
	consumption_unit = { "kW", "kW", "kW" },
	base_pollution = { 4, 3, 2, },
	pollution_multipliers = { 0.04, 0.04, 0.04 },
	base_productivity = { 0, 0, 0 },
	productivity_multipliers = { 0.0025, 0.0025, 0.0025 },
	levels_per_module_slots = { 20, 20, 25 },
	base_module_slots = { 0, 2, 4 },
	bonus_module_slots = { 1, 1, 1 }
}

factory_levels.create_leveled_machines(assembling_machine_levels)

oil_refinery_levels = {
	type = "assembling-machine",
	tiers = 1,
	base_machine_names = { "oil-refinery" },
	base_level_tints = { { r = 1, g = 1, b = 1 } },
	level_tint_multipliers = { { r = 0, g = -0.008, b = -0.008 } },
	levels = { 100 },
	base_speeds = { 1 },
	speed_multipliers = { 0.015 },
	base_consumption = { 210 },
	consumption_multipliers = { 5 },
	consumption_unit = { "kW" },
	base_pollution = { 6 },
	pollution_multipliers = { 0.14 },
	base_productivity = { 0 },
	productivity_multipliers = { 0.001 },
	levels_per_module_slots = { 25 },
	base_module_slots = { 3 },
	bonus_module_slots = { 1 }
}
factory_levels.create_leveled_machines(oil_refinery_levels)

chemical_plant_levels = {
	type = "assembling-machine",
	tiers = 1,
	base_machine_names = { "chemical-plant" },
	base_level_tints = { { r = 1, g = 1, b = 1 } },
	level_tint_multipliers = { { r = 0, g = -0.008, b = -0.008 } },
	levels = { 100 },
	base_speeds = { 1 },
	speed_multipliers = { 0.015 },
	base_consumption = { 210 },
	consumption_multipliers = { 5 },
	consumption_unit = { "kW" },
	base_pollution = { 4 },
	pollution_multipliers = { 0.06 },
	base_productivity = { 0 },
	productivity_multipliers = { 0.001 },
	levels_per_module_slots = { 25 },
	base_module_slots = { 3 },
	bonus_module_slots = { 1 }
}
if mods["space-exploration"] then
	table.insert(data.raw["assembling-machine"]["chemical-plant"].crafting_categories, "melting")
end
factory_levels.create_leveled_machines(chemical_plant_levels)

centrifuge_levels = {
	type = "assembling-machine",
	tiers = 1,
	base_machine_names = { "centrifuge" },
	base_level_tints = { { r = 1, g = 1, b = 1 } },
	level_tint_multipliers = { { r = 0, g = -0.008, b = -0.008 } },
	levels = { 100 },
	base_speeds = { 1 },
	speed_multipliers = { 0.015 },
	base_consumption = { 350 },
	consumption_multipliers = { 5 },
	consumption_unit = { "kW" },
	base_pollution = { 4 },
	pollution_multipliers = { 0.06 },
	base_productivity = { 0 },
	productivity_multipliers = { 0.001 },
	levels_per_module_slots = { 25 },
	base_module_slots = { 2 },
	bonus_module_slots = { 1 }
}
factory_levels.create_leveled_machines(centrifuge_levels)

-- Furnaces
burner_furnace_levels = {
	type = "furnace",
	tiers = 2,
	base_machine_names = { "stone-furnace", "steel-furnace" },
	base_level_tints = {
		{ r = 1, g = 1, b = 1 },
		{ r = 1, g = 1, b = 1 }
	},
	level_tint_multipliers = {
		{ r = 0, g = -0.032, b = -0.032 },
		{ r = 0, g = -0.008, b = -0.008 }
	},
	levels = { 25, 100 },
	base_speeds = { 1, 2 },
	speed_multipliers = { 0.04, 0.04 },
	base_consumption = { 90, 90 },
	consumption_multipliers = { 1, 2 },
	consumption_unit = { "kW", "kW" },
	base_pollution = { 2, 4 },
	pollution_multipliers = { 0.04, 0.12 },
	base_productivity = { 0, 0 },
	productivity_multipliers = { 0.002, 0.002 },
	levels_per_module_slots = { 25, 25 },
	base_module_slots = { 0, 0 },
	bonus_module_slots = { 0, 1 },
}

electric_furnace_levels = {
	type = "furnace",
	tiers = 1,
	base_machine_names = { "electric-furnace" },
	base_level_tints = { { r = 1, g = 1, b = 1 } },
	level_tint_multipliers = { { r = 0, g = -0.008, b = -0.008 } },
	levels = { 100 },
	base_speeds = { 2 },
	speed_multipliers = { 0.04 },
	base_consumption = { 180 },
	consumption_multipliers = { 2.8 },
	consumption_unit = { "kW" },
	base_pollution = { 1 },
	pollution_multipliers = { 0.12 },
	base_productivity = { 0 },
	productivity_multipliers = { 0.002 },
	levels_per_module_slots = { 25 },
	base_module_slots = { 2 },
	bonus_module_slots = { 1 }
}

if mods["space-exploration"] then
	table.insert(data.raw["furnace"]["stone-furnace"].crafting_categories, "kiln")
	table.insert(data.raw["furnace"]["steel-furnace"].crafting_categories, "kiln")
	table.insert(data.raw["furnace"]["electric-furnace"].crafting_categories, "kiln")
end

factory_levels.create_leveled_machines(burner_furnace_levels)
factory_levels.create_leveled_machines(electric_furnace_levels)

if mods["Electric Furnaces"] then
	electric_burner_furnace_levels = {
		type = "furnace",
		tiers = 2,
		base_machine_names = { "electric-stone-furnace", "electric-steel-furnace" },
		base_level_tints = {
			{ r = 1, g = 1, b = 1 },
			{ r = 1, g = 1, b = 1 }
		},
		level_tint_multipliers = {
			{ r = 0, g = -0.032, b = -0.032 },
			{ r = 0, g = -0.008, b = -0.008 }
		},
		levels = { 25, 100 },
		base_speeds = { 1, 2 },
		speed_multipliers = { 0.04, 0.04 },
		base_consumption = { 90, 90 },
		consumption_multipliers = { 1, 2 },
		consumption_unit = { "kW", "kW" },
		base_pollution = { 2, 4 },
		pollution_multipliers = { 0.04, 0.12 },
		base_productivity = { 0, 0 },
		productivity_multipliers = { 0.002, 0.002 },
		levels_per_module_slots = { 25, 25 },
		base_module_slots = { 0, 0 },
		bonus_module_slots = { 0, 1 },
	}

	electric_leveled_furnace_levels = {
		type = "furnace",
		tiers = 3,
		base_machine_names = { "electric-furnace", "electric-furnace-2", "electric-furnace-3" },
		base_level_tints = { { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 } },
		level_tint_multipliers = { { r = -0.02, g = -0.02, b = 0 }, { r = 0, g = 0, b = -0.016 }, { r = 0, g = -0.008, b = -0.008 } },
		levels = { 25, 50, 100 },
		base_speeds = { 2, 3, 4 },
		speed_multipliers = { 0.01, 0.01, 0.02 },
		base_consumption = { 180, 240, 300 },
		consumption_multipliers = { 2.8, 2.8, 2.8 },
		consumption_unit = { "kW", "kW", "kW" },
		base_pollution = { 1, 1.1, 1.2 },
		pollution_multipliers = { 0.12, 0.12, 0.12 },
		base_productivity = { 0, 0, 0 },
		productivity_multipliers = { 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 25, 25, 30 },
		base_module_slots = { 2, 2, 4 },
		bonus_module_slots = { 0, 2, 3 }
	}
	factory_levels.create_leveled_machines(electric_burner_furnace_levels)
	factory_levels.create_leveled_machines(electric_leveled_furnace_levels)
end

if mods["angelspetrochem"] then
	electrolyzer_levels = {
		type = "assembling-machine",
		tiers = 4,
		base_machine_names = { "angels-electrolyser", "angels-electrolyser-2", "angels-electrolyser-3", "angels-electrolyser-4" },
		base_level_tints = { { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 } },
		level_tint_multipliers = { { r = 0, g = 0, b = -0.02 }, { r = 0, g = 0, b = -0.02 }, { r = 0, g = -0.015, b = -0.015 }, { r = -0.009, g = 0, b = 0 } },
		levels = { 25, 25, 25, 100 },
		base_speeds = { 1, 1.5, 2, 2.5 },
		speed_multipliers = { 0.02, 0.02, 0.02, 0.025 },
		base_consumption = { 300, 350, 400, 450 },
		consumption_multipliers = { 2, 2, 2, 2 },
		consumption_unit = { "kW", "kW", "kW", "kW" },
		base_pollution = { 1.2, 1.8, 2.4, 3 },
		pollution_multipliers = { 0.1, 0.1, 0.1, 0.2 },
		base_productivity = { 0, 0, 0, 0 },
		productivity_multipliers = { 0.002, 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 25, 25, 25, 25 },
		base_module_slots = { 2, 2, 2, 2 },
		bonus_module_slots = { 0, 0, 0, 1 }
	}

	factory_levels.create_leveled_machines(electrolyzer_levels)
end

if mods["angelsbioprocessing"] then
	algaefarm_levels = {
		type = "assembling-machine",
		tiers = 4,
		base_machine_names = { "algae-farm", "algae-farm-2", "algae-farm-3", "algae-farm-4" },
		base_level_tints = { { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 } },
		level_tint_multipliers = { { r = 0, g = 0, b = -0.02 }, { r = 0, g = 0, b = -0.02 }, { r = 0, g = -0.015, b = -0.015 }, { r = -0.009, g = 0, b = 0 } },
		levels = { 25, 25, 25, 100 },
		base_speeds = { 0.5, 1, 1.5, 2 },
		speed_multipliers = { 0.02, 0.02, 0.02, 0.03 },
		base_consumption = { 100, 125, 150, 175 },
		consumption_multipliers = { 1, 1, 1, 1 },
		consumption_unit = { "kW", "kW", "kW", "kW" },
		base_pollution = { -10, -20, -30, -40 },
		pollution_multipliers = { -0.1, -0.1, -0.1, -0.2 },
		base_productivity = { 0, 0, 0, 0 },
		productivity_multipliers = { 0.002, 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 25, 25, 25, 25 },
		base_module_slots = { 2, 2, 2, 2 },
		bonus_module_slots = { 0, 0, 0, 1 }
	}

	factory_levels.create_leveled_machines(algaefarm_levels)
end

if mods["angelsrefining"] then
	ore_crusher_levels = {
		type = "assembling-machine",
		tiers = 4,
		base_machine_names = { "burner-ore-crusher", "ore-crusher", "ore-crusher-2", "ore-crusher-3" },
		base_level_tints = { { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 } },
		level_tint_multipliers = { { r = 0, g = 0, b = -0.02 }, { r = 0, g = 0, b = -0.02 }, { r = 0, g = -0.015, b = -0.015 }, { r = -0.009, g = 0, b = 0 } },
		levels = { 25, 25, 50, 100 },
		base_speeds = { 1, 1.5, 2, 3 },
		speed_multipliers = { 0.02, 0.02, 0.02, 0.04 },
		base_consumption = { 100, 100, 125, 150 },
		consumption_multipliers = { 2, 2, 2, 2 },
		consumption_unit = { "kW", "kW", "kW", "kW" },
		base_pollution = { 7, 2, 3, 4 },
		pollution_multipliers = { 0.1, 0.1, 0.1, 0.2 },
		base_productivity = { 0, 0, 0, 0 },
		productivity_multipliers = { 0.002, 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 25, 25, 25, 25 },
		base_module_slots = { 0, 1, 2, 3 },
		bonus_module_slots = { 0, 0, 1, 1 }
	}

	liquifier_levels = {
		type = "assembling-machine",
		tiers = 4,
		base_machine_names = { "liquifier", "liquifier-2", "liquifier-3", "liquifier-4" },
		base_level_tints = { { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 } },
		level_tint_multipliers = { { r = 0, g = 0, b = -0.02 }, { r = 0, g = 0, b = -0.02 }, { r = 0, g = -0.015, b = -0.015 }, { r = -0.009, g = 0, b = 0 } },
		levels = { 25, 25, 50, 100 },
		base_speeds = { 1.5, 2.25, 3, 3.75 },
		speed_multipliers = { 0.03, 0.03, 0.015, 0.0375 },
		base_consumption = { 125, 150, 200, 300 },
		consumption_multipliers = { 1, 2, 2, 3 },
		consumption_unit = { "kW", "kW", "kW", "kW" },
		base_pollution = { 1.8, 2.4, 3, 3.6 },
		pollution_multipliers = { 0.1, 0.1, 0.1, 0.2 },
		base_productivity = { 0, 0, 0, 0 },
		productivity_multipliers = { 0.002, 0.002, 0.002, 0.002 },
		levels_per_module_slots = { 25, 25, 25, 25 },
		base_module_slots = { 1, 2, 3, 4 },
		bonus_module_slots = { 0, 0, 1, 1 }
	}

	crystallizer_levels = {
		type = "assembling-machine",
		tiers = 2,
		base_machine_names = { "crystallizer", "crystallizer-2" },
		base_level_tints = { { r = 1, g = 1, b = 1 }, { r = 1, g = 1, b = 1 } },
		level_tint_multipliers = { { r = 0, g = 0, b = -0.018 }, { r = 0, g = 0, b = -0.009 } },
		levels = { 50, 100 },
		base_speeds = { 1.5, 2.25 },
		speed_multipliers = { 0.015, 0.0275 },
		base_consumption = { 150, 250 },
		consumption_multipliers = { 2, 3 },
		consumption_unit = { "kW", "kW", "kW" },
		base_pollution = { 1.8, 2.4 },
		pollution_multipliers = { 0.1, 0.1 },
		base_productivity = { 0, 0 },
		productivity_multipliers = { 0.002, 0.002 },
		levels_per_module_slots = { 25, 25 },
		base_module_slots = { 1, 2 },
		bonus_module_slots = { 0, 1 }
	}

	factory_levels.create_leveled_machines(ore_crusher_levels)
	factory_levels.create_leveled_machines(liquifier_levels)
	factory_levels.create_leveled_machines(crystallizer_levels)
end

