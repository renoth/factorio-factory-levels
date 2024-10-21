local factory_levels = {}

function factory_levels.update_machine_speed(machine, level, base_speed, speed_multiplier)
	if (settings.startup["factory-levels-enable-speed-bonus"].value) then
		machine.crafting_speed = base_speed + level * speed_multiplier
	end
end

function factory_levels.update_crafting_categories(machine, _, crafting_categories)
	machine.crafting_categories = crafting_categories
end

function factory_levels.update_machine_energy_usage(machine, level, base_usage, usage_multiplier, energy_unit)
	if (settings.startup["factory-levels-enable-energy-usage"].value) then
		machine.energy_usage = (base_usage + usage_multiplier * level) .. energy_unit
	end
end

function factory_levels.update_machine_pollution(machine, level, base_emission, emission_multiplier)
	if (settings.startup["factory-levels-enable-emissions"].value) then
		machine.energy_source.emissions_per_minute.pollution = base_emission + emission_multiplier * level
	end
end

function factory_levels.update_machine_productivity(machine, level, base_productivity, productivity_multiplier)
	if (settings.startup["factory-levels-enable-productivity-bonus"].value) then
		machine.base_productivity = base_productivity + productivity_multiplier * level
	end
end

function factory_levels.update_machine_module_slots(machine, level, levels_per_module_slot, base_module_slots, module_slot_bonus)
	if (settings.startup["factory-levels-enable-module-bonus"].value) then
		machine.module_specification = { module_slots = base_module_slots + (math.floor(level / levels_per_module_slot) * module_slot_bonus) }
		if machine.module_specification.module_slots > 0 then
			machine.allowed_effects = { "consumption", "speed", "productivity", "pollution" }
		end
	end
end

function factory_levels.update_animation_tint(animation, tint)
	if animation == nil then
		return
	end

	if animation.north then
		factory_levels.update_animation_tint(animation.north, tint)
		factory_levels.update_animation_tint(animation.east, tint)
		factory_levels.update_animation_tint(animation.west, tint)
		factory_levels.update_animation_tint(animation.south, tint)
		return
	end

	if animation.layers then
		for _, layer in pairs(animation.layers) do
			factory_levels.update_animation_tint(layer, tint)
		end
	end
	if animation.hr_version then
		factory_levels.update_animation_tint(animation.hr_version, tint)
	end
	animation.tint = tint
end

function factory_levels.update_machine_tint(machine, level, base_tint, tint_multiplier)
	local tint = { r = base_tint.r + level * tint_multiplier.r,
				   g = base_tint.g + level * tint_multiplier.g,
				   b = base_tint.b + level * tint_multiplier.b,
				   a = 1 }

	factory_levels.update_animation_tint(machine.animation, tint)

	-- Some machines, such as centrigue put their main animation set into idle_animation.
	factory_levels.update_animation_tint(machine.idle_animation, tint)
end

function factory_levels.get_furnace(base_machine_name)
	-- Some mods might turn the stone-furnace, steel-furnace and electric-furnace into assembling machine prototype. Krastorio 2 being an example of one such mod.
	if data.raw["furnace"][base_machine_name] then
		return data.raw["furnace"][base_machine_name]
	end
	if data.raw["assembling-machine"][base_machine_name] then
		return data.raw["assembling-machine"][base_machine_name]
	end
	return nil
end

function factory_levels.get_or_create_machine(machine_type, base_machine_name, level)
	local base_machine = data.raw[machine_type][base_machine_name]

	if machine_type == "furnace" then
		base_machine = factory_levels.get_furnace(base_machine_name)
	end

	if base_machine == nil then
		log("base machine is nil")
		log(base_machine_name)
		return nil
	end

	if level == 0 then
		return base_machine
	end

	local new_machine_name = base_machine_name .. "-level-" .. level

	if data.raw[base_machine.type][new_machine_name] == nil then
		local base_machine = data.raw[machine_type][base_machine_name]
		if base_machine == nil then
			return nil
		end
		local machine = table.deepcopy(base_machine)
		machine.name = new_machine_name
		data:extend({ machine })
	end

	return data.raw[base_machine.type][new_machine_name]
end

function factory_levels.create_leveled_machines(machines)
	for tier = 1, machines.tiers, 1 do
		for level = 0, machines.levels[tier], 1 do
			local machine = factory_levels.get_or_create_machine(machines.type, machines.base_machine_names[tier], level)

			if level > 0 then
				machine.minable.result = machines.base_machine_names[tier]
				machine.placeable_by = { item = machines.base_machine_names[tier], count = 1 }
				machine.localised_name = { "entity-name.factory-levels", { "entity-name." .. machines.base_machine_names[tier] }, level .. "" }
				machine.localised_description = { "entity-description." .. machines.base_machine_names[tier] }
			end

			factory_levels.update_machine_speed(machine, level, machines.base_speeds[tier], machines.speed_multipliers[tier])
			factory_levels.update_machine_energy_usage(machine, level, machines.base_consumption[tier], machines.consumption_multipliers[tier], machines.consumption_unit[tier])
			factory_levels.update_machine_pollution(machine, level, machines.base_pollution[tier], machines.pollution_multipliers[tier])
			factory_levels.update_machine_productivity(machine, level, machines.base_productivity[tier], machines.productivity_multipliers[tier])
			factory_levels.update_machine_module_slots(machine, level, machines.levels_per_module_slots[tier], machines.base_module_slots[tier], machines.bonus_module_slots[tier])
			factory_levels.update_machine_tint(machine, level, machines.base_level_tints[tier], machines.level_tint_multipliers[tier])

			if mods["space-age"] and machines.crafting_categories ~= nil then
				factory_levels.update_crafting_categories(machine, level, machines.crafting_categories[tier])
			end
		end
	end
end

-- Data final fixes
function factory_levels.convert_furnace_to_assembling_machines(machines)
	-- Just in case the base machine was initially "furnace" when the leveled machines were created, but another mod later turned it into "assembling-machine" without
	-- also converting the leveled machines into "assembling-machines".
	if machines.type ~= "furnace" then
		return
	end
	for tier = 1, machines.tiers, 1 do
		base_machine = factory_levels.get_or_create_machine(machines.type, machines.base_machine_names[tier], 0)
		if base_machine.type == "assembling-machine" then
			for level = 1, machines.levels[tier], 1 do
				leveled_machine = factory_levels.get_or_create_machine(machines.type, machines.base_machine_names[tier], level)
				if leveled_machine.type == "furnace" then
					data.raw["furnace"][leveled_machine.name] = nil
					leveled_machine.type = "assembling-machine"
					data:extend({ leveled_machine })
				end
			end
		end
	end
end

function factory_levels.fix_productivity(machines)
	if (settings.startup["factory-levels-enable-productivity-bonus"].value == false) then
		return
	end
	--Undo space-explorations hold against machine level productivity.
	for tier = 1, machines.tiers, 1 do
		for level = 0, machines.levels[tier], 1 do
			local machine = factory_levels.get_or_create_machine(machines.type, machines.base_machine_names[tier], level)
			if machine.base_productivity == 0 or machine.base_productivity == nil then
				factory_levels.update_machine_productivity(machine, level, machines.base_productivity[tier], machines.productivity_multipliers[tier])
			end
		end
	end
end

return factory_levels