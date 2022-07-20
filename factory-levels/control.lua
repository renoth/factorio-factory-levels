script.on_init(function()

end)

script.on_load(function()

end)

function string_starts_with(str, start)
    return str:sub(1, #start) == start
end

requireditems_assembler1 = {
}

for i = 1, 25, 1 do
    table.insert(requireditems_assembler1, math.floor(10 + math.pow(i, 2.86136))) -- level 25 is 10k items
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
end

function replace_assembler(entities, surface)
    for _, entity in pairs(entities) do
        if (entity.name == "assembling-machine-1" and entity.products_finished > 0) then
            upgrade_factory(surface, "assembling-machine-1-level-1", entity)
        elseif string_starts_with(entity.name, "assembling-machine-1-level-") then
            local currentlevel = tonumber(string.match(entity.name, "%d+$"))
            if (entity.products_finished > requireditems_assembler1[currentlevel] and currentlevel < 25) then
                upgrade_factory(surface, "assembling-machine-1-level-" .. (currentlevel + 1), entity)
            elseif (currentlevel == 25 and entity.name == "assembling-machine-1-level-25") then
                upgrade_factory(surface, "assembling-machine-2", entity)
            end
        end
    end
end

script.on_nth_tick(200, function(event)
    for _, surface in pairs(game.surfaces) do
        local assemblers = surface.find_entities_filtered { type = "assembling-machine" }
        replace_assembler(assemblers, surface)
    end
end)