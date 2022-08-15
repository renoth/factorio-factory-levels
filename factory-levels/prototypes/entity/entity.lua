assembling_machine_levels = {
	type = "assembling-machine",
	tiers = 3,
	base_machine_names = { "assembling-machine-1", "assembling-machine-2", "assembling-machine-3" },
	base_level_tints = {
		{ r = 1, g = 1, b = 1},
		{ r = 1, g = 1, b = 1},
		{ r = 1, g = 1, b = 1}
	},
	level_tint_multipliers = {
		{ r = -0.02, g = -0.02, b = 0 },
		{ r = 0, g = 0, b = -0.016 },
		{ r = 0, g = -0.008, b = -0.008},
	},
	levels = { 25, 50, 100 },
	base_speeds = { 0.5, 0.75, 1.25 },
	speed_multipliers = { 0.01, 0.01, 0.0175 },
	base_consumption = { 75, 150, 375 },
	consumption_multipliers = {  2.5, 4.5, 7.5 },
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
	base_level_tints = {{ r = 1, g = 1, b = 1 }},
	level_tint_multipliers = {{ r = 0, g = -0.008, b = -0.008 }},
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
	base_level_tints = {{ r = 1, g = 1, b = 1 }},
	level_tint_multipliers = {{ r = 0, g = -0.008, b = -0.008 }},
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
	base_level_tints = {{ r = 1, g = 1, b = 1 }},
	level_tint_multipliers = {{ r = 0, g = -0.008, b = -0.008 }},
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
	base_module_slots = { 2},
	bonus_module_slots = { 1 }
}
factory_levels.create_leveled_machines(centrifuge_levels)

-- Furnaces
burner_furnace_levels = {
	type = "furnace",
	tiers = 2,
	base_machine_names = { "stone-furnace", "steel-furnace" },
	base_level_tints = {
		{ r = 1, g = 1, b = 1},
		{ r = 1, g = 1, b = 1}
	},
	level_tint_multipliers = {
		{ r = 0, g = -0.032, b = -0.032 },
		{ r = 0, g = -0.008, b = -0.008 }
	},
	levels = { 25, 100 },
	base_speeds = { 1, 2 },
	speed_multipliers = { 0.04, 0.04 },
	base_consumption = { 90, 90 },
	consumption_multipliers = {  1, 2 },
	consumption_unit = { "kW", "kW" },
	base_pollution = { 2, 4 },
	pollution_multipliers = { 0.04, 0.12 },
	base_productivity = { 0, 0 },
	productivity_multipliers = { 0.002, 0.002},
	levels_per_module_slots = { 25, 25 },
	base_module_slots = { 0, 0 },
	bonus_module_slots = { 0, 1 },
}

electric_furnace_levels = {
	type = "furnace",
	tiers = 1,
	base_machine_names = { "electric-furnace" },
	base_level_tints = {{ r = 1, g = 1, b = 1 }},
	level_tint_multipliers = {{ r = 0, g = -0.008, b = -0.008 }},
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
