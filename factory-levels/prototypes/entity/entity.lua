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
    assemblyLeveled.energy_usage = (75 + 2.5 * i) .. "kW"
    assemblyLeveled.crafting_speed = 0.5 + i * 0.01
    assemblyLeveled.energy_source.emissions_per_minute = 4 + 0.04 * i

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
    assemblyLeveled.energy_usage = (150 + 4.5 * i) .. "kW"
    assemblyLeveled.crafting_speed = 0.75 + i * 0.01
    assemblyLeveled.maxhealth = 350 + i
    assemblyLeveled.energy_source.emissions_per_minute = 3 + 0.04 * i

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
    assemblyLeveled.energy_usage = (375 + 7.5 * i) .. "kW"
    assemblyLeveled.crafting_speed = 1.25 + i * 0.0175
    assemblyLeveled.maxhealth = 400 + i * 4
    assemblyLeveled.energy_source.emissions_per_minute = 2 + 0.04 * i

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
    furnaceLeveled.energy_usage = (90 - 0.25 * i) .. "kW"
    furnaceLeveled.crafting_speed = 1 + i * 0.04
    furnaceLeveled.energy_source.emissions_per_minute = 2 + 0.04 * i

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
    furnaceLeveled.energy_usage = (90 - 0.3 * i) .. "kW"
    furnaceLeveled.crafting_speed = 2 + i * 0.06
    furnaceLeveled.energy_source.emissions_per_minute = 4 + 0.12 * i

    data:extend({ furnaceLeveled })
end
