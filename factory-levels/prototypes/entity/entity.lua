for i = 1, 25, 1 do
    local leveltint = { r = 0.1 + 0.032 * i, g = 0.1 + 0.032 * i, b = 0.1 + 0.032 * i, 1 }

    local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

    assemblyLeveled.name = "assembling-machine-1-level-" .. i
    assemblyLeveled.icons = { { icon = "__base__/graphics/icons/assembling-machine-1.png", tint = { r = 0.032 * i, g = 0.032 * i, b = 0.032 * i, 1 } } }
    assemblyLeveled.minable.result = "assembling-machine-1"
    assemblyLeveled.animation.layers[1].hr_version.tint = leveltint
    assemblyLeveled.animation.layers[1].tint = leveltint
    assemblyLeveled.animation.layers[2].hr_version.tint = leveltint
    assemblyLeveled.animation.layers[2].tint = leveltint
    assemblyLeveled.energy_usage = (75 + 2.5 * i) .. "kW"
    assemblyLeveled.crafting_speed = 0.5 + i * 0.025
    assemblyLeveled.requireditems = i * i + 10
    assemblyLeveled.maxhealth = 200 + 5 * i
    assemblyLeveled.energy_source.emissions_per_minute = 4 + 0.15 * i
    if (i == 25) then
        assemblyLeveled.nextlevel = "assembling-machine-2"
    end
    assemblyLeveled.nextlevel = "assembling-machine-1-level-" .. (i + 1)

    data:extend({ assemblyLeveled })
end
