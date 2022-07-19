for i = 1, 100, 1 do
    local leveltint = { r = 0.008 * i, g = 0.004 * i, b = 0.008 * i, 1 }

    local assemblyLeveled = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

    assemblyLeveled.name = "assembling-machine-level-" .. i
    assemblyLeveled.icons = { { icon = "__base__/graphics/icons/assembling-machine-1.png", tint = { r = 0.008 * i, g = 0.004 * i, b = 0.008 * i, 1 } } }
    assemblyLeveled.minable.result = "assembling-machine-level-" .. i
    assemblyLeveled.animation.layers[1].hr_version.tint = leveltint
    assemblyLeveled.animation.layers[1].tint = leveltint
    assemblyLeveled.animation.layers[2].hr_version.tint = leveltint
    assemblyLeveled.animation.layers[2].tint = leveltint
    assemblyLeveled.energy_usage = (75 +  2 * i) .. "kW"
    assemblyLeveled.crafting_speed = 0.5 + i * 0.05
    assemblyLeveled.requireditems = i * i + 10
    assemblyLeveled.nextlevel = "assembling-machine-level-" .. (i + 1)

    data:extend({ assemblyLeveled })
end
