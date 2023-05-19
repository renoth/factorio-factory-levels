require("util")

script.on_init(function()
	global.stored_products_finished_assemblers = { }
	global.stored_products_finished_furnaces = { }
	get_built_machines()
end)

script.on_configuration_changed(function()
	get_built_machines()
end)

function get_built_machines()
	global.built_machines = global.built_machines or {}
	for unit_number, machine in pairs(global.built_machines) do
		-- Remove invalid machines from the global table.
		if not machine.entity or not machine.entity.valid then
			global.built_machines[unit_number] = nil
		end
	end
	local built_assemblers = {}
	for _, surface in pairs(game.surfaces) do
		local assemblers = surface.find_entities_filtered { type = { "assembling-machine", "furnace" } }
		for _, machine in pairs(assemblers) do
			if not global.built_machines[machine.unit_number] then
				global.built_machines[machine.unit_number] = { entity = machine, unit_number = machine.unit_number }
			end
			table.insert(built_assemblers, machine)
		end
	end
	replace_machines(built_assemblers)
end

script.on_load(function()
end)

function string_starts_with(str, start)
	return str:sub(1, #start) == start
end

machines = {
	-- Assemblers
	["assembling-machine-1"] = {
		name = "assembling-machine-1",
		level_name = "assembling-machine-1-level-",
		max_level = 25,
		next_machine = "assembling-machine-2"
	},
	["assembling-machine-2"] = {
		name = "assembling-machine-2",
		level_name = "assembling-machine-2-level-",
		max_level = 50,
		next_machine = "assembling-machine-3"
	},
	["assembling-machine-3"] = {
		name = "assembling-machine-3",
		level_name = "assembling-machine-3-level-",
		max_level = 100
	},

	-- Smelters
	["stone-furnace"] = {
		name = "stone-furnace",
		level_name = "stone-furnace-level-",
		max_level = 25,
		next_machine = "steel-furnace"
	},
	["steel-furnace"] = {
		name = "steel-furnace",
		level_name = "steel-furnace-level-",
		max_level = 100
	},
	["electric-furnace"] = {
		name = "electric-furnace",
		level_name = "electric-furnace-level-",
		max_level = 100
	},

	-- refining
	["chemical-plant"] = {
		name = "chemical-plant",
		level_name = "chemical-plant-level-",
		max_level = 100
	},
	["oil-refinery"] = {
		name = "oil-refinery",
		level_name = "oil-refinery-level-",
		max_level = 100
	},
	["centrifuge"] = {
		name = "centrifuge",
		level_name = "centrifuge-level-",
		max_level = 100
	},

	-- Simple Air Cleaner
	["air-cleaner"] = {
		name = "air-cleaner",
		level_name = "air-cleaner-level-",
		max_level = 100
	},

	-- Angels Refining
	["burner-ore-crusher"] = {
		name = "burner-ore-crusher",
		level_name = "burner-ore-crusher-level-",
		max_level = 25,
		next_machine = "ore-crusher"
	},
	["ore-crusher"] = {
		name = "ore-crusher",
		level_name = "ore-crusher-level-",
		max_level = 25,
		next_machine = "ore-crusher-2"
	},
	["ore-crusher-2"] = {
		name = "ore-crusher-2",
		level_name = "ore-crusher-2-level-",
		max_level = 50,
		next_machine = "ore-crusher-3"
	},
	["ore-crusher-3"] = {
		name = "ore-crusher-3",
		level_name = "ore-crusher-3-level-",
		max_level = 100
	},
	["liquifier"] = {
		name = "liquifier",
		level_name = "liquifier-level-",
		max_level = 25,
		next_machine = "liquifier-2"
	},
	["liquifier-2"] = {
		name = "liquifier-2",
		level_name = "liquifier-2-level-",
		max_level = 25,
		next_machine = "liquifier-3"
	},
	["liquifier-3"] = {
		name = "liquifier-3",
		level_name = "liquifier-3-level-",
		max_level = 50,
		next_machine = "liquifier-4"
	},
	["liquifier-4"] = {
		name = "liquifier-4",
		level_name = "liquifier-4-level-",
		max_level = 100
	},
	["crystallizer"] = {
		name = "crystallizer",
		level_name = "crystallizer-level-",
		max_level = 50,
		next_machine = "crystallizer-2"
	},
	["crystallizer-2"] = {
		name = "crystallizer-2",
		level_name = "crystallizer-2-level-",
		max_level = 100
	},
	["angels-electrolyser"] = {
		name = "angels-electrolyser",
		level_name = "angels-electrolyser-level-",
		max_level = 25
	},
	["angels-electrolyser-2"] = {
		name = "angels-electrolyser-2",
		level_name = "angels-electrolyser-2-level-",
		max_level = 25
	},
	["angels-electrolyser-3"] = {
		name = "angels-electrolyser-3",
		level_name = "angels-electrolyser-3-level-",
		max_level = 25
	},
	["angels-electrolyser-4"] = {
		name = "angels-electrolyser-4",
		level_name = "angels-electrolyser-4-level-",
		max_level = 100
	},
	["algae-farm"] = {
		name = "algae-farm",
		level_name = "algae-farm-level-",
		max_level = 25
	},
	["algae-farm-2"] = {
		name = "algae-farm-2",
		level_name = "algae-farm-2-level-",
		max_level = 25
	},
	["algae-farm-3"] = {
		name = "algae-farm-3",
		level_name = "algae-farm-3-level-",
		max_level = 25
	},
	["algae-farm-4"] = {
		name = "algae-farm-4",
		level_name = "algae-farm-4-level-",
		max_level = 100
	}
}

exponent = settings.global["factory-levels-exponent"].value
max_level = 1
function update_machine_levels(overwrite)
	if overwrite then
		max_level = 1    -- Just in case another mod cuts the max level of this mods machines to something like 25.
		required_items_for_levels = {}
		exponent = settings.global["factory-levels-exponent"].value
		for _, machine in pairs(machines) do
			if max_level < machine.max_level then
				max_level = machine.max_level
			end
		end
	end
	for i = 1, (max_level + 1), 1 do -- Adding one more level for machine upgrade to next tier.
		if required_items_for_levels[i] == nil then
			table.insert(required_items_for_levels, math.floor(1 + math.pow(i, exponent)))
		end
	end
end

remote.add_interface("factory_levels", {
	add_machine = function(machine)
		if machine.name == nil or machine.level_name == nil or machine.max_level == nil then
			return false
		else
			machines[machine.name] = machine
			if machine.max_level > max_level then
				max_level = machine.max_level
				update_machine_levels()
			end
			return true
		end
	end,
	update_machine = function(machine)
		if machine.name == nil or machines[machine.name] == nil then
			return false
		else
			machines[machine.name].level_name = machine.level_name or machines[machine.name].level_name
			machines[machine.name].max_level = machine.max_level or machines[machine.name].max_level
			machines[machine.name].next_machine = machine.next_machine or machines[machine.name].next_machine
			machines[machine.name].disable_mod_setting = machine.disable_mod_setting or machines[machine.name].disable_mod_setting
			if machines[machine.name].max_level > max_level then
				max_level = machines[machine.name].max_level
				update_machine_levels()
			end
			return true
		end
	end,
	remove_machine = function(machine_name)
		if machine_name == nil or machines[machine_name] == nil then
			return false
		end
		machines[machine_name] = nil
		return true
	end,
	get_machine = function(machine_name)
		if machine_name == nil then
			return nil
		end
		return machines[machine_name]
	end
})

required_items_for_levels = {
}

update_machine_levels(true)

function determine_level(finished_products_count)
	local should_have_level = 1

	for level, min_count_required_for_level in pairs(required_items_for_levels) do
		if finished_products_count >= min_count_required_for_level then
			should_have_level = level
		end
	end

	return should_have_level
end

function determine_machine(entity)
	if settings.global["factory-levels-disable-mod"].value then
		return nil
	end
	if entity == nil or not entity.valid or (entity.type ~= "assembling-machine" and entity.type ~= "furnace") then
		return nil
	end
	for _, machine in pairs(machines) do
		if entity.name == machine.name or string_starts_with(entity.name, machine.level_name) then
			return machine
		end
	end
	return nil
end

function get_inventory_contents(inventory)
	inventory_results = {}
	if inventory == nil then
		return inventory_results
	end

	inventory_contents = inventory.get_contents()
	for name, count in pairs(inventory_contents) do
		table.insert(inventory_results, { name = name, count = count })
	end
	return inventory_results
end

function insert_inventory_contents(inventory, contents)
	if inventory == nil or not inventory.is_empty() then
		return
	end
	for _, item in pairs(contents) do
		inventory.insert(item)
	end
end

function upgrade_factory(surface, targetname, sourceentity)
	local finished_products_count = sourceentity.products_finished
	local box = sourceentity.bounding_box
	local item_requests = nil
	local recipe = nil

	local existing_requests = surface.find_entity("item-request-proxy", sourceentity.position)
	if existing_requests then
		-- Module requests do not survive the machine being replaced.  Preserve them before the machine is replaced.
		item_requests = {}
		for module_name, count in pairs(existing_requests.item_requests) do
			item_requests[module_name] = count
		end
		if next(item_requests, nil) == nil then
			item_requests = nil
		end
	end

	-- For unknown reasons, Factorio is voiding ALL of the inventories of the machine.
	local input_inventory = {}
	if sourceentity.type == "assembling-machine" then
		input_inventory = get_inventory_contents(sourceentity.get_inventory(defines.inventory.assembling_machine_input))
	elseif sourceentity.type == "furnace" then
		input_inventory = get_inventory_contents(sourceentity.get_inventory(defines.inventory.furnace_source))
	end
	local output_inventory = get_inventory_contents(sourceentity.get_output_inventory())
	local module_inventory = get_inventory_contents(sourceentity.get_module_inventory())
	local fuel_inventory = get_inventory_contents(sourceentity.get_fuel_inventory())
	local burnt_result_inventory = get_inventory_contents(sourceentity.get_burnt_result_inventory())

	global.built_machines[sourceentity.unit_number] = nil
	if sourceentity.type == "assembling-machine" then
		-- Recipe should survive, but why take that chance.
		recipe = sourceentity.get_recipe()
	end

	local created = surface.create_entity { name = targetname,
											source = sourceentity,
											direction = sourceentity.direction,
											raise_built = true,
											fast_replace = true,
											spill = false,
											create_build_effect_smoke = false,
											position = sourceentity.position,
											force = sourceentity.force }

	global.built_machines[created.unit_number] = { entity = created, unit_number = created.unit_number }
	if item_requests then
		surface.create_entity({ name = "item-request-proxy",
								position = created.position,
								force = created.force,
								target = created,
								modules = item_requests })
	end

	sourceentity.destroy()

	created.products_finished = finished_products_count;
	if created.type == "assembling-machine" and recipe ~= nil then
		created.set_recipe(recipe)
	end

	if created.type == "assembling-machine" then
		insert_inventory_contents(created.get_inventory(defines.inventory.assembling_machine_input), input_inventory)
	elseif created.type == "furnace" then
		insert_inventory_contents(created.get_inventory(defines.inventory.furnace_source), input_inventory)
	end
	insert_inventory_contents(created.get_output_inventory(), output_inventory)
	insert_inventory_contents(created.get_module_inventory(), module_inventory)
	insert_inventory_contents(created.get_fuel_inventory(), fuel_inventory)
	insert_inventory_contents(created.get_burnt_result_inventory(), burnt_result_inventory)

	local old_on_ground = surface.find_entities_filtered { area = box, name = 'item-on-ground' }
	for _, item in pairs(old_on_ground) do
		item.destroy()
	end

	return created
end

function replace_machines(entities)
	for _, entity in pairs(entities) do
		local should_have_level = determine_level(entity.products_finished)
		for _, machine in pairs(machines) do
			if (entity.name == machine.name and entity.products_finished > 0) then
				if not settings.global["factory-levels-disable-mod"].value then
					if not machine.disable_mod_setting or not settings.global[machine.disable_mod_setting].value then
						upgrade_factory(entity.surface, machine.level_name .. math.min(should_have_level, machine.max_level), entity)
					end
				end
				break
			elseif string_starts_with(entity.name, machine.level_name) then
				local current_level = tonumber(string.match(entity.name, "%d+$"))
				if (settings.global["factory-levels-disable-mod"].value) or (machine.disable_mod_setting and settings.global[machine.disable_mod_setting].value) then
					upgrade_factory(entity.surface, machine.name, entity)
					break
				elseif (should_have_level > current_level and current_level < machine.max_level) then
					upgrade_factory(entity.surface, machine.level_name .. math.min(should_have_level, machine.max_level), entity)
					break
				elseif (should_have_level > current_level and current_level >= machine.max_level and machine.next_machine ~= nil) then
					local created = upgrade_factory(entity.surface, machine.next_machine, entity)
					created.products_finished = 0
					break
				end
			end
		end
	end
end

function get_next_machine()
	if global.current_machine == nil or global.check_machines == nil then
		global.check_machines = table.deepcopy(global.built_machines)
	end
	global.current_machine = next(global.check_machines, global.current_machine)
end

script.on_nth_tick(6, function(event)


	local assemblers = {}
	for i = 1, 100 do
		get_next_machine()
		if i == 1 and global.current_machine == nil then
			return
		end
		if global.current_machine == nil then
			break
		end
		entity = global.check_machines[global.current_machine]
		if entity and entity.entity and entity.entity.valid then
			table.insert(assemblers, entity.entity)
		else
			global.built_machines[global.current_machine] = nil
		end
	end
	replace_machines(assemblers)
end)

function on_mined_entity(event)
	if (event.entity ~= nil and event.entity.products_finished ~= nil and event.entity.products_finished > 0) then
		global.built_machines[event.entity.unit_number] = nil
		if event.entity.type == "furnace" then
			table.insert(global.stored_products_finished_furnaces, event.entity.products_finished)
			table.sort(global.stored_products_finished_furnaces)
		end

		if event.entity.type == "assembling-machine" then
			table.insert(global.stored_products_finished_assemblers, event.entity.products_finished)
			table.sort(global.stored_products_finished_assemblers)
		end
	end
end

script.on_event(
		defines.events.on_player_mined_entity,
		on_mined_entity,
		{ { filter = "type", type = "assembling-machine" },
		  { filter = "type", type = "furnace" } })

script.on_event(
		defines.events.on_robot_mined_entity,
		on_mined_entity,
		{ { filter = "type", type = "assembling-machine" },
		  { filter = "type", type = "furnace" } })

function replace_built_entity(entity, finished_product_count)
	global.built_machines[entity.unit_number] = { entity = entity, unit_number = entity.unit_number }
	local machine = determine_machine(entity)
	if finished_product_count ~= nil then
		local should_have_level = determine_level(finished_product_count)
		entity.products_finished = finished_product_count

		local created_entity_name = entity.name
		if machine ~= nil then
			local created = upgrade_factory(entity.surface, machine.level_name .. math.min(should_have_level, machine.max_level), entity)
			created.products_finished = finished_product_count
		end
	else
		if machine ~= nil and machine.name ~= entity.name then
			upgrade_factory(entity.surface, machine.name, entity)
		end
	end
end

function on_built_entity(event)
	if (event.created_entity ~= nil and event.created_entity.type == "assembling-machine") then
		local finished_product_count = table.remove(global.stored_products_finished_assemblers)
		replace_built_entity(event.created_entity, finished_product_count)
		return
	end

	if (event.created_entity ~= nil and event.created_entity.type == "furnace") then
		local finished_product_count = table.remove(global.stored_products_finished_furnaces)
		replace_built_entity(event.created_entity, finished_product_count)
		return
	end
end

function on_runtime_mod_setting_changed(event)
	if event.setting == "factory-levels-disable-mod" then
		-- Refresh EVERY machine immediately.  User potentially wishes to remove this mod or some other mod that depends on this mod.
		get_built_machines()
	elseif event.setting == "factory-levels-exponent" then
		update_machine_levels(true)
		if required_items_for_levels[25] then
			game.print("Crafts for Level 25: " .. required_items_for_levels[25])
		end
		if required_items_for_levels[50] then
			game.print("Crafts for Level 50: " .. required_items_for_levels[50])
		end
		if required_items_for_levels[100] then
			game.print("Crafts for Level 100: " .. required_items_for_levels[100])
		end
		if max_level ~= 100 then
			game.print("Crafts for Max level of " .. max_level .. ": " .. required_items_for_levels[max_level])
		end
	else
		update_machines = false
		for machine_name, machine in pairs(machines) do
			if event.setting == machine.disable_mod_setting then
				update_machines = true
			end
		end
		if update_machines then
			get_built_machines()
		end
	end
end

script.on_event(
		defines.events.on_robot_built_entity,
		on_built_entity,
		{ { filter = "type", type = "assembling-machine" },
		  { filter = "type", type = "furnace" } })

script.on_event(
		defines.events.on_built_entity,
		on_built_entity,
		{ { filter = "type", type = "assembling-machine" },
		  { filter = "type", type = "furnace" } })

script.on_event(
		defines.events.on_runtime_mod_setting_changed,
		on_runtime_mod_setting_changed)
