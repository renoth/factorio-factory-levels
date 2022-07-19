script.on_init(function()

end)

script.on_load(function()

end)


requireditems = {
}

for i = 1, 100, 1 do
    table.insert(requireditems, 10 + i * 25)
end

function upgrade_factory(surface, targetname, sourceentity)
    log(serpent.block(entity))
    local createdentity = surface.create_entity { name = targetname,
                            source = sourceentity,
                            fast_replace = true,
                            position = sourceentity.position,
                            force = "player" }
    createdentity.products_finished = sourceentity.products_finished
    sourceentity.destroy()
end

function replace_assembler(entities, surface)
    for _, entity in pairs(entities) do
        if (entity.name == "assembling-machine-1" and entity.products_finished > 0) then
            upgrade_factory(surface, "assembling-machine-level-1", entity)
        else
            local currentlevel = tonumber(string.match(entity.name, "%d+$"))
            log(currentlevel)
            if (entity.products_finished > requireditems[currentlevel] and currentlevel < 100) then
                upgrade_factory(surface, "assembling-machine-level-" .. (currentlevel + 1), entity)
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