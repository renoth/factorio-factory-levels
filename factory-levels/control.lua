script.on_init(function()
    global.stored_products_finished_assemblers = {}
    global.stored_products_finished_furnaces = {}
end)

script.on_load(function()
    log(serpent.block(global.stored_products_finished_assemblers))
    log(serpent.block(global.stored_products_finished_furnaces))
end)

function string_starts_with(str, start)
    return str:sub(1, #start) == start
end

requireditems_assembler1 = {
}

requireditems_assembler2 = {
}

requireditems_assembler3 = {
}

for i = 1, 25, 1 do
    table.insert(requireditems_assembler1, math.floor(10 + math.pow(i, 2.86136))) -- level 25 is 10k items
end

for i = 1, 50, 1 do
    table.insert(requireditems_assembler2, math.floor(10 + math.pow(i, 3))) -- level 50 is 125k items
end

for i = 1, 100, 1 do
    table.insert(requireditems_assembler3, math.floor(10 + math.pow(i, 3))) -- level 100 is 1M items
end

function upgrade_factory(surface, targetname, sourceentity)
    local count = sourceentity.products_finished
    local box = sourceentity.bounding_box
    local created = surface.create_entity { name = targetname,
                                            source = sourceentity,
                                            fast_replace = true,
                                            create_build_effect_smoke = false,
                                            position = sourceentity.position,
                                            force = "player" }
    created.products_finished = count;
    sourceentity.destroy()

    local old_on_ground = surface.find_entities_filtered { area = box, name = 'item-on-ground' }
    for _, item in pairs(old_on_ground) do
        item.destroy()
    end

    return created
end

function replace_assembler(entities, surface)
    for _, entity in pairs(entities) do
        if (entity.name == "assembling-machine-1" and entity.products_finished > 0) then
            upgrade_factory(surface, "assembling-machine-1-level-1", entity)
        elseif (entity.name == "assembling-machine-2" and entity.products_finished > 0) then
            upgrade_factory(surface, "assembling-machine-2-level-1", entity)
        elseif (entity.name == "assembling-machine-3" and entity.products_finished > 0) then
            upgrade_factory(surface, "assembling-machine-3-level-1", entity)
        elseif string_starts_with(entity.name, "assembling-machine-1-level-") then
            local currentlevel = tonumber(string.match(entity.name, "%d+$"))
            if (entity.products_finished > requireditems_assembler1[currentlevel] and currentlevel < 25) then
                upgrade_factory(surface, "assembling-machine-1-level-" .. (currentlevel + 1), entity)
            elseif (currentlevel == 25 and entity.name == "assembling-machine-1-level-25") then
                local created = upgrade_factory(surface, "assembling-machine-2", entity)
                created.products_finished = 0
            end
        elseif string_starts_with(entity.name, "assembling-machine-2-level-") then
            local currentlevel = tonumber(string.match(entity.name, "%d+$"))
            if (entity.products_finished > requireditems_assembler2[currentlevel] and currentlevel < 50) then
                upgrade_factory(surface, "assembling-machine-2-level-" .. (currentlevel + 1), entity)
            elseif (currentlevel == 50 and entity.name == "assembling-machine-2-level-50") then
                local created = upgrade_factory(surface, "assembling-machine-3", entity)
                created.products_finished = 0
            end
        elseif string_starts_with(entity.name, "assembling-machine-3-level-") then
            local currentlevel = tonumber(string.match(entity.name, "%d+$"))
            if (entity.products_finished > requireditems_assembler3[currentlevel] and currentlevel < 100) then
                upgrade_factory(surface, "assembling-machine-3-level-" .. (currentlevel + 1), entity)
            end
        end
    end
end

function replace_smelters(entities, surface)
    for _, entity in pairs(entities) do
        local currentlevel = tonumber(string.match(entity.name, "%d+$"))

        if (entity.name == "stone-furnace" and entity.products_finished > 0) then
            upgrade_factory(surface, "stone-furnace-level-1", entity)

        elseif (entity.name == "steel-furnace" and entity.products_finished > 0) then
            upgrade_factory(surface, "steel-furnace-level-1", entity)
        elseif string_starts_with(entity.name, "stone-furnace-level-") then
            if (entity.products_finished > requireditems_assembler1[currentlevel] and currentlevel < 25) then
                upgrade_factory(surface, "stone-furnace-level-" .. (currentlevel + 1), entity)
            elseif (currentlevel == 25 and entity.name == "stone-furnace-level-25") then
                local created = upgrade_factory(surface, "steel-furnace", entity)
                created.products_finished = 0
            end
        elseif string_starts_with(entity.name, "steel-furnace-level-") then
            if (entity.products_finished > requireditems_assembler2[currentlevel] and currentlevel < 100) then
                upgrade_factory(surface, "steel-furnace-level-" .. (currentlevel + 1), entity)
            end
        end
    end
end

script.on_nth_tick(300, function(event)
    for _, surface in pairs(game.surfaces) do
        local assemblers = surface.find_entities_filtered { type = "assembling-machine" }
        replace_assembler(assemblers, surface)

        local smelters = surface.find_entities_filtered { type = "furnace" }
        replace_smelters(smelters, surface)
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

script.on_event(
        defines.events.on_built_entity,
        function(event)
            if event.created_entity ~= nil then
                if (event.created_entity.type == "assembling-machine" and next(global.stored_products_finished_assemblers) ~= nil) then
                    event.created_entity.products_finished = table.remove(global.stored_products_finished_assemblers)
                end

                if (event.created_entity.type == "furnace" and next(global.stored_products_finished_furnaces) ~= nil) then
                    event.created_entity.products_finished = table.remove(global.stored_products_finished_furnaces)
                end
            end
        end,
        { { filter = "type", type = "assembling-machine" },
          { filter = "type", type = "furnace" } })