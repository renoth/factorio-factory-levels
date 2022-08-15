script.on_init(function()
	global.stored_products_finished_assemblers = { }
	global.stored_products_finished_furnaces = { }
end)

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
	for i = 1, max_level, 1 do
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

-- global iterators for surfaces
local function copy_surfaces()
	--surfaces have to be cached because next() does not work on custom-dict ( game.surfaces )
	global.surfaces = {}
	for k, v in pairs(game.surfaces) do
		global.surfaces[k] = v
	end
	-- global.surfaces should never be empty because Nauvis cannot be deleted; Get first index of this table
	global.current_surface_iter_index = next(global.surfaces, nil)
end

local function update_surface_iter_index()
	--Inputting a nil value to next() will get the first table index.
	--Occasionally next will return nil, and we want to skip nil indexes
	if global.surfaces == nil then
		copy_surfaces()
	end

	global.current_surface_iter_index = next(global.surfaces, global.current_surface_iter_index)

	if global.current_surface_iter_index == nil then
		global.current_surface_iter_index = next(global.surfaces, global.current_surface_iter_index)
	end
end

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

function upgrade_factory(surface, targetname, sourceentity)
	local count = sourceentity.products_finished
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
	end
	
	local existing_modules = sourceentity.get_module_inventory()
	modules_to_insert = {}
	if existing_modules ~= nil then
		existing_modules = existing_modules.get_contents()
		for name, count in pairs(existing_modules) do
			table.insert(modules_to_insert, {name=name, count=count})
		end
	end

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

	if item_requests then
		surface.create_entity({ name = "item-request-proxy",
								position = created.position,
								force = created.force,
								target = created,
								modules = item_requests })
	end
	new_modules = created.get_module_inventory()
	if existing_modules and new_modules then
		if new_modules.is_empty() then
			for _, module_set in pairs(modules_to_insert) do
				new_modules.insert(module_set)
			end
		end
	end

	sourceentity.destroy()

	created.products_finished = count;
	if created.type == "assembling-machine" and recipe ~= nil then
		created.set_recipe(recipe)
	end

	local old_on_ground = surface.find_entities_filtered { area = box, name = 'item-on-ground' }
	for _, item in pairs(old_on_ground) do
		item.destroy()
	end

	return created
end

function replace_machines(entities, surface)
	for _, entity in pairs(entities) do
		local should_have_level = determine_level(entity.products_finished)
		for _, machine in pairs(machines) do
			if (entity.name == machine.name and entity.products_finished > 0) then
				upgrade_factory(surface, machine.level_name .. math.min(should_have_level, machine.max_level), entity)
				break
			elseif string_starts_with(entity.name, machine.level_name) then
				local current_level = tonumber(string.match(entity.name, "%d+$"))
				if (should_have_level > current_level and current_level < machine.max_level) then
					upgrade_factory(surface, machine.level_name .. math.min(should_have_level, machine.max_level), entity)
					break
				elseif (current_level == machine.max_level and machine.next_machine ~= nil) then
					local created = upgrade_factory(surface, machine.next_machine, entity)
					created.products_finished = 0
					break
				end
			end
		end
	end
end

script.on_nth_tick(10, function(event)

	--If current iterator index is nil, then we start with the first surface.
	if global.surfaces == nil then
		copy_surfaces()
	end

	--The following if statement should only execute as true on the first pass
	if global.surface_iterator == nil then
		local curr_surface = global.surfaces[global.current_surface_iter_index]
		global.surface_iterator = curr_surface.get_chunks()
	end

	-- iterate over chunks instead of all at once (abysmal performance on large maps or slow computers)
	for i = 1, 10 do
		-- if chunk_iterator() returns nil then move to next surface index.
		local chunk = global.surface_iterator()
		--surface iterator returns nil when it reaches the last chunk on the surface OR if the surface is deleted (tested in 0.17.54)
		if chunk == nil then
			--Each tick_freq the game will evaluate a cached surface; if invalid it will cycle global.current_surface_iter_index
			update_surface_iter_index()
			global.surface_iterator = global.surfaces[global.current_surface_iter_index].get_chunks()
		else
			--include logic here to scan each surface @ chunk.
			local surface = global.surfaces[global.current_surface_iter_index]

			if surface == nil then
				return
			end

			local area = { { chunk.x * 32 - 16, chunk.y * 32 - 16 }, { chunk.x * 32 + 16, chunk.y * 32 + 16 } }
			local assemblers = surface.find_entities_filtered { type = { "assembling-machine", "furnace" }, area = area }
			replace_machines(assemblers, surface)
			-- debug
			-- rendering.draw_rectangle { color = { r = 1, g = 0, b = 0, a = 0.5 }, left_top = { chunk.x * 32 - 16, chunk.y * 32 - 16 }, right_bottom = { chunk.x * 32 + 16, chunk.y * 32 + 16 }, filled = true, surface = surface, time_to_live = 60 }
		end
	end
end)

function on_mined_entity(event)
	if (event.entity ~= nil and event.entity.products_finished ~= nil and event.entity.products_finished > 0) then
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
