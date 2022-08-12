for i = 1, 25, 1 do
	local leveltint = { r = 1 - 0.02 * i, g = 1 - 0.02 * i, b = 1, 1 }

	local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

	assemblyLeveled.name = "assembling-machine-1-level-" .. i
	assemblyLeveled.minable.result = "assembling-machine-1"
	assemblyLeveled.placeable_by = { item = "assembling-machine-1", count = 1 }
	assemblyLeveled.animation.layers[1].hr_version.tint = leveltint
	assemblyLeveled.animation.layers[1].tint = leveltint
	assemblyLeveled.animation.layers[2].hr_version.tint = leveltint
	assemblyLeveled.animation.layers[2].tint = leveltint
	table.insert(assemblyLeveled.flags, "hidden")    -- Hides the machine from "made in"

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		assemblyLeveled.crafting_speed = 0.5 + i * 0.01
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		assemblyLeveled.energy_usage = (75 + 2.5 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		assemblyLeveled.energy_source.emissions_per_minute = 4 + 0.04 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.0025 * i
	end

	if (settings.startup["factory-levels-enable-module-bonus"].value and i >= 20) then
		assemblyLeveled.module_specification = { module_slots = 1 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	end

	data:extend({ assemblyLeveled })
end

for i = 1, 50, 1 do
	local leveltint = { r = 1, g = 1, b = 1 - 0.016 * i, 1 }

	local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])

	assemblyLeveled.name = "assembling-machine-2-level-" .. i
	assemblyLeveled.minable.result = "assembling-machine-2"
	assemblyLeveled.placeable_by = { item = "assembling-machine-2", count = 1 }
	assemblyLeveled.animation.layers[1].hr_version.tint = leveltint
	assemblyLeveled.animation.layers[1].tint = leveltint
	assemblyLeveled.animation.layers[2].hr_version.tint = leveltint
	assemblyLeveled.animation.layers[2].tint = leveltint
	table.insert(assemblyLeveled.flags, "hidden")

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		assemblyLeveled.crafting_speed = 0.75 + i * 0.01
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		assemblyLeveled.energy_usage = (150 + 4.5 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		assemblyLeveled.energy_source.emissions_per_minute = 3 + 0.04 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.0025 * i
	end

	if (settings.startup["factory-levels-enable-module-bonus"].value and i >= 40) then
		assemblyLeveled.module_specification = { module_slots = 4 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 20) then
		assemblyLeveled.module_specification = { module_slots = 3 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	end

	data:extend({ assemblyLeveled })
end

for i = 1, 100, 1 do
	local leveltint = { r = 1, g = 1 - 0.008 * i, b = 1 - 0.008 * i, 1 }

	local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])

	assemblyLeveled.name = "assembling-machine-3-level-" .. i
	assemblyLeveled.minable.result = "assembling-machine-3"
	assemblyLeveled.placeable_by = { item = "assembling-machine-3", count = 1 }
	assemblyLeveled.animation.layers[1].hr_version.tint = leveltint
	assemblyLeveled.animation.layers[1].tint = leveltint
	assemblyLeveled.animation.layers[2].hr_version.tint = leveltint
	assemblyLeveled.animation.layers[2].tint = leveltint
	table.insert(assemblyLeveled.flags, "hidden")

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		assemblyLeveled.crafting_speed = 1.25 + i * 0.0175
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		assemblyLeveled.energy_usage = (375 + 7.5 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		assemblyLeveled.energy_source.emissions_per_minute = 2 + 0.04 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.0025 * i
	end

	if (settings.startup["factory-levels-enable-module-bonus"].value and i >= 100) then
		assemblyLeveled.module_specification = { module_slots = 8 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 75) then
		assemblyLeveled.module_specification = { module_slots = 7 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 50) then
		assemblyLeveled.module_specification = { module_slots = 6 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 25) then
		assemblyLeveled.module_specification = { module_slots = 5 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	end

	data:extend({ assemblyLeveled })
end

for i = 1, 100, 1 do
	local leveltint = { r = 1, g = 1 - 0.008 * i, b = 1 - 0.008 * i, 1 }

	local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["oil-refinery"])

	assemblyLeveled.name = "oil-refinery-level-" .. i
	assemblyLeveled.minable.result = "oil-refinery"
	assemblyLeveled.placeable_by = { item = "oil-refinery", count = 1 }
	assemblyLeveled.animation.tint = leveltint
	table.insert(assemblyLeveled.flags, "hidden")

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		assemblyLeveled.crafting_speed = 1 + i * 0.015
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		assemblyLeveled.energy_usage = (210 + 5 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		assemblyLeveled.energy_source.emissions_per_minute = 6 + 0.14 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.001 * i
	end

	if (settings.startup["factory-levels-enable-module-bonus"].value and i >= 100) then
		assemblyLeveled.module_specification = { module_slots = 7 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 75) then
		assemblyLeveled.module_specification = { module_slots = 6 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 50) then
		assemblyLeveled.module_specification = { module_slots = 5 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 25) then
		assemblyLeveled.module_specification = { module_slots = 4 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	end

	data:extend({ assemblyLeveled })
end

for i = 1, 100, 1 do
	local leveltint = { r = 1, g = 1 - 0.008 * i, b = 1 - 0.008 * i, 1 }

	local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])

	assemblyLeveled.name = "chemical-plant-level-" .. i
	assemblyLeveled.minable.result = "chemical-plant"
	assemblyLeveled.placeable_by = { item = "chemical-plant", count = 1 }
	assemblyLeveled.animation.tint = leveltint
	table.insert(assemblyLeveled.flags, "hidden")

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		assemblyLeveled.crafting_speed = 1 + i * 0.015
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		assemblyLeveled.energy_usage = (210 + 5 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		assemblyLeveled.energy_source.emissions_per_minute = 4 + 0.06 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		assemblyLeveled.base_productivity = 0.001 * i
	end

	if (settings.startup["factory-levels-enable-module-bonus"].value and i >= 100) then
		assemblyLeveled.module_specification = { module_slots = 7 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 75) then
		assemblyLeveled.module_specification = { module_slots = 6 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 50) then
		assemblyLeveled.module_specification = { module_slots = 5 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 25) then
		assemblyLeveled.module_specification = { module_slots = 4 }
		assemblyLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	end

	data:extend({ assemblyLeveled })
end

-- Furnaces

for i = 1, 25, 1 do
	local leveltint = { r = 1 - 0.032 * i, g = 1 - 0.032 * i, b = 1, 1 }

	local furnaceLeveled = util.table.deepcopy(data.raw["furnace"]["stone-furnace"])

	furnaceLeveled.name = "stone-furnace-level-" .. i
	furnaceLeveled.minable.result = "stone-furnace"
	furnaceLeveled.placeable_by = { item = "stone-furnace", count = 1 }
	furnaceLeveled.animation.layers[1].hr_version.tint = leveltint
	furnaceLeveled.animation.layers[1].tint = leveltint
	furnaceLeveled.animation.layers[2].hr_version.tint = leveltint
	furnaceLeveled.animation.layers[2].tint = leveltint
	table.insert(furnaceLeveled.flags, "hidden")

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		furnaceLeveled.crafting_speed = 1 + i * 0.04
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		furnaceLeveled.energy_usage = (90 + 1 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		furnaceLeveled.energy_source.emissions_per_minute = 2 + 0.04 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		furnaceLeveled.base_productivity = 0.002 * i
	end

	if mods["space-exploration"] then
		furnaceLeveled.crafting_categories = { "smelting", "kiln" }
	end

	data:extend({ furnaceLeveled })
end

for i = 1, 100, 1 do
	local leveltint = { r = 1, g = 1 - 0.008 * i, b = 1 - 0.008 * i, 1 }

	local furnaceLeveled = util.table.deepcopy(data.raw["furnace"]["steel-furnace"])

	furnaceLeveled.name = "steel-furnace-level-" .. i
	furnaceLeveled.minable.result = "steel-furnace"
	furnaceLeveled.placeable_by = { item = "steel-furnace", count = 1 }
	furnaceLeveled.animation.layers[1].hr_version.tint = leveltint
	furnaceLeveled.animation.layers[1].tint = leveltint
	furnaceLeveled.animation.layers[2].hr_version.tint = leveltint
	furnaceLeveled.animation.layers[2].tint = leveltint
	table.insert(furnaceLeveled.flags, "hidden")

	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		furnaceLeveled.crafting_speed = 2 + i * 0.04
	end

	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		furnaceLeveled.energy_usage = (90 + 2 * i) .. "kW"
	end

	if (settings.startup["factory-levels-enable-emissions"].value) then
		furnaceLeveled.energy_source.emissions_per_minute = 4 + 0.12 * i
	end

	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		furnaceLeveled.base_productivity = 0.002 * i
	end

	if (settings.startup["factory-levels-enable-module-bonus"].value and i >= 100) then
		furnaceLeveled.module_specification = { module_slots = 4 }
		furnaceLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 75) then
		furnaceLeveled.module_specification = { module_slots = 3 }
		furnaceLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 50) then
		furnaceLeveled.module_specification = { module_slots = 2 }
		furnaceLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	elseif (settings.startup["factory-levels-enable-module-bonus"].value and i >= 25) then
		furnaceLeveled.module_specification = { module_slots = 1 }
		furnaceLeveled.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
	end

	if mods["space-exploration"] then
		furnaceLeveled.crafting_categories = { "smelting", "kiln" }
	end

	data:extend({ furnaceLeveled })
end

for i = 1, 99, 1 do
	local assemblyLeveled = data.raw["assembling-machine"]["oil-refinery-level-" .. i]
	local assemblyLeveledmax = data.raw["assembling-machine"]["oil-refinery-level-100"]
	assemblyLeveledmax.fast_replaceable_group = "assembling-machine"
	assemblyLeveled.next_upgrade = "oil-refinery-level-" .. (i + 1)
	assemblyLeveled.fast_replaceable_group = "assembling-machine"
end
