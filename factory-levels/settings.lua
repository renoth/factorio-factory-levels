data:extend({
    {
        type = "bool-setting",
        name = "factory-levels-enable-productivity-bonus",
        order = "a",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "factory-levels-enable-module-bonus",
        order = "aa",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "factory-levels-enable-speed-bonus",
        order = "b",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "factory-levels-enable-energy-usage",
        order = "c",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "bool-setting",
        name = "factory-levels-enable-emissions",
        order = "d",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "double-setting",
        name = "factory-levels-exponent",
        order = "e",
        minimum_value = 1.5, maximum_value = 5,
        setting_type = "runtime-global",
        default_value = 3
    },
	{
		type = "bool-setting",
		name = "factory-levels-disable-mod",
		order = "f",
		setting_type = "runtime-global",
		default_value = false
	}
})