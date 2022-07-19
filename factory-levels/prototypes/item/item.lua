for i = 1, 100, 1 do
    local leveltint = { r = 0.008 * i, g = 0.004 * i, b = 0.008 * i, a = 0.008 * i }

    data:extend({
        {
            type = "item",
            name = "assembling-machine-level-" .. i,
            icons = {
                {
                    icon = "__base__/graphics/icons/assembling-machine-1.png",
                    tint = {
                        r = 0.5 + 0.5 * i * 0.01,
                        g = 0.55,
                        b = 0.8,
                        a = 1
                    }
                }
            },
            icon_size = 64, icon_mipmaps = 4,
            subgroup = "production-machine",
            stack_size = 50
        }
    })
end