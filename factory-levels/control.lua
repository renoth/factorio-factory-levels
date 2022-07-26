script.on_init(function()
	global.stored_products_finished_assemblers = { 1000000, 55555 }
	global.stored_products_finished_furnaces = { 1000000, 55555 }
end)

script.on_load(function()
end)

function string_starts_with(str, start)
	return str:sub(1, #start) == start
end

machines = {
	-- Assemblers
	{
		name = "assembling-machine-1",
		level_name = "assembling-machine-1-level-",
		max_level = 25,
		next_machine = "assembling-machine-2"
	},
	{
		name = "assembling-machine-2",
		level_name = "assembling-machine-2-level-",
		max_level = 50,
		next_machine = "assembling-machine-3"
	},
	{
		name = "assembling-machine-3",
		level_name = "assembling-machine-3-level-",
		max_level = 100
	},

	-- Smelters
	{
		name = "stone-furnace",
		level_name = "stone-furnace-level-",
		max_level = 25,
		next_machine = "steel-furnace"
	},
	{
		name = "steel-furnace",
		level_name = "steel-furnace-level-",
		max_level = 100
	}
}

remote.add_interface("factory_levels", {
	add_machine = function(machine)
		if machine.name == nil or machine.level_name == nil or machine.max_level == nil then
			return false
		else
			table.insert(machines, machine)
			for i = 1, machine.max_level, 1 do
				if required_items_for_levels[i] == nil then
					table.insert(required_items_for_levels, math.floor(1 + math.pow(i, exponent)))
				end
			end
			return true
		end
	end
})

required_items_for_levels = {
}

exponent = settings.startup["factory-levels-exponent"].value

for i = 1, 100, 1 do
	table.insert(required_items_for_levels, math.floor(1 + math.pow(i, exponent)))
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
	
	if sourceentity.type == "assembling-machine" then
		-- Recipe should survive, but why take that chance.
		recipe = sourceentity.get_recipe()
	end
	
	local created = surface.create_entity { name = targetname,
											source = sourceentity,
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
											
	created.products_finished = count;
	if created.type == "assembling-machine" and recipe ~= nil then
		created.set_recipe(recipe)
	end
	sourceentity.destroy()

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

script.on_nth_tick(300, function(event)
	for _, surface in pairs(game.surfaces) do
		local assemblers = surface.find_entities_filtered { type = { "assembling-machine", "furnace" } }
		replace_machines(assemblers, surface)
	end
end)

script.on_event(
		defines.events.on_player_mined_entity,
		function(event)
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
		end,
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